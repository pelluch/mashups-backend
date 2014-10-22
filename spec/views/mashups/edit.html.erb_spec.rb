require 'rails_helper'

RSpec.describe "mashups/edit", :type => :view do
  before(:each) do
    @mashup = assign(:mashup, Mashup.create!(
      :parameters => "MyString"
    ))
  end

  it "renders the edit mashup form" do
    render

    assert_select "form[action=?][method=?]", mashup_path(@mashup), "post" do

      assert_select "input#mashup_parameters[name=?]", "mashup[parameters]"
    end
  end
end
