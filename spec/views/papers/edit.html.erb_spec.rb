require 'spec_helper'

describe "papers/edit" do
  before(:each) do
    @paper = assign(:paper, stub_model(Paper))
  end


  it "renders the edit paper form" do
    pending "authenticate is nil error"
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => papers_path(@paper), :method => "post" do
    end
  end
end
