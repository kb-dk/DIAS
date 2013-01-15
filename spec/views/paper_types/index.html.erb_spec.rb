require 'spec_helper'

describe "paper_types/index" do
  before(:each) do
    assign(:paper_types, [
      stub_model(PaperType,
        :title => "Title"
      ),
      stub_model(PaperType,
        :title => "Title",

      )
    ])
  end

  it "renders a list of paper_types"
=begin
  it "renders a list of paper_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2

  end
=end
end
