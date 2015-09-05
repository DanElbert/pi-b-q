require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::Packet do

  it 'provides methods to read and set fields' do
    p = BlueTherm::Packet.new

    p.sensor_1_reading = 55.5
    expect(p.sensor_1_reading).to eq 55.5
  end

  it 'modifies the underlying byte array' do
    p = BlueTherm::Packet.new

    expect(p.data).to eq [0] * 128

    p.sensor_1_reading = 55

    expect(p.data).not_to eq [0] * 128
  end

end