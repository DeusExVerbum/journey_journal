require 'rails_helper'

RSpec.describe "entries/edit", :type => :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :title => "MyString",
      :body => "MyText",
      :journey_id => 1
    ))
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", entry_path(@entry), "post" do
      assert_select "input#entry_title[name=?]", "entry[title]"
      assert_select "textarea#entry_body[name=?]", "entry[body]"
      assert_select "textarea#entry_journey_id[name=?]", "entry[journey_id]"
    end
  end
end
