# app/models/datastreams/journal_article_mods_datastream.rb

# a Fedora Datastream object containing Mods XML for the descMetadata 
# datastream in the Journal Article hydra content type, defined using 
# ActiveFedora and OM.

class OpgaveModsDatastream < ActiveFedora::NokogiriDatastream

  # OM (Opinionated Metadata) terminology mapping for the mods xml
  set_terminology do |t|
    t.root(:path=>"mods", :xmlns=>"http://www.loc.gov/mods/v3", :schema=>"http://www.loc.gov/standards/mods/v3/mods-3-2.xsd")
  

      t.titleInfo do
        t.title(:index_as => [:searchable])
        t.subTitle(:index_as => [:searchable])
      end
    
    t.abstract 
 
      
    # these proxy declarations allow you to use more familiar term/field names that hide the details of the XML structure
    t.title(:proxy => [:titleInfo, :title])
    t.undertitel(:proxy => [:titleInfo, :subTitle])

  end # set_terminology
  

    #ABWE added this method.
  def self.xml_template
      Nokogiri::XML.parse '<mods xmlns="http://www.loc.gov/mods/v3" version="3.0"  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3
     http://www.loc.gov/standards/mods/v3/mods-3-0.xsd">
   <titleInfo>
       <title>Opgavetitel</title>                                   <!-- title -->
       <title type="alternative">Undertitel</title>                      <!-- undertitel -->
   </titleInfo>

   <name type="personal">
       <namePart>Fornavn Efternavn</namePart>                 <!-- Forfatter author for og efternavn -->
       <role> 
           <roleTerm authority="marcrelator" type="text">Creator</roleTerm> <!-- author role -->
       </role>
   </name>
   <abstract>ABSTRACT mutus nomen dedit cocis</abstract>            <!-- Beskrivelse /Abstract -->
   <originInfo>
          <dataIssued>2011</dateIssued>                             <!-- Afleveringsaar -->
          <location>
               <physicalLocation>Biologi</physicalLocation>              <!--  Studium -->
          </location>
     </originInfo>         

    <typeOfResource>text<typeOfResource>                          <!-- Opgavetype -->

     <genre>Synopsis</genre>
     <language>
           <languageTerm code="code" authority="iso369-2b">dan<languageTerm>   <!-- Opgavesprog -->
     </language>   
</mods>'
    end

end # class
