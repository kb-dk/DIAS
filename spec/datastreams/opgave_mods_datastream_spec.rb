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
    @ds.forfatter.should == ["Fornavn Efternavn"]
    @ds.abstrakt.should == ["ABSTRACT mutus nomen dedit cocis"]
    @ds.afleveringsaar.should == ["2011"]
    @ds.studium.should == ["Biologi"]
  end


  it "should expose titles for en opgave" do
    @ds.title.should == ["Opgavetitel"]
    @ds.undertitel.should == ["Undertitel"]
  end

  it "should expose forfatter for en opgave" do
    @ds.forfatter.should == ["Fornavn Efternavn"]
  end

  it "should expose studium for en opgave" do
    @ds.studium.should == ["Biologi"]
  end

  it "should expose afleveringsaar for en opgave" do
    @ds.afleveringsaar.should == ["2011"]
  end

  it "should expose abstrakt for en opgave" do
    @ds.abstrakt.should == ["ABSTRACT mutus nomen dedit cocis"]
  end

end