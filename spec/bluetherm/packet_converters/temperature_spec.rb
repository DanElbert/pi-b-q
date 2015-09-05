require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::PacketConverters::Word do
  it 'correctly serializes a temp' do
    c = BlueTherm::PacketConverters::Temperature.new(4)
    expect(c.serialize(42.5)).to eq [16, 157, 10, 2]
  end

  it 'deserializes a temp' do
    c = BlueTherm::PacketConverters::Temperature.new(4)
    expect(c.deserialize([16, 157, 10, 2])).to eq 42.5
  end
end