require 'spec_helper'

describe "paper_types/show" do
  before(:each) do
    @paper_type = assign(:paper_type, stub_model(PaperType,
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
