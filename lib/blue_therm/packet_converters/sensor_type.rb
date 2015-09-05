module BlueTherm
  module PacketConverters
    class SensorType < Base

      def deserialize_implementation(bytes)
        bytes
      end

      def serialize_implementation(bytes)
        bytes
      end

    end
  end
end