require 'rails_helper'

RSpec.describe "Mashups", :type => :request do
  describe "GET /mashups" do
    it "works! (now write some real specs)" do
      get mashups_path
      expect(response).to have_http_status(200)
    end
  end
end
