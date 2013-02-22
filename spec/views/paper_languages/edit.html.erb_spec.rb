require 'spec_helper'

describe "paper_languages/edit" do
  before(:each) do
    @paper_language = assign(:paper_language, stub_model(PaperLanguage,
      :title => "MyString",
      :order => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit paper_language form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => paper_languages_path(@paper_language), :method => "post" do
      assert_select "input#paper_language_title", :name => "paper_language[title]"
      assert_select "textarea#paper_language_description", :name => "paper_language[description]"
    end
  end
end
