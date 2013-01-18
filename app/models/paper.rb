
# app/models/opgave.rb
# a Fedora object for en Opgve hydra content type
class Paper < ActiveFedora::Base
  include Hydra::ModelMethods

  has_metadata :name=>'rightsMetadata', :type=> Hydra::Datastream::RightsMetadata
  has_metadata :name=>'descMetadata', :type=> OpgaveModsDatastream
  #has_file_datastream :name=>'content', :type=> Hydra::Models::FileAsset

  attr_accessor = :title, :undertitel, :forfatter, :abstrakt, :afleveringsaar, :studium, :opgavetype, :opgavesprog

  validates_presence_of :title,
                        :message =>  I18n.t('dias.models.paper.validate.title')

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


end

