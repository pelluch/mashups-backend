require 'rails_helper'

RSpec.describe "mashups/new", :type => :view do
  before(:each) do
    assign(:mashup, Mashup.new(
      :parameters => "MyString"
    ))
  end

  it "renders new mashup form" do
    render

    assert_select "form[action=?][method=?]", mashups_path, "post" do

      assert_select "input#mashup_parameters[name=?]", "mashup[parameters]"
    end
  end
end
