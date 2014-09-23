require "rails_helper"

RSpec.describe EntriesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/journeys/1/entries").to route_to("entries#index", journey_id: "1")
    end

    it "routes to #new" do
      expect(:get => "/journeys/1/entries/new").to route_to("entries#new", journey_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/journeys/1/entries/1").to route_to("entries#show", journey_id: "1", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/journeys/1/entries/1/edit").to route_to("entries#edit", journey_id: "1", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/journeys/1/entries").to route_to("entries#create", journey_id: "1")
    end

    it "routes to #update" do
      expect(:put => "/journeys/1/entries/1").to route_to("entries#update", journey_id: "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/journeys/1/entries/1").to route_to("entries#destroy", journey_id: "1", :id => "1")
    end

  end
end
