require 'spec_helper'

describe "institutes/index" do
  before(:each) do
    assign(:institutes, [
      stub_model(Institute,
        :title => "Title",

      ),
      stub_model(Institute,
        :title => "Title",

      )
    ])
  end

  it "renders a list of institutes" # do
    # render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "tr>td", :text => "Title".to_s, :count => 2
  #end
end
