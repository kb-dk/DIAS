class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller  
# Adds Hydra behaviors into the application controller 
  include Hydra::Controller::ControllerBehavior

  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'blacklight'

  protect_from_forgery

  # set the locale
  before_filter :set_locale
 
  def set_locale
    I18n.locale =  params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
end
