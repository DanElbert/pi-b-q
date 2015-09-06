module BlueTherm
  module PacketConverters
    class DataFlags < Base
      include LittleEndian

      def deserialize_implementation(bytes)
        raw_value = bytes_to_integer(bytes)
        BlueTherm::DataFlags.new(raw_value)
      end

      def serialize_implementation(flags)
        integer_to_bytes(flags.word, 2)
      end

    end
  end
end