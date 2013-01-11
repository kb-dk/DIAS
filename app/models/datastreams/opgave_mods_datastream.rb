# app/models/datastreams/journal_article_mods_datastream.rb

#1) Titel:  [     ]
#2) Undertitel: [     ] . Ikke obligatorisk.
# 3) Forfatter: [efternavn] [fornavn]
#- Under forfatter-feltet kan brugeren klikke på Tilføj  forfatter. Ved at klikke på Tilføj  forfatter fremkommer endnu et forfatterfelt.
#  4) Beskrivelse/abstract: [    ] (textarea med maxlength:1000 karakterer. placeholder="Lav en kortfattet beskrivelse af din opgave. Så bliver den lettere for andre at finde").  Ikke obligatorisk.
#                                                                                                                                                                                                                                                                                                               5) Afleveringsår: (textinput: udfyldes med 4 tal=år)
#6) Studium: (dropdown med studier) (se vedhæftet studier.txt)
#7) Opgavetype: (dropdown) (se vedhæftet opgavetyper.txt)
#8) Opgavesprog: (dropdown med værdierne: dansk, svensk, norsk, engelsk, tysk, fransk, spansk, andet)
# a Fedora Datastream object containing Mods XML for the descMetadata 
# datastream in the Journal Article hydra content type, defined using 
# ActiveFedora and OM.

class OpgaveModsDatastream < ActiveFedora::NokogiriDatastream

  # OM (Opinionated Metadata) terminology mapping for the mods xml
  set_terminology do |t|
    t.root(:path => "mods", :xmlns => "http://www.loc.gov/mods/v3", :schema => "http://www.loc.gov/standards/mods/v3/mods-3-2.xsd")


    t.titleInfo do
      t.title(:index_as => [:searchable])
      t.subTitle(:index_as => [:searchable])
    end


    # <name type="personal">
    # <namePart>Fornavn Efternavn</namePart>                 <!-- Forfatter author for og efternavn -->
    #    <role>
    #        <roleTerm authority="marcrelator" type="text">Creator</roleTerm> <!-- author role -->
    #                                                                                                                           </role>
    #</name>

    t.name do
      t.namePart(:index_as => [:searchable])
    end

    t.abstract(:index_as=>[:searchable])

    #<originInfo>
    #<dataIssued>2011</dateIssued>                             <!-- Afleveringsår -->
    #      <location>
    #           <physicalLocation>Biologi</physicalLocation>              <!--  Studium -->
    #</location>
    # </originInfo>

    t.originInfo do
      t.dataIssued(:index_as => [:facet])
      t.location do
        t.physicalLocation(:index_as => [:facet])
      end
    end

    t.typeOfResource(:index_as=>[:searchable])

    t.genre(:index_as=>[:searchable])

    t.language do
      t.languageISO(:path=>"languageTerm[@authority='iso639-2b']", :index_as => [:searchable])
      t.languageText(:path=>"languageTerm[@type='text']", :index_as => [:searchable])
    end

    # these proxy declarations allow you to use more familiar term/field names that hide the details of the XML structure
    t.title(:proxy => [:titleInfo, :title])
    t.undertitel(:proxy => [:titleInfo, :subTitle])
    t.forfatter(:proxy => [:name, :namePart])
    t.abstrakt(:proxy => [:abstract])
    t.afleveringsaar(:proxy => [:originInfo, :dataIssued])
    t.studium(:proxy => [:originInfo, :location, :physicalLocation])
    t.Opgavesprog(:proxy => [:language, :languageText])

  end # set_terminology


  #ABWE added this method.
  def self.xml_template
    Nokogiri::XML.parse '<mods xmlns="http://www.loc.gov/mods/v3" version="3.0"  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3
     http://www.loc.gov/standards/mods/v3/mods-3-0.xsd">
   <titleInfo>
       <title>Opgavetitel</title>                                   <!-- title -->
       <subTitle>Undertitel</subTitle>                      <!-- undertitel -->
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
