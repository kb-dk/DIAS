# DIAS - Digital Indsamling Af Studenteropgaver

for at installere DIAS skal du have følgende installeret

* Ruby 1.9.3 (evt. via rvm)
* Rails 3.1.x


For starte DIAS
* git clone https://github.com/Det-Kongelige-Bibliotek/DIAS.git
* cd dias
* bundle install
* rake db:migrate
* rake db:seed
* rails g hydra:jetty
* rake hydra:jetty:config
* rake jetty:start
* rails g bootstrap:install less
* rails server
* gå til localhost:3000
