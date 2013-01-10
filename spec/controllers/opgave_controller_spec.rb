# spec/controllers/opgave_controller_spec.rb
require 'spec_helper'


describe OpgaveController do

  describe "creating" do
    it "should render the create page" do
      get :new
      assigns[:opgave].should be_kind_of Opgave
      renders.should == "new"
    end
  end
end