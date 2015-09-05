module BlueTherm
  module PacketConverters
    class Base

      attr_reader :length

      def initialize(length)
        @length = length
      end

      # Converts from a byte array to the desired type
      def to(bytes)
        bytes
      end

      # Converts from the type to a byte array
      def from(data)
        data
      end

    end
  end
end