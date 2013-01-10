
# app/models/opgave.rb
# a Fedora object for en Opgve hydra content type
class Opgave < ActiveFedora::Base
  include Hydra::ModelMethods

  has_metadata :name=>'descMetadata', :type=> OpgaveModsDatastream
  has_metadata :name=>'rightsMetadata', :type=> Hydra::Datastream::RightsMetadata


  # The delegate method allows you to set up attributes on the model that are stored in datastreams
  # When you set :unique=>"true", searches will return a single value instead of an array.
  delegate :title, :to=>"descMetadata", :unique=>"true"
  delegate :undertitel, :to=>"descMetadata", :unique=>"true"
  delegate :forfatter, :to=>"descMetadata", :unique=>"true"
  delegate :abstrakt, :to=>"descMetadata", :unique=>"true"
  delegate :afleveringsaar, :to=>"descMetadata", :unique=>"true"
  delegate :studium, :to=>"descMetadata", :unique=>"true"


end

