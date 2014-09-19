require 'rails_helper'

RSpec.describe "Journeys", :type => :request do
  describe "GET /journeys" do
    it "works! (now write some real specs)" do
      get journeys_path
      expect(response.status).to be(200)
    end
  end
end
