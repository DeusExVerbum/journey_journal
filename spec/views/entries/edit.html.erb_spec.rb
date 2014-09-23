require 'rails_helper'

RSpec.describe "entries/edit", :type => :view do
  before(:each) do
    @journey = assign(:journey, Journey.create!(
      title: "Title",
      description: "Description"
    ))

    @entry = assign(:entry, @journey.entries.create!(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", edit_journey_entry_path(@journey, @entry), "post" do
      assert_select "input#entry_title[name=?]", "entry[title]"
      assert_select "textarea#entry_body[name=?]", "entry[body]"
      assert_select "textarea#entry_journey_id[name=?]", "entry[journey_id]"
    end
  end
end
