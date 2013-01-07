Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :cas,
    :host => 'www.kb.dk',
    :login_url => '/cas/login',
    :service_validate_url => '/cas/serviceValidate',
    #:host => HydraHead::Application.config.cas[:host],
    :ssl => true
end

if HydraHead::Application.config.stub_authentication
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:cas, {
    :uid => "username",
    :info => { :name => "Test User" },  
    :extra => {
      :user => "username",
    }
  })
end