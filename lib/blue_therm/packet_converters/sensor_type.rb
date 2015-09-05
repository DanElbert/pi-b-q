module BlueTherm
  module PacketConverters
    class SensorType < Base
      def to(bytes)
        bytes
      end

      def from(bytes)
        bytes
      end
    end
  end
end