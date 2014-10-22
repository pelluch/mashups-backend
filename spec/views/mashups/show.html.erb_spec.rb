require 'rails_helper'

RSpec.describe "mashups/show", :type => :view do
  before(:each) do
    @mashup = assign(:mashup, Mashup.create!(
      :parameters => "Parameters"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Parameters/)
  end
end
