module BlueTherm
  module PacketConverters
    class Date < Base
      include LittleEndian

      EPOCH = Time.new(2005, 1, 1, 0, 0)

      def deserialize_implementation(bytes)
        seconds = bytes_to_integer(bytes)
        EPOCH + seconds
      end

      def serialize_implementation(date)
        seconds = date - EPOCH
        integer_to_bytes(seconds, 4)
      end

    end
  end
end