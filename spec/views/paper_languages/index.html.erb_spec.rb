require 'spec_helper'

describe "paper_languages/index" do
  before(:each) do
    assign(:paper_languages, [
      stub_model(PaperLanguage,
        :title => "Title"
      ),
      stub_model(PaperLanguage,
        :title => "Title"
      )
    ])
  end

  it "renders a list of paper_languages" # do
    # render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "tr>td", :text => "Title".to_s, :count => 2

  # end
end
