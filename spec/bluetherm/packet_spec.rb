require 'rails_helper'

require 'blue_therm'

RSpec.describe BlueTherm::Packet do

  it 'can be instanciated' do
    p = BlueTherm::Packet.new
    puts p

  end

end