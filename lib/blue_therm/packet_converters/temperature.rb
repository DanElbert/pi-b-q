module BlueTherm
  module PacketConverters
    class Temperature < Base
      include LittleEndian

      def to(bytes)
        raise "Invalid byte array: #{bytes}" unless bytes.length == 2
        raw_value = bytes_to_integer(bytes)
        (raw_value / 100_000.0) - 300.0
      end

      def from(temp)
        raw_value = ((temp + 300) * 100_000).to_i
        integer_to_bytes(raw_value, 4)
      end

    end
  end
end