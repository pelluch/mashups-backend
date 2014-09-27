require "rails_helper"

RSpec.describe MashupsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mashups").to route_to("mashups#index")
    end

    it "routes to #new" do
      expect(:get => "/mashups/new").to route_to("mashups#new")
    end

    it "routes to #show" do
      expect(:get => "/mashups/1").to route_to("mashups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mashups/1/edit").to route_to("mashups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mashups").to route_to("mashups#create")
    end

    it "routes to #update" do
      expect(:put => "/mashups/1").to route_to("mashups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mashups/1").to route_to("mashups#destroy", :id => "1")
    end

  end
end
