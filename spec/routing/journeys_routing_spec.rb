require "rails_helper"

RSpec.describe JourneysController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/journeys").to route_to("journeys#index")
    end

    it "routes to #new" do
      expect(:get => "/journeys/new").to route_to("journeys#new")
    end

    it "routes to #show" do
      expect(:get => "/journeys/1").to route_to("journeys#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/journeys/1/edit").to route_to("journeys#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/journeys").to route_to("journeys#create")
    end

    it "routes to #update" do
      expect(:put => "/journeys/1").to route_to("journeys#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/journeys/1").to route_to("journeys#destroy", :id => "1")
    end

  end
end
