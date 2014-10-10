require 'rails_helper'

RSpec.describe "entries/show", :type => :view do
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
  end

  it "renders attributes in <p>" do
    render

    # title
    expect(rendered).to match(/Title/)

    # body
    expect(rendered).to match(/MyText/)

    # journey_id
    expect(rendered).to match(/1/)
  end
end
