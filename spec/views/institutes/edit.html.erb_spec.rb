require 'spec_helper'

describe "institutes/edit" do
  before(:each) do
    @institute = assign(:institute, stub_model(Institute,
      :title => "MyString",
      :order => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit institute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => institutes_path(@institute), :method => "post" do
      assert_select "input#institute_title", :name => "institute[title]"
      assert_select "textarea#institute_description", :name => "institute[description]"
    end
  end
end
