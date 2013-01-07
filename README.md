# DIAS - Digital Indsamling Af Studenteropgaver

for at installere DIAS skal du have følgende installeret

* Ruby 1.9.3 (evt. via rvm)
* Rails 3.1.x
* hydra-jetty


For starte DIAS
* git clone https://github.com/Det-Kongelige-Bibliotek/DIAS.git
* cd hydra_head
* bundle install
* rake db:migrate
* git clone https://github.com/projecthydra/hydra-jetty.git
* rake hydra:jetty:config 
* cd jetty
* java -XX:+CMSPermGenSweepingEnabled -XX:+CMSClassUnloadingEnabled -XX:PermSize=64M -XX:MaxPermSize=128M -jar start.jar 
* rails server
* gå til localhost:3000
