module BlueTherm
  module PacketConverters
    class Base

      attr_reader :length

      def initialize(length)
        @length = length
      end

      # Converts from a byte array to the desired type
      def deserialize(bytes)
        raise "Invalid byte count: #{bytes}. Expected length of #{length}" if bytes.length != length
        deserialize_implementation(bytes)
      end

      # Converts from the type to a byte array
      def serialize(data)
        bytes = serialize_implementation(data)
        raise "Invalid byte count: #{bytes}. Expected length of #{length}" if bytes.length != length
        bytes
      end

      protected

      def deserialize_implementation(bytes)
        raise "Not Implemented"
      end

      def serialize_implementation(data)
        raise "Not Implemented"
      end

    end
  end
end