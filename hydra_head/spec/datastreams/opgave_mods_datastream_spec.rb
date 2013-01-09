# spec/datastreams/opgave_mods_datastream_spec.rb
require 'spec_helper'

describe OpgaveModsDatastream do
  
  before(:each) do
    @mods = fixture("eksempel_opgave.mods.xml")
    @ds = OpgaveModsDatastream.from_xml(@mods)
  end

  it "should expose bibliographic info for en opgave" do
    
    @ds.title.should == ["Opgavetitel"]
    @ds.undertitel.should == ["Undertitel"]
    #@ds.forfatter.should == ["Fornavn Efternavn"]
    #@ds.abstract.should == ["ABSTRACT mutus nomen dedit cocis"]
    #@ds.afleveringsaar.should == ["2011"]
    #@ds.studium.should == ["Biologi"]
  end

end