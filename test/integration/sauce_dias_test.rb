#!/usr/bin/env ruby
require 'rubygems'
require 'selenium-webdriver'
require 'test_helper'

class SearchTest <  Test::Unit::TestCase
  def setup
    caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer
    caps.version = "9.0"
    caps.platform = :WIN7
    caps[:name] = "Test af soegning paa DIAS"
  end

  test "should return soegeresultater" do

    driver = Selenium::WebDriver.for(
        :remote,
        :url => "http://abwesth:48951bbe-64b5-45c5-b14e-77eb86f320cd@ondemand.saucelabs.com:80/wd/hub",
        :desired_capabilities => caps)
    driver.navigate.to "http://dias.kb.dk"
    element = driver.find_element(:name, 'q')
    element.send_keys "kristoffer"
    element.submit
    puts driver.title
    assert driver.title.include?("geresultater")
    #element = driver.find_element(:data-counter, '1')
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end


  def teardown
    driver.quit
  end
end