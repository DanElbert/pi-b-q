module BlueTherm
  module PacketConverters
    class String < Base

      # Converts from raw packet bytes to a string
      def to(bytes)
        sub_bytes = bytes.take_while { |b| b != 0 }
        sub_bytes.pack('C*')
      end

      # Converts from a string to a an array of bytes of the given length
      def from(string)
        bytes = string.encode('ASCII').bytes
        raise "string #{string} is too long to fit in #{@length} bytes" unless bytes.length < @length
        @length.times.map { |i| bytes[i] || 0 }
      end

    end
  end
end