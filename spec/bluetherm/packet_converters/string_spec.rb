require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::PacketConverters::String do

  it 'Converts a simple string to a padded byte array' do
    c = BlueTherm::PacketConverters::String.new(10)

    bytes = c.serialize("abcd")
    expect(bytes).to eq [97, 98, 99, 100, 0, 0, 0, 0, 0, 0]
  end

  it 'Raises an exception when the string is too long' do
    c = BlueTherm::PacketConverters::String.new(4)

    expect { c.serialize("abcd") }.to raise_error(RuntimeError)
  end

  it 'handles a nil string' do
    c = BlueTherm::PacketConverters::String.new(5)

    expect(c.serialize(nil)).to eq [0, 0, 0, 0, 0]
  end

  it 'deserializes a byte array' do
    c = BlueTherm::PacketConverters::String.new(10)

    expect(c.deserialize([97, 98, 99, 100, 0, 0, 0, 0, 0, 0])).to eq 'abcd'
  end

  it 'deserializes an empty byte array' do
    c = BlueTherm::PacketConverters::String.new(10)

    expect(c.deserialize([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])).to eq ''
  end

end