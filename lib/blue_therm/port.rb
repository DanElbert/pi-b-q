module BlueTherm
  class Port

    def initialize(serial_port)
      @serial = SerialPort.new(serial_port)
    end

    def send(packet)
      data = packet.data.pack("C*")

      @serial.write(data)

      returned  = ''

      while returned.length < 128
        returned << @serial.readpartial(128)
      end

      Packet.new(returned.unpack("C*"))
    end

  end
end