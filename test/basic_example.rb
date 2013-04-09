require 'rubygems'
require "test/unit"
require 'selenium-webdriver'

class ExampleTest < Test::Unit::TestCase
  def setup
    caps = Selenium::WebDriver::Remote::Capabilities.firefox
    caps.version = "5"
    caps.platform = :XP
    caps[:name] = "Testing Selenium 2 with Ruby on Sauce"

    @driver = Selenium::WebDriver.for(
        :remote,
        :url => "http://abwesth:48951bbe-64b5-45c5-b14e-77eb86f320cd@ondemand.saucelabs.com:80/wd/hub",
        :desired_capabilities => caps)
  end

  def test_sauce
    @driver.navigate.to "http://saucelabs.com/test/guinea-pig"
    assert @driver.title.include?("I am a page title - Sauce Labs")
  end

  def teardown
    @driver.quit
  end
end