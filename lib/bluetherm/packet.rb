module BlueTherm
  class Packet

    def initialize(data = nil)
      @data = data || ([0] * 128)
    end

    private

    def get_field(field)
      raise "Unknown field: #{field}" unless FIELDS.keys.include? field
      @data[FIELDS[field]]
    end

    def set_field(field, bytes)
      raise "Unknown field: #{field}" unless FIELDS.keys.include? field

      range = FIELDS[field]

      raise "Invalid byte count: #{bytes} expected to fit in #{range}" unless bytes.length == range.size

      range.each_with_index do |packet_index, byte_index|
        @data[packet_index] = bytes[byte_index]
      end
    end

    # Converts from raw packet bytes to a single word (integer)
    def convert_to_word(bytes)
      # Words are little endian, so reverse the order and mash them together
      raise "Invalid byte array: #{bytes}" unless bytes.length == 2
      (bytes[1] << 8) + bytes[0]
    end

    # Converts from a word (single int) to a pair of packet bytes
    def convert_from_word(word)
      [
          word & 0xFF,
          (word >> 8) & 0xFF
      ]
    end

    # Converts from raw packet bytes to a string
    def convert_to_string(bytes)
      sub_bytes = bytes.take_while { |b| b != 0 }
      sub_bytes.pack('C*')
    end

    # Converts from a string to a an array of bytes of the given length
    def convert_from_string(string, length)
      bytes = string.encode('ASCII').bytes
      raise "string #{string} is too long to fit in #{length} bytes" unless bytes.length < length
      length.times.map { |i| bytes[i] || 0 }
    end

    def convert_to_temp(bytes)

    end

    # Takes an array of bytes and converts to a single integer (assuming little endian byte order)
    def bytes_to_integer(bytes)
      integer = 0
      bytes.each_with_index { |b, i| integer += (b << 8) }
      integer
    end

    FIELDS = {
        command_id: 0x0,
        version: 0x1,
        retrieve_or_set_bits: (0x2..0x3),
        serial_number: (0x4..0xD),
        sensor_1_name: (0xE..0x21),
        sensor_2_name: (0x22..0x35),
        sensor_1_reading: (0x36..0x39),
        sensor_1_high_limit: (0x3A..0x3D),
        sensor_1_low_limit: (0x3E..0x41),
        sensor_1_trim: (0x42..0x45),
        sensor_1_trim_date: (0x46..0x49),
        sensor_2_reading: (0x4A..0x4D),
        sensor_2_high_limit: (0x4E..0x51),
        sensor_2_low_limit: (0x52..0x55),
        sensor_2_trim: (0x56..0x59),
        sensor_2_trim_date: (0x5A..0x5D),
        battery_volts: (0x5E..0x5F),
        battery_temperature: (0x60..0x63),
        cal_value_1: (0x64..0x67),
        cal_value_2: (0x68..0x6B),
        cal_value_3: (0x6C..0x6F),
        probe_calibration_time: (0x70..0x73),
        firmware_version: (0x74..0x77),
        sensor_1_type: 0x78,
        sensor_2_type: 0x79,
        user_data: (0x7A..0x7D),
        checksum: (0x7E..0x7F)
    }

    GET_SET_BITS = [
        :serial_number,
        :probe_names,
        :sensor_1_temperature,
        :sensor_1_high_limit,
        :sensor_1_low_limit,
        :sensor_1_trim,
        :sensor_2_temperature,
        :sensor_2_high_limit,
        :sensor_2_low_limit,
        :sensor_2_trim,
        :battery_condition,
        :cal_value_1,
        :cal_value_2,
        :cal_value_3,
        :firmware_version,
        :types
    ]

    COMMANDS = {
        nothing: 0x0,
        retrieve: 0x1,
        set: 0x2,
        button: 0x3,
        shutdown: 0x5
    }

  end
end