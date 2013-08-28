#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
HydraHead::Application.load_tasks

APP_ROOT="."
require 'jettywrapper'

desc 'Start up jetty and run rspec and cucumber tests'
task :ci => ['jetty:unzip', 'jetty:config', 'jetty:start'] do
  puts 'running continuous integration'
  jetty_params = Jettywrapper.load_config
  error = Jettywrapper.wrap(jetty_params) do
    #Rake::Task['spec'].invoke
    Rake::Task['cucumber'].invoke
  end
  raise "test failures: #{error}" if error
end
