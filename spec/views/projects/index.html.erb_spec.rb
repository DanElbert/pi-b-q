require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        :name => "Name",
        :start => 1.day.ago,
        :end => Time.now,
        :sensor1_name => "Sensor1 Name",
        :sensor2_name => "Sensor2 Name"
      ),
      Project.create!(
        :name => "Name",
        :start => 1.day.ago,
        :end => Time.now,
        :sensor1_name => "Sensor1 Name",
        :sensor2_name => "Sensor2 Name"
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Sensor1 Name".to_s, :count => 2
    assert_select "tr>td", :text => "Sensor2 Name".to_s, :count => 2
  end
end
