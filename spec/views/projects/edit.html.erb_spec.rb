require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :name => "MyString",
      :start => 1.day.ago,
      :end => Time.now,
      :sensor1_name => "MyString",
      :sensor2_name => "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "input#project_sensor1_name[name=?]", "project[sensor1_name]"

      assert_select "input#project_sensor2_name[name=?]", "project[sensor2_name]"
    end
  end
end
