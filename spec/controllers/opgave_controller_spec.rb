# spec/controllers/opgave_controller_spec.rb
require 'spec_helper'


describe OpgaveController do

  describe "creating" do
    it "should render the create page" do
      get :new
      assigns[:opgave].should be_kind_of Opgave
      renders.should == "new"
    end




    it "should support create requests" do
        post :create, :opgave=>{"title"=>"Ny titel"}
        op = assigns[:opgave]
        op.title.should == "Ny titel"
    end

  end
end