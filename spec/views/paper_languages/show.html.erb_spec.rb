require 'spec_helper'

describe "paper_languages/show" do
  before(:each) do
    @paper_language = assign(:paper_language, stub_model(PaperLanguage,
      :title => "Title",
      :order => 1,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
