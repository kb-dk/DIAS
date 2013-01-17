require 'spec_helper'

describe Paper do

  it "Should have metadata stream named descMetadata" do
    subject.descMetadata.class.should == OpgaveModsDatastream
  end 

  it "Should have rightsmetadata stream named rightsMetadat" do
    subject.rightsMetadata.class.should == Hydra::Datastream::RightsMetadata
  end 

  it "Should have file data stream named 'content'" do
    subject.content.class.should == ActiveFedora::Datastream
  end 



end
