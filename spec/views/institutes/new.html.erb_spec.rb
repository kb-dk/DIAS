require 'spec_helper'
require 'cancan/matchers'


describe "institutes/new" do
  before(:each) do
    assign(:institute, stub_model(Institute,
      :title => "MyString",
      :order => 1,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new institute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => institutes_path, :method => "post" do
      assert_select "input#institute_title", :name => "institute[title]"
      assert_select "textarea#institute_description", :name => "institute[description]"
    end
  end

end
