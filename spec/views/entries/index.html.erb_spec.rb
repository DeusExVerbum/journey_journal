require 'rails_helper'

RSpec.describe "entries/index", :type => :view do
  before(:each) do
    @journey = assign(:journey, Journey.create!(
      :title => "Title",
      :description => "MyText"
    ))
    @user = assign(:user, User.create!(
      email: "asdfasdf@asdfasfd.com",
      password: "asdfasdf"
    ))
    assign(:entries, [
      Entry.create!(
        :title => "Title",
        :body => "MyText",
        journey_id: @journey.id,
        user_id: @user.id
      ),
      Entry.create!(
        :title => "Title",
        :body => "MyText",
        journey_id: @journey.id,
        user_id: @user.id
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
