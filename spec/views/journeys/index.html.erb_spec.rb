require 'rails_helper'

RSpec.describe "journeys/index", :type => :view do
  before(:each) do
    assign(:journeys, [
      Journey.create!(
        :title => "Title",
        :description => "Description"
      ),
      Journey.create!(
        :title => "Title",
        :description => "Description"
      )
    ])
  end

  it "renders a list of journeys" do
    render
    assert_select "div.journey h3.title", :text => "Title (Edit) (Destroy)".to_s, :count => 2
    assert_select "div.journey p.description", :text => "Description".to_s, :count => 2
  end
end
