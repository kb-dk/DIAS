require 'spec_helper'

describe "paper_types/edit" do
  before(:each) do
    @paper_type = assign(:paper_type, stub_model(PaperType,
      :title => "MyString",
      :order => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit paper_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => paper_types_path(@paper_type), :method => "post" do
      assert_select "input#paper_type_title", :name => "paper_type[title]"
      assert_select "input#paper_type_order", :name => "paper_type[order]"
      assert_select "textarea#paper_type_description", :name => "paper_type[description]"
    end
  end
end
