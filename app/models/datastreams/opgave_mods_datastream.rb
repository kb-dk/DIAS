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

class OpgaveModsDatastream < ActiveFedora::OmDatastream

  MODS_NS = 'http://www.loc.gov/mods/v3'
  MODS_SCHEMA = 'http://www.loc.gov/standards/mods/v3/mods-3-3.xsd'
  MODS_PARAMS = {
      "version"            => "3.3",
      "xmlns:xlink"        => "http://www.w3.org/1999/xlink",
      "xmlns:xsi"          => "http://www.w3.org/2001/XMLSchema-instance",
      "xmlns"              => MODS_NS,
      "xsi:schemaLocation" => "#{MODS_NS} #{MODS_SCHEMA}",
  }

  # OM (Opinionated Metadata) terminology mapping for the mods xml
  set_terminology do |t|
    t.root(:path => "mods", :xmlns => MODS_NS, :schema => MODS_SCHEMA)


    t.titleInfo do
      t.title(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable])
      t.subTitle(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable])
    end


    # <name type="personal">
    # <namePart>Fornavn Efternavn</namePart>                 <!-- Forfatter author for og efternavn -->
    #    <role>
    #        <roleTerm authority="marcrelator" type="text">Creator</roleTerm> <!-- author role -->
    #                                                                                                                           </role>
    #</name>

    t.name do
      t.namePart(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable], :path=>'forfatter', :label=>'forfatter')
      t.role do
        t.roleTerm
      end
    end

    t.abstract(:type => :string, :index_as=>[:stored_searchable, :displayable], :path=>'abstrakt', :label=>'abstrakt')

    #<originInfo>
    #<dataIssued>2011</dateIssued>                             <!-- Afleveringsår -->
    #      <location>
    #           <physicalLocation>Biologi</physicalLocation>              <!--  Studium -->
    #</location>
    # </originInfo>

    t.originInfo do
      t.dataIssued(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable, :sortable])    # :facetable
      t.location do
        t.physicalLocation(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable, :sortable])
      end
    end

    t.typeOfResource(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable])

    t.genre(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable])

    t.language do
      t.languageTerm(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable])
    end

    # these proxy declarations allow you to use more familiar term/field names that hide the details of the XML structure
    t.title(:proxy => [:titleInfo, :title])
    t.undertitel(:proxy => [:titleInfo, :subTitle])
   # t.forfatter(:proxy => [:name, :namePart])
    t.abstrakt(:proxy => [:abstract])
    t.afleveringsaar(:proxy => [:originInfo, :dataIssued])
    t.studium(:proxy => [:originInfo, :location, :physicalLocation])
    t.opgavesprog(:proxy => [:language, :languageTerm])
    t.opgavetype(:proxy => [:genre])


  end # set_terminology


  define_template :name do |xml, gn, sn|
    xml.name {
      xml.namePart(gn, :type=>"given")
      xml.namePart(sn, :type=>"family")
      xml.role {
        xml.roleTerm("author", :authority => "marcrelator", :type => "text")
      }
    }
  end

  def self.xml_template
    Nokogiri::XML::Builder.new do |xml|
      xml.mods(MODS_PARAMS) {
        xml.titleInfo {
          xml.title
          xml.subtitle
        }
        xml.abstract
        xml.originInfo {
          xml.dateIssued
          xml.location {
            xml.physicalLocation
          }
        }
        xml.typeOfRessource
        xml.genre
        xml.language {
          xml.languageTerm
        }
      }
    end.doc
  end

=begin
  #ABWE added this method.
  def self.xml_template
    Nokogiri::XML.parse '<mods xmlns="http://www.loc.gov/mods/v3" version="3.0"  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3
     http://www.loc.gov/standards/mods/v3/mods-3-0.xsd">
   <titleInfo>
       <title></title>                                   <!-- title -->
       <subTitle></subTitle>                      <!-- undertitel -->
   </titleInfo>

   <name type="personal">
       <namePart></namePart>                 <!-- Forfatter author for og efternavn -->
       <role>
           <roleTerm authority="marcrelator" type="text">Creator</roleTerm> <!-- author role -->
       </role>
   </name>
   <abstract></abstract>            <!-- Beskrivelse /Abstract -->
   <originInfo>
          <dataIssued></dateIssued>                             <!-- Afleveringsaar -->
          <location>
               <physicalLocation></physicalLocation>              <!--  Studium -->
          </location>
     </originInfo>

    <typeOfResource></typeOfResource>                          <!-- Opgavetype -->

     <genre></genre>
     <language>
           <languageTerm code="code" authority="iso369-2b">dan<languageTerm>   <!-- Opgavesprog -->
     </language>   
</mods>'
  end
=end

  def insert_author(gn,sn)
    sibling = find_by_terms(:name).last
    if (sibling.nil?)
      add_child_node(ng_xml.root,:name, gn,sn)
    else
      add_next_sibling_node(sibling,:name, gn,sn)
    end
    content_will_change!
  end

  def remove_authors
    nodes = find_by_terms(:name)
    if nodes.size > 0
      nodes.each { |n| n.remove }
      content_will_change!
    end
  end

  # return a list of all authors on the form [{sn => 'family name', gn => 'given name'},...]
  # assuming all name-elements contains authors
  def get_authors
   retval = []
   nodes = find_by_terms(:name)
   nodes.each do |n|
	gn = ""
	sn = ""
	author = {}
	n.children.each do |c|
	  type = c.attr("type");
	  if (c.name == 'namePart' and type == 'family') 
	    author["sn"] = c.inner_text
	  end
	  if (c.name == 'namePart' and type == 'given') 
	    author["gn"] = c.inner_text
	  end
        end
	retval.push author	
   end
   return retval
  end

end # class
