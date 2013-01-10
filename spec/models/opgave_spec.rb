# spec/modules/journal_opgave_spec.rb
require 'spec_helper'

describe Opgave do
  
  before(:each) do
    # This gives you a test opgave object that can be used in any of the tests
    @opgave = Opgave.new
  end
  
  it "should have the specified datastreams" do
    # Check for descMetadata datastream with MODS in it
    @opgave.datastreams.keys.should include("descMetadata")
    @opgave.descMetadata.should be_kind_of OpgaveModsDatastream
    # Check for rightsMetadata datastream
    @opgave.datastreams.keys.should include("rightsMetadata")
    @opgave.rightsMetadata.should be_kind_of Hydra::Datastream::RightsMetadata
  end
  
  it "should have the attributes of a journal opgave and support update_attributes" do
    attributes_hash = {
      "title" => "Opgavetitel",
      "abstract" => "ABSTRACT mutus nomen dedit cocis",
    }
    
    @opgave.update_attributes( attributes_hash )
    
    # These attributes have been marked "unique" in the call to delegate, which causes the results to be singular
    @opgave.title.should == attributes_hash["title"]
    @opgave.abstract.should == attributes_hash["abstract"]
    
    # These attributes have not been marked "unique" in the call to the delegate, which causes the results to be arrays
   
  end
  
end