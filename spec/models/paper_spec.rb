require 'spec_helper'

describe Paper do


  def valid_attributes
    { title:"Opgavetitel", undertitel:"Undertitel", forfatter:"Fornavn Efternavn", abstrakt:"ABSTRACT mutus nomen dedit cocis", afleveringsaar:"2011", studium:"Biologi", opgavetype:"bacheloropgave", opgavesprog:"Dansk"}
  end

  context "with uploaded  pdf file" do

    before do
      @paper = Paper.new(valid_attributes)
      file = ActionDispatch::Http::UploadedFile.new(filename: 'test.pdf', type: 'application/pdf', tempfile: File.new("#{Rails.root}/spec/fixtures/test.pdf"))
      @paper.add_file(file)
    end

    it "Should have metadata stream named descMetadata" do
      @paper.descMetadata.should be_kind_of  OpgaveModsDatastream
    end

    it "Should have rightsmetadata stream named rightsMetadata" do
      @paper.rightsMetadata.should be_kind_of Hydra::Datastream::RightsMetadata
    end

    it "Should have tech metadatastream  stream named 'techMetadata'" do
      @paper.techMetadata.should be_kind_of ActiveFedora::SimpleDatastream
    end

    it "Should have file data stream named content" do
      @paper.content.should be_kind_of  ActiveFedora::Datastream
    end

    it "should have valid attributes" do
      @paper.title.should == valid_attributes[:title]
      @paper.undertitel.should == valid_attributes[:undertitel]
      @paper.forfatter.should == valid_attributes[:forfatter]
      @paper.abstrakt.should == valid_attributes[:abstrakt]
      @paper.afleveringsaar.should == valid_attributes[:afleveringsaar]
      @paper.studium.should == valid_attributes[:studium]
      @paper.opgavetype.should == valid_attributes[:opgavetype]
      @paper.opgavesprog.should == valid_attributes[:opgavesprog]
    end

    it "should have an original_file_name" do
      @paper.original_filename.should == "test.pdf"

    end

    it "should have mime_type 'application/pdf" do
      @paper.mime_type.should == "application/pdf"
    end
  end

  context "with uploaded file (not pdf)" do

    before do
      @paper = Paper.new(valid_attributes)
      file = ActionDispatch::Http::UploadedFile.new(filename: 'eksempel_opgave.mods.xml', type: 'text/xml', tempfile: File.new("#{Rails.root}/spec/fixtures/eksempel_opgave.mods.xml"))
      @paper.add_file(file)
    end

    it "Should have metadata stream named descMetadata" do
      @paper.descMetadata.should be_kind_of  OpgaveModsDatastream
    end

    it "Should have rightsmetadata stream named rightsMetadata" do
      @paper.rightsMetadata.should be_kind_of Hydra::Datastream::RightsMetadata
    end

    it "Should have tech metadatastream  stream named 'techMetadata'" do
      @paper.techMetadata.should be_kind_of ActiveFedora::SimpleDatastream
    end

    it "Should have file data stream named content" do
      @paper.content.should be_kind_of  ActiveFedora::Datastream
    end

    it "should have valid attributes" do
      @paper.title.should == valid_attributes[:title]
      @paper.undertitel.should == valid_attributes[:undertitel]
      @paper.forfatter.should == valid_attributes[:forfatter]
      @paper.abstrakt.should == valid_attributes[:abstrakt]
      @paper.afleveringsaar.should == valid_attributes[:afleveringsaar]
      @paper.studium.should == valid_attributes[:studium]
      @paper.opgavetype.should == valid_attributes[:opgavetype]
      @paper.opgavesprog.should == valid_attributes[:opgavesprog]
    end

    it "should have an original_file_name" do
      @paper.original_filename.should == "eksempel_opgave.mods.xml"

    end

    it "should not have mime_type 'application/pdf" do
      @paper.mime_type.should_not == "application/pdf"
    end
  end

  context "without uploaded file" do
    before do
      @paper = Paper.new(valid_attributes)
    end

    it "Should have metadata stream named descMetadata" do
      @paper.descMetadata.should be_kind_of OpgaveModsDatastream
    end

    it "Should have rightsmetadata stream named rightsMetadata" do
      @paper.rightsMetadata.should be_kind_of Hydra::Datastream::RightsMetadata
    end


    it "Should have tech metadatastream  stream named 'techMetadata'" do
      @paper.techMetadata.should be_kind_of ActiveFedora::SimpleDatastream
    end

    it "Should not have a file data stream named 'content'" do
      @paper.content.should be_nil
    end

    it "should have valid attributes" do
      @paper.title.should == valid_attributes[:title]
      @paper.undertitel.should == valid_attributes[:undertitel]
      @paper.forfatter.should == valid_attributes[:forfatter]
      @paper.abstrakt.should == valid_attributes[:abstrakt]
      @paper.afleveringsaar.should == valid_attributes[:afleveringsaar]
      @paper.studium.should == valid_attributes[:studium]
      @paper.opgavetype.should == valid_attributes[:opgavetype]
      @paper.opgavesprog.should == valid_attributes[:opgavesprog]
    end

    it "should have an original_file_name" do
      @paper.original_filename.should  be_nil

    end

    it "should have mime_type 'application/pdf" do
      @paper.mime_type.should be_nil
    end
  end

end
