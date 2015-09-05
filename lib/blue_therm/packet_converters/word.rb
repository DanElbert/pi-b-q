module BlueTherm
  module PacketConverters
    class Word < Base
      include LittleEndian

      # Converts from raw packet bytes to a single word (integer)
      def deserialize_implementation(bytes)
        bytes_to_integer(bytes)
      end

      # Converts from a word (single int) to a pair of packet bytes
      def serialize_implementation(word)
        integer_to_bytes(word, length)
      end

    end
  end
end