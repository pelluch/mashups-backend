require 'rails_helper'

RSpec.describe "mashups/index", :type => :view do
  before(:each) do
    assign(:mashups, [
      Mashup.create!(
        :parameters => "Parameters"
      ),
      Mashup.create!(
        :parameters => "Parameters"
      )
    ])
  end

  it "renders a list of mashups" do
    render
    assert_select "tr>td", :text => "Parameters".to_s, :count => 2
  end
end
