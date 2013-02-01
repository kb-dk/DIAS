require 'spec_helper'

describe "papers/index" do
  before(:each) do
    assign(:papers, [
      stub_model(Paper),
      stub_model(Paper)
    ])
  end


  it "renders a list of papers" do
    pending "authenticate is nil error"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
