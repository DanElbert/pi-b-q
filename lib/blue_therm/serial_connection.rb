module BlueTherm
  class SerialConnection
    include Observable

    # Number of seconds before a partial packet is considered to be an error
    MAX_MESSAGE_DELAY = 5

    # Number of seconds to wait between calling read on the serial device
    READ_WAIT = 0.5

    # Number of seconds to wait before declaring a send / response timeout
    MAX_RESPONSE_WAIT = 5

    # Number of seconds to wait between checking for a response to a sent packet
    RESPONSE_WAIT = 0.1

    module MessageType
      ERROR = 1,
      DO_NOTHING = 2,
      RETRIEVE_INFORMATION = 3,
      SET_INFORMATION = 4,
      BUTTON_PRESS = 5,
      SHUT_DOWN = 6

      def self.convert_from_command_id(id)
        #TODO: set these constants to match the command_ids, like a sane person
        case id
          when 0
            DO_NOTHING
          when 1
            RETRIEVE_INFORMATION
          when 2
            SET_INFORMATION
          when 3
            BUTTON_PRESS
          when 5
            SHUT_DOWN
          else
            ERROR
        end
      end
    end

    Message = Struct.new(:timestamp, :type, :packet)

    class SendReceiveObserver
      def initialize(&block)
        @block = block
      end

      def update(msg)
        @block.call(msg)
      end
    end

    def initialize(serial_port)
      @serial = serial_port
      @incoming_q = Queue.new
      @serial_mutex = Mutex.new

      @read_thread = Thread.new { read_loop }
      @read_thread.abort_on_exception = true
    end

    def close
      @read_thread.kill
    end

    def process_messages
      until @incoming_q.empty?
        m = @incoming_q.pop
        self.changed
        self.notify_observers(m)
      end
    end

    def on_button(&block)
      on_message(MessageType::BUTTON_PRESS, &block)
    end

    def on_error(&block)
      on_message(MessageType::ERROR, &block)
    end

    def on_retrieve(&block)
      on_message(MessageType::RETRIEVE_INFORMATION, &block)
    end

    def on_message(type, &block)
      observer = SendReceiveObserver.new do |m|
        if m.type == type
          yield(m)
        end
      end

      self.add_observer(observer)
    end

    def read_loop
      @serial_mutex.synchronize { @serial.flush_input }
      buffer = ''
      last_read = Time.now - 100_000 # set last read to a bit over a day ago
      while true

        if buffer.length > 0 && (Time.now - last_read) >= MAX_MESSAGE_DELAY
          # We have a partial buffer and it's been too long to expect the message to finish; consider the current buffer
          # to be toast
          @incoming_q << Message.new(Time.now, MessageType::ERROR, buffer)
          buffer = ''
        end

        begin
          @serial_mutex.synchronize { data = @serial.read_nonblock(128) }
          if data.length > 0
            last_read = Time.now
            buffer += data
          end

          if buffer.length >= 128
            p = BlueTherm::Packet.deserialize(buffer[0...128])
            if p.verify_checksum
              @incoming_q << Message.new(Time.now, MessageType.convert_from_command_id(p.command_id), p)
            else
              @incoming_q << Message.new(Time.now, MessageType::ERROR, p)
            end

            buffer = buffer[128..-1]
          end

        rescue IO::WaitReadable, EOFError
          sleep READ_WAIT
        end
      end
    end

    def send(packet)
      data = packet.serialize
      now = Time.now
      response = nil

      observer = SendReceiveObserver.new do |m|
        if m.type == MessageType::RETRIEVE_INFORMATION && m.timestamp >= now
          response = m
          self.delete_observer(observer)
        end
      end

      self.add_observer(observer)

      @serial_mutex.synchronize { @serial.write(data) }

      until response || ((Time.now - now) >= MAX_RESPONSE_WAIT)
        sleep RESPONSE_WAIT
        self.process_messages
      end

      if response
        response.packet
      else
        raise BlueTherm::TimeoutError
      end
    end

  end
end