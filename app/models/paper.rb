# app/models/opgave.rb
# a Fedora object for en Opgave hydra content type
class Paper < ActiveFedora::Base


  has_metadata :name=>'rightsMetadata', :type=> Hydra::Datastream::RightsMetadata
  has_metadata :name=>'descMetadata', :type=> OpgaveModsDatastream
  has_metadata :name => 'techMetadata', :type => ActiveFedora::SimpleDatastream do |m|
    m.field "original_filename", :string
    m.field "mime_type", :string
  end

  attr_accessor = :title, :undertitel, :abstrakt, :afleveringsaar, :studium, :opgavetype, :opgavesprog, :has_attached_file

  validates_presence_of :title,
                        :message =>  I18n.t('dias.models.paper.validate.title')


  validates_presence_of :afleveringsaar,
                        :message => I18n.t('dias.models.paper.validate.afleveringsaar')

  validates_length_of  :afleveringsaar, :minimum => 4,
                       :message => I18n.t('dias.models.paper.validate.afleveringsaarlength')



  validates_presence_of :studium,
                        :message =>  I18n.t('dias.models.paper.validate.studium')

  validates_presence_of :opgavetype,
                        :message =>  I18n.t('dias.models.paper.validate.opgavetype')

  validates_presence_of :opgavesprog,
                        :message =>  I18n.t('dias.models.paper.validate.opgavesprog')

  #validate :validate_list_of_authors

  validate :validate_file

  #validates_presence_of :original_filename,
  #                      :message =>  I18n.t('dias.models.paper.validate.file')

  def validate_file
    if (original_filename.nil?)
      self.errors.add(:content,  I18n.t('dias.models.paper.validate.file'))
    elsif (mime_type != "application/pdf")
      self.errors.add(:content, I18n.t('dias.models.paper.validate.pdffile'))
    end
  end



=begin
  validate :must_have_uploaded_pdf_content

  def must_have_uploaded_pdf_content
    #logger.info("content: #{content}")

    if content.content.nil? #|| content.content.original_filename.nil? || content.content.original_filename.to_s.blank?
      errors.add(:content, I18n.t('dias.models.paper.validate.pdffile'))
    end

  end
=end

  # The delegate method allows you to set up attributes on the model that are stored in datastreams
  # When you set :unique=>"true", searches will return a single value instead of an array.
=begin
  delegate :title, :to=>"descMetadata", :unique=>"true"
  delegate :undertitel, :to=>"descMetadata", :unique=>"true"
  delegate :forfatter, :to=>"descMetadata", :unique=>"true"
  delegate :abstract, :to=>"descMetadata", :unique=>"true"
  delegate :afleveringsaar, :to=>"descMetadata", :unique=>"true"
  delegate :studium, :to=>"descMetadata", :unique=>"true"
=end

  delegate_to 'descMetadata', [:title, :undertitel, :abstrakt, :afleveringsaar, :studium, :opgavetype, :opgavesprog ], :unique => true
  #delegate :forfatter, :to=>'descMetadata'
  delegate_to 'techMetadata', [:original_filename, :mime_type, :has_attached_file ], :unique => true
  # delegate_to 'rightsMetadata', [:license, :author]
  delegate :license_title, :to=>'rightsMetadata', :at=>[:license, :title], :unique=>true
  delegate :license_description, :to=>'rightsMetadata', :at=>[:license, :description], :unique=>true
  delegate :license_url, :to=>'rightsMetadata', :at=>[:license, :url], :unique=>true

  delegate :read_access_human_text, :to=>'rightsMetadata', :at=>[:read_access, :human_readable] , :unique=>true
  delegate :discover_access_human_text, :to=>'rightsMetadata', :at=>[:discover_access, :human_readable] , :unique=>true
  delegate :edit_access_human_text, :to=>'rightsMetadata', :at=>[:edit_access, :human_readable] , :unique=>true

  #delegate :uploader_pid, :to=>'rightsMetadata', :at=>[:edit_access, :machine], :unique=>true
  #delegate :read_group, :to=>'rightsMetadata', :at=>[:read_access, :group], :unique=>true
  #delegate :discover_group, :to=>'rightsMetadata', :at=>[:discover_access, :group], :unique=>true
  #delegate :edit_group, :to=>'rightsMetadata', :at=>[:edit_access, :group], :unique=>true
  #        <group>public</group>



  # modify default setter methods for forfatter
  def forfatter(*arg)
    self.get_authors.map{ |a| a["sn"] + ", " +a["gn"] }
  end

  def forfatter=(val)
    # TODO: Check if authorslist has changed
    descMetadata.remove_authors
    val.each do |index, v|
      unless (v.blank? or (v["gn"].blank? and v["sn"].blank?))
        descMetadata.insert_author(v["gn"],v["sn"])
      end
    end
  end

  def validate_list_of_authors
    logger.info("############ validerer forfattere")


    self.get_authors.each do |v|
          logger.info(v["gn"]+ "" + v["sn"])
          if(v["gn"].blank?)
             self.errors.add(:forfatter, "Fornavn mangler")
          end

          if(v["sn"].blank?)
            self.errors.add(:forfatter, "Efternavn mangler")
          end
    end


    if(self.get_authors.blank?)

      logger.info("############ blank!")
      self.errors.add(:forfatter,"Ingen forfatter(e) oprettet for opgaven")
    end

  end



  def get_authors
    descMetadata.get_authors
  end

  def to_solr(solr_doc={})
    super
    solr_doc["licens_t"] = self.license_url
    solr_doc["licens_title_t"] = self.license_title
    solr_doc["licens_description_t"] = self.license_description
    solr_doc["forfatter_t"]  = self.get_authors.map{ |a| a["sn"] + ", " +a["gn"] }.join("; ")
    return solr_doc  
  end


  def add_default_license
    self.license_title = 'Navngivelse-IkkeKommerciel-IngenBearbejdelse 3.0 Unported (CC BY-NC-ND 3.0)'
    self.license_url = 'http://creativecommons.org/licenses/by-nc-nd/3.0/deed.da'
    self.license_description = '<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/deed.da"><img alt="Creative Commons licens" src="http://i.creativecommons.org/l/by-nc-nd/3.0/80x15.png"/></a>'
  end

  def add_user_to_rights_meta_data_stream(user)
    self.edit_access_human_text = user.name + " & Administrators can edit this object"
    self.rightsMetadata.update_permissions({ "person"=>{user.pid=>"edit"}})
    self.rightsMetadata.update_permissions({"group"=>{"public"=>"read","admin"=>"edit"}})
  end


  #add_file and check_file  are modified versions of add_file and check_file from the ADL project
  def add_file(file)
    logger.info(" ########### add file")
    if (file.nil?)
        logger.error("file is nil")
        self.original_filename = nil
        self.has_attached_file = false
        return false
    elsif (!check_file?(file))
        logger.error("error uploading file")
        self.original_filename = nil
        self.has_attached_file = false

        return false
    else
      self.add_file_datastream(file, :label => file.original_filename, :mimeType => file.content_type, :dsid => 'content', :controlGroup => 'M')
      self.original_filename = file.original_filename
      self.mime_type = file.content_type
      self.has_attached_file = true
    end
    return true
  end


  private
  def check_file?(file)
    if file.nil?
      logger.error("no file uploaded.")
      return false;
    end
    @@file_methods = [:size, :content_type, :original_filename,]
    @@file_methods.each do |method_name|
      unless file.respond_to?(method_name)
        logger.error("file dont support #{method_name} method")
        return false
      end
    end
    logger.info("checkfile is true")
    return true
  end
end

