require 'rails_helper'

RSpec.describe "journeys/new", :type => :view do
  before(:each) do
    assign(:journey, Journey.new(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new journey form" do
    render

    assert_select "form[action=?][method=?]", journeys_path, "post" do

      assert_select "input#journey_title[name=?]", "journey[title]"

      assert_select "textarea#journey_body[name=?]", "journey[body]"
    end
  end
end
