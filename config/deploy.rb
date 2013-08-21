require "bundler/capistrano"

set :application, "DIAS"
set :repository,  "https://github.com/Det-Kongelige-Bibliotek/DIAS"
set :deploy_to, "/home/dias/deploy"
set :user, "dias"
set :use_sudo, false
set :rails_env, "development"
set :default_shell, "bash -l"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "disdev-01.kb.dk"                          # Your HTTP server, Apache/etc
role :app, "disdev-01.kb.dk"                          # This may be the same as your `Web` server
role :db,  "disdev-01.kb.dk", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
#after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
  # custom task to copy dias.yml to current deploy
   task :config_dias, :roles => :app, :except => { :no_release => true}  do
     run "cp /home/dias/dias.yml #{File.join(current_path,'config')}"
   end;

   task :config_jetty, :roles => :app, :except => { :no_release => true}  do
     run "cd #{current_path}; cp ./solr_conf/conf/schema.xml ../../jetty/solr/development-core/conf"
     run "cd #{current_path}; cp ./solr_conf/conf/schema.xml ../../jetty/solr/test-core/conf"
     run "cd #{current_path}; cp ./solr_conf/conf/solrconfig.xml ../../jetty/solr/development-core/conf"
     run "cd #{current_path}; cp ./solr_conf/conf/solrconfig.xml ../../jetty/solr/test-core/conf"
     run "cd #{current_path}; cp ./fedora_conf/conf/development/fedora.cfg ../../jetty/fedora/default/server/config"
     run "cd #{current_path}; cp ./fedora_conf/conf/test/fedora.cfg ../../jetty/fedora/test/server/config"
   end
 
   # task to seed db
   task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
 end

after "deploy", "deploy:migrate"
after "deploy", "deploy:seed"
after "deploy", "deploy:config_dias"
after "deploy", "deploy:config_jetty"
after "deploy:restart", "deploy:cleanup"

