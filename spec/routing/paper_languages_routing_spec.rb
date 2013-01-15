require "spec_helper"

describe PaperLanguagesController do
  describe "routing" do

    it "routes to #index" do
      get("/paper_languages").should route_to("paper_languages#index")
    end

    it "routes to #new" do
      get("/paper_languages/new").should route_to("paper_languages#new")
    end

    it "routes to #show" do
      get("/paper_languages/1").should route_to("paper_languages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/paper_languages/1/edit").should route_to("paper_languages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/paper_languages").should route_to("paper_languages#create")
    end

    it "routes to #update" do
      put("/paper_languages/1").should route_to("paper_languages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/paper_languages/1").should route_to("paper_languages#destroy", :id => "1")
    end

  end
end
