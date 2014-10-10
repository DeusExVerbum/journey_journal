require 'rails_helper'

RSpec.describe "entries/new", :type => :view do
  before(:each) do
    @journey = assign(:journey, Journey.create!(
      title: "Title",
      description: "Description"
    ))

    @user = assign(:user, User.create!(
      email: "asdfasdf@asdfasfd.com",
      password: "asdfasdf"
    ))

    @entry = assign(:entry, @journey.entries.create!(
      :title => "MyString",
      :body => "MyText",
      user_id: @user.id
    ))

    sign_in @user
  end

  it "renders new entry form" do
    render

    assert_select "form[action=?][method=?]", journey_entry_path(@journey, @entry), "post" do
      assert_select "input#entry_title[name=?]", "entry[title]"
      assert_select "textarea#entry_body[name=?]", "entry[body]"
    end
  end
end
