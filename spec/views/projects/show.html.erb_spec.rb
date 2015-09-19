require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :name => "Name",
      :start => 1.day.ago,
      :end => Time.now,
      :sensor1_name => "Sensor1 Name",
      :sensor2_name => "Sensor2 Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
