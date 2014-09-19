require 'rails_helper'

RSpec.describe "journeys/index", :type => :view do
  before(:each) do
    assign(:journeys, [
      Journey.create!(
        :title => "Title",
        :body => "MyText"
      ),
      Journey.create!(
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of journeys" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
