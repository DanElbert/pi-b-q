module BlueTherm
  module PacketConverters
    class Battery < Base
      include LittleEndian

      def deserialize_implementation(bytes)
        raw_value = bytes_to_integer(bytes)
        raw_value / 1000.0
      end

      def serialize_implementation(data)
        integer_to_bytes(data * 1000, 2)
      end

    end
  end
end