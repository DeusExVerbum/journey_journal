require 'rails_helper'

RSpec.describe "entries/edit", :type => :view do
  before(:each) do
    @journey = assign(:journey, Journey.create!(
      title: "Title",
      description: "Description"
    ))

    @user = User.create!(
      email: "asdfasdf@asdfasfd.com",
      password: "asdfasdf"
    )

    @entry = assign(:entry, @journey.entries.create!(
      :title => "MyString",
      :body => "MyText",
      user_id: @user.id
    ))

  end

  it "renders the login form for unauthenticated user" do
    render

    expect(rendered).to match(/Editing Entry/)
  end

  it "renders the edit entry form for authenticated user" do
    sign_in @user
    render

    assert_select "form[action=?][method=?]", journey_entry_path(@journey, @entry), "post" do
      assert_select "input#entry_title[name=?]", "entry[title]"
      assert_select "textarea#entry_body[name=?]", "entry[body]"
      assert_select "input#entry_journey_id[name=?]", "entry[journey_id]"
      assert_select "input#entry_user_id[name=?]", "entry[user_id]"
    end
  end
end
