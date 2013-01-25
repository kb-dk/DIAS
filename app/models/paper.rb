# app/models/opgave.rb
# a Fedora object for en Opgave hydra content type
class Paper < ActiveFedora::Base


  has_metadata :name=>'rightsMetadata', :type=> Hydra::Datastream::RightsMetadata
  has_metadata :name=>'descMetadata', :type=> OpgaveModsDatastream
  has_metadata :name => 'techMetadata', :type => ActiveFedora::SimpleDatastream do |m|
    m.field "original_filename", :string
    m.field "mime_type", :string
  end
  
  attr_accessor = :title, :undertitel, :forfatter, :abstrakt, :afleveringsaar, :studium, :opgavetype, :opgavesprog

  validates_presence_of :afleveringsaar,
                        :message => I18n.t('dias.models.paper.validate.afleveringsaar')

  validates_presence_of :title,
                        :message =>  I18n.t('dias.models.paper.validate.title')


  validate :validate_file

  def validate_file
    if (original_filename.nil?)
      self.errors.add(:content, I18n.t('dias.models.paper.validate.filepresent'))
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

  delegate_to 'descMetadata', [:title, :undertitel, :forfatter, :abstrakt, :afleveringsaar, :studium, :opgavetype, :opgavesprog ], :unique => true
  delegate_to 'techMetadata', [:original_filename, :mime_type ], :unique => true



  #add_file and check_file  are modified versions of add_file and check_file from the ADL project
  def add_file(file)
    if (file.nil?)
        logger.debug("file is nil")
        self.original_filename = nil
    elsif (!check_file?(file))
        logger.error("error uploading file")
        self.original_filename = nil
    else
      self.add_file_datastream(file, :label => file.original_filename, :mimeType => file.content_type, :dsid => 'content', :controlGroup => 'M')
      self.original_filename = file.original_filename
      self.mime_type = file.content_type
    end
    return true
  end


  private
  def check_file?(file)
    @@file_methods = [:size, :content_type, :original_filename,]
    @@file_methods.each do |method_name|
      unless file.respond_to?(method_name)
        logger.error("file dont support #{method_name} method")
        return false
      end
    end
    logger.error("checkfile is true")
    return true
  end
end

