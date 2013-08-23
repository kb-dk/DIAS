# -*- encoding : utf-8 -*-

Given /^I am signed in with provider "([^"]*)"$/ do |provider|
  visit new_user_session_path
  page.has_content? 'Velkommen Test User - vi glæder os til, at du uploader dine opgaver'
end

When(/^I navigate to the Upload form$/) do
  visit new_paper_path
  page.has_content? 'Opret Opgave'
end

When(/^I fill out the required fields with valid values$/) do
  fill_in 'paper_title', :with => 'Apache Solr for Muppets'
  fill_in 'paper_undertitel', :with => 'Bluffers guide to Solr'
  fill_in 'paper_abstrakt', :with => 'Some test abstract'
  fill_in 'paper_afleveringsaar', :with => '2013'
  select 'Datalogi', :from => 'paper_studium'
  select 'Engelsk', :from => 'paper_opgavesprog'
  select 'Øvelsesopgave', :from => 'paper_opgavetype'
end

When(/^I upload a PDF file$/) do
  attach_file 'content', './spec/fixtures/test.pdf'
  check 'termsConditionsCheckBox'
end

When(/^post the form$/) do
  click_on 'createAssignmentBtn'
end

Then(/^I should be taken to the show screen for that thesis afterwards$/) do
  page.has_content? 'Apache Solr for Muppets'
end

Given(/^I have uploaded a thesis with the title 'Apache Solr for Muppets'$/) do
  visit root_path
end

When(/^I search for the word 'Muppets'$/) do
  fill_in 'q', :with => 'Muppets'
  click_on 'search'
end

Then(/^I should be shown one search result with the word 'Muppets' in the title$/) do
  page.has_content? 'Muppets'
end
