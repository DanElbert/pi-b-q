require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::PacketConverters::None do

  describe '#serialize' do

    it 'wraps single values in a padded array' do
      c = BlueTherm::PacketConverters::None.new(4)
      expect(c.serialize(5)).to eq [5, 0, 0, 0]
    end

    it 'pads arrays' do
      c = BlueTherm::PacketConverters::None.new(4)
      expect(c.serialize([5])).to eq [5, 0, 0, 0]
    end

    it 'leaves arrays of the correct length alone' do
      c = BlueTherm::PacketConverters::None.new(4)
      expect(c.serialize([5, 0, 0, 0])).to eq [5, 0, 0, 0]
    end

  end

  describe '#deserialize' do

    it 'unwraps when length is 1' do
      c = BlueTherm::PacketConverters::None.new(1)
      expect(c.deserialize([5])).to eq 5
    end

    it 'return an array when length is more than 1' do
      c = BlueTherm::PacketConverters::None.new(2)
      expect(c.deserialize([5, 0])).to eq [5, 0]
    end
  end

end
