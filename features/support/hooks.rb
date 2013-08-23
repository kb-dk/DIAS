require 'capybara/rspec'
require 'rest_client'

Before('@omniauth_test') do

  load "#{Rails.root}/db/seeds.rb"

  OmniAuth.config.test_mode = true

  OmniAuth.config.add_mock(:cas, {
      :uid => 'http://xxxx.com/openid?id=118181138998978630963',
      :info => { :name => 'Test User' },
      :extra => {
          :user => 'Test User',
          :gn => 'Test',
          :sn => 'User',
          :alephPID => 'spec-admin-pid'
      }
  })

end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end

#Clean up all the test data after the search scenario has been tested
After('@search_test') do
  papers = Paper.all
  papers.each do |paper|
    paper.delete
  end
end