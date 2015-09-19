require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      :name => "MyString",
      :sensor1_name => "MyString",
      :sensor2_name => "MyString"
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "input#project_sensor1_name[name=?]", "project[sensor1_name]"

      assert_select "input#project_sensor2_name[name=?]", "project[sensor2_name]"
    end
  end
end
