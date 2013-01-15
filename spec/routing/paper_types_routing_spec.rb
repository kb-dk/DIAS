require "spec_helper"

describe PaperTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/paper_types").should route_to("paper_types#index")
    end

    it "routes to #new" do
      get("/paper_types/new").should route_to("paper_types#new")
    end

    it "routes to #show" do
      get("/paper_types/1").should route_to("paper_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/paper_types/1/edit").should route_to("paper_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/paper_types").should route_to("paper_types#create")
    end

    it "routes to #update" do
      put("/paper_types/1").should route_to("paper_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/paper_types/1").should route_to("paper_types#destroy", :id => "1")
    end

  end
end
