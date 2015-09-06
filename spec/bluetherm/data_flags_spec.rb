require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::DataFlags do

  it 'returns the value set' do
    f = BlueTherm::DataFlags.new 0
    f.probe_names = true
    expect(f.probe_names).to eq true
    expect(f.types).to eq false
  end



end