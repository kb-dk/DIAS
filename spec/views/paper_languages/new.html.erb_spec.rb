require 'spec_helper'

describe "paper_languages/new" do
  before(:each) do
    assign(:paper_language, stub_model(PaperLanguage,
      :title => "MyString",
      :order => 1,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new paper_language form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => paper_languages_path, :method => "post" do
      assert_select "input#paper_language_title", :name => "paper_language[title]"
      assert_select "input#paper_language_order", :name => "paper_language[order]"
      assert_select "textarea#paper_language_description", :name => "paper_language[description]"
    end
  end
end
