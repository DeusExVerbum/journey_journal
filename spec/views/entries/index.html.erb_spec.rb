require 'rails_helper'

RSpec.describe "entries/index", :type => :view do
  before(:each) do
    assign(:entries, [
      Entry.create!(
        :title => "Title",
        :body => "MyText",
        journey_id: 1
      ),
      Entry.create!(
        :title => "Title",
        :body => "MyText",
        journey_id: 1
      )
    ])
  end

  it "renders a list of entries" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "1".to_s, :count => 2
  end
end
