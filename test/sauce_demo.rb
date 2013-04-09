#!/usr/bin/env ruby

require 'rubygems'
require 'selenium-webdriver'

caps = Selenium::WebDriver::Remote::Capabilities.iphone
caps.version = "5.0"
caps.platform = :MAC
caps[:name] = "Testing Selenium 2 with Ruby on Sauce"

driver = Selenium::WebDriver.for(
    :remote,
    :url => "http://abwesth:48951bbe-64b5-45c5-b14e-77eb86f320cd@ondemand.saucelabs.com:80/wd/hub",
    :desired_capabilities => caps)
driver.navigate.to "http://www.google.com"
element = driver.find_element(:name, 'q')
element.send_keys "Hello WebDriver!"
element.submit
puts driver.title
driver.quit