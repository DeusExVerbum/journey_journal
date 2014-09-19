require 'rails_helper'

RSpec.describe "journeys/edit", :type => :view do
  before(:each) do
    @journey = assign(:journey, Journey.create!(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit journey form" do
    render

    assert_select "form[action=?][method=?]", journey_path(@journey), "post" do

      assert_select "input#journey_title[name=?]", "journey[title]"

      assert_select "textarea#journey_body[name=?]", "journey[body]"
    end
  end
end
