module BlueTherm
  module PacketConverters
    class Word < Base
      include LittleEndian

      # Converts from raw packet bytes to a single word (integer)
      def to(bytes)
        raise "Invalid byte array: #{bytes}" unless bytes.length == 2
        bytes_to_integer(bytes)
      end

      # Converts from a word (single int) to a pair of packet bytes
      def from(word)
        integer_to_bytes(word, 2)
      end

    end
  end
end