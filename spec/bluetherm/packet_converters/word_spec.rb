require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::PacketConverters::Word do
  it 'correctly serializes a number' do
    c = BlueTherm::PacketConverters::Word.new(2)
    expect(c.serialize(500)).to eq [244, 1]
  end

  it 'deserializes a number' do
    c = BlueTherm::PacketConverters::Word.new(2)
    expect(c.deserialize([244, 1])).to eq 500
  end
end