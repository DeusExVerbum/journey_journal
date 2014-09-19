require 'rails_helper'

RSpec.describe "entries/new", :type => :view do
  before(:each) do
    assign(:entry, Entry.new(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new entry form" do
    render

    assert_select "form[action=?][method=?]", entries_path, "post" do

      assert_select "input#entry_title[name=?]", "entry[title]"

      assert_select "textarea#entry_body[name=?]", "entry[body]"
    end
  end
end
