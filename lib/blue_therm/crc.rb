module BlueTherm
  # Here be Dragons
  #
  # This code is a direct port of the example C# CRC implementation out of the BlueTherm Protocol Manual
  # Seems to work, so I'm not touching it.
  class CRC
    def self.checksum(bytes)
      crc = 0
      bytes.each do |b|
        crc = calculate_crc(b, crc)
      end

      ncrc = crc
      ncrc = ~ncrc
      ncrc = ncrc & 0xFFFF
      ncrc
    end

    def self.calculate_crc(p, crc)
      tempCRC = crc
      word = p
      8.times do |i|
        crcin = ((tempCRC ^ word) & 1) << 15
        word = word >> 1
        tempCRC = tempCRC >> 1
        if crcin != 0
          tempCRC = tempCRC ^ 0xA001
        end
      end

      tempCRC
    end
  end
end