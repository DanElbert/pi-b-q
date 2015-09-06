module BlueTherm
  class Packet

    FIELDS = {
        command_id: {
            index: 0x0,
            converter: PacketConverters::None
        },
        version: {
            index: 0x1,
            converter: PacketConverters::None
        },
        retrieve_or_set_bits: {
            index: (0x2..0x3),
            converter: PacketConverters::DataFlags
        },
        serial_number: {
            index: (0x4..0xD),
            converter: PacketConverters::String
        },
        sensor_1_name: {
            index: (0xE..0x21),
            converter: PacketConverters::String
        },
        sensor_2_name: {
            index: (0x22..0x35),
            converter: PacketConverters::String
        },
        sensor_1_reading: {
            index: (0x36..0x39),
            converter: PacketConverters::Temperature
        },
        sensor_1_high_limit: {
            index: (0x3A..0x3D),
            converter: PacketConverters::Temperature
        },
        sensor_1_low_limit: {
            index: (0x3E..0x41),
            converter: PacketConverters::Temperature
        },
        sensor_1_trim: {
            index: (0x42..0x45),
            converter: PacketConverters::Temperature
        },
        sensor_1_trim_date: {
            index: (0x46..0x49),
            converter: PacketConverters::Date
        },
        sensor_2_reading: {
            index: (0x4A..0x4D),
            converter: PacketConverters::Temperature
        },
        sensor_2_high_limit: {
            index: (0x4E..0x51),
            converter: PacketConverters::Temperature
        },
        sensor_2_low_limit: {
            index: (0x52..0x55),
            converter: PacketConverters::Temperature
        },
        sensor_2_trim: {
            index: (0x56..0x59),
            converter: PacketConverters::Temperature
        },
        sensor_2_trim_date: {
            index: (0x5A..0x5D),
            converter: PacketConverters::Date
        },
        battery_volts: {
            index: (0x5E..0x5F),
            converter: PacketConverters::Battery
        },
        battery_temperature: {
            index: (0x60..0x63),
            converter: PacketConverters::Temperature
        },
        cal_value_1: {
            index: (0x64..0x67),
            converter: PacketConverters::Temperature
        },
        cal_value_2: {
            index: (0x68..0x6B),
            converter: PacketConverters::Temperature
        },
        cal_value_3: {
            index: (0x6C..0x6F),
            converter: PacketConverters::Temperature
        },
        probe_calibration_time: {
            index: (0x70..0x73),
            converter: PacketConverters::Date
        },
        firmware_version: {
            index: (0x74..0x77),
            converter: PacketConverters::None
        },
        sensor_1_type: {
            index: 0x78,
            converter: PacketConverters::SensorType
        },
        sensor_2_type: {
            index: 0x79,
            converter: PacketConverters::SensorType
        },
        user_data: {
            index: (0x7A..0x7D),
            converter: PacketConverters::None
        },
        checksum: {
            index: (0x7E..0x7F),
            converter: PacketConverters::Word
        }
    }

    def self.default
      p = self.new()
      p.command_id = 1
      p.version = 1
      p.retrieve_or_set_bits = DataFlags.default
      p.apply_checksum!
    end

    attr_reader :data

    def initialize(data = nil)
      @data = data || ([0] * 128)
    end

    def calculate_checksum
      CRC.checksum(self.data[(0..125)])
    end

    def apply_checksum!
      self.checksum = self.calculate_checksum
    end

    def verify_checksum!
      raise "Invalid checksum!" unless self.calculate_checksum == self.checksum
      true
    end

    FIELDS.each do |f, _|
      define_method f do
        get_field(f)
      end

      define_method "#{f}=".to_sym do |value|
        set_field(f, value)
      end
    end

    private

    def get_field(field)
      opts = FIELDS[field]
      raise "Unknown field: #{field}" unless opts

      raw_data = @data[opts[:index]]
      converter = opts[:converter].new(raw_data.length)

      converter.deserialize(raw_data)
    end

    def set_field(field, value)
      opts = FIELDS[field]
      raise "Unknown field: #{field}" unless opts

      range = opts[:index].is_a?(Numeric) ? (opts[:index]..opts[:index]) : opts[:index]
      converter = opts[:converter].new(range.size)

      bytes = converter.serialize(value)

      raise "Invalid byte count: #{bytes} expected to fit in #{range}" unless bytes.length == range.size

      range.each_with_index do |packet_index, byte_index|
        @data[packet_index] = bytes[byte_index]
      end
    end

    COMMANDS = {
        nothing: 0x0,
        retrieve: 0x1,
        set: 0x2,
        button: 0x3,
        shutdown: 0x5
    }

  end
end