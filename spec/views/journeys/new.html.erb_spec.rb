require 'rails_helper'

RSpec.describe "journeys/new", :type => :view do
  before(:each) do
    assign(:journey, Journey.new(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new journey form" do
    render

    assert_select "form[action=?][method=?]", journeys_path, "post" do

      assert_select "input#journey_title[name=?]", "journey[title]"

      assert_select "textarea#journey_description[name=?]", "journey[description]"
    end
  end
end
