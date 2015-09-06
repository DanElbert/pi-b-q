module BlueTherm
  # Represents the retrieve or set data bits of bytes 2 and 3 of a data packet
  class DataFlags

    def self.default
      self.new(
              {
                  serial_number: true,
                  probe_names: true,
                  sensor_1_temperature: true,
                  sensor_1_high_limit: true,
                  sensor_1_low_limit: true,
                  sensor_2_temperature: true,
                  sensor_2_high_limit: true,
                  sensor_2_low_limit: true,
                  battery_condition: true
              }
      )
    end

    attr_reader :word

    def initialize(data = 0xFF)
      if data.is_a? Numeric
        @word = data.to_i
      elsif data.is_a? Hash
        @word = 0
        data.each do |k, v|
          self.send("#{k}=", v)
        end
      end
    end

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

    GET_SET_BITS.each_with_index do |flag, idx|
      define_method flag do
        get_bit idx
      end

      define_method "#{flag}=".to_sym do |v|
        set_bit idx, !!v
      end
    end

    protected

    def set_bit(idx, value)
      if value
        @word = @word | (1 << idx)
      else
        @word = @word & ~(1 << idx)
      end
    end

    def get_bit(idx)
      @word & (1 << idx) != 0
    end

  end
end