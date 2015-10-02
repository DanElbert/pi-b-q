module BlueTherm
  module PacketConverters
    class Temperature < Base
      include LittleEndian

      def deserialize_implementation(bytes)
        raw_value = bytes_to_integer(bytes)
        if raw_value >= 0xFFFFFFFD
          0
        else
          (raw_value / 100_000.0) - 300.0
        end
      end

      def serialize_implementation(temp)
        raw_value = ((temp + 300) * 100_000).to_i
        integer_to_bytes(raw_value, 4)
      end

    end
  end
end