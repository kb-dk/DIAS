Feature: Upload a thesis in PDF format to DIAS

  So that I can publish my thesis in PDF format
  As a user
  I want to be able to upload my thesis in PDF format to DIAS

  @omniauth_test
  Scenario: Successful upload of a PDF format thesis to DIAS
    Given I am signed in with provider "cas"
    When I navigate to the Upload form
    And I fill out the required fields with valid values
    And I upload a PDF file
    And post the form
    Then I should be taken to the show screen for that thesis afterwards

  @omniauth_test
  @search_test
  Scenario: Successful search for a title of a thesis in DIAS
    Given I am signed in with provider "cas"
    And I have uploaded a thesis with the title 'Apache Solr for Muppets'
    When I search for the word 'Muppets'
    Then I should be shown one search result with the word 'Muppets' in the title