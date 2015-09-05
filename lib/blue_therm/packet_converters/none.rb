module BlueTherm
  module PacketConverters
    class None < Base

      def deserialize_implementation(bytes)
        if bytes.length == 1
          bytes.first
        else
          bytes
        end
      end

      def serialize_implementation(data)
        data = Array.wrap(data)
        if data.length < length
          (length - data.length).times { data << 0 }
        end
        data
      end

    end
  end
end