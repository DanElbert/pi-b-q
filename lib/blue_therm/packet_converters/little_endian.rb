module BlueTherm
  module PacketConverters
    module LittleEndian

      # Takes an array of bytes and converts to a single integer (assuming little endian byte order)
      def bytes_to_integer(bytes)
        integer = 0
        bytes.each_with_index { |b, i| integer += (b << (8 * i)) }
        integer
      end

      # Converts an integer to an array of length bytes in little endian order
      def integer_to_bytes(integer, length)
        length.times.map { |i| (integer >> (i * 8)) & 0xFF }
      end
    end
  end
end