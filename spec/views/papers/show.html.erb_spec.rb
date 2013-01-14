require 'spec_helper'

describe "papers/show" do
  before(:each) do
    @paper = assign(:paper, stub_model(Paper))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
