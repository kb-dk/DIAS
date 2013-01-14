require "spec_helper"

describe PapersController do
  describe "routing" do

    it "routes to #index" do
      get("/papers").should route_to("papers#index")
    end

    it "routes to #new" do
      get("/papers/new").should route_to("papers#new")
    end

    it "routes to #show" do
      get("/papers/1").should route_to("papers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/papers/1/edit").should route_to("papers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/papers").should route_to("papers#create")
    end

    it "routes to #update" do
      put("/papers/1").should route_to("papers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/papers/1").should route_to("papers#destroy", :id => "1")
    end

  end
end
