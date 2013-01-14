require 'spec_helper'

describe "papers/new" do
  before(:each) do
    assign(:paper, stub_model(Paper).as_new_record)
  end

  it "renders new paper form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => papers_path, :method => "post" do
    end
  end
end
