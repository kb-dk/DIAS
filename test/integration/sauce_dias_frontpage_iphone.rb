require 'rubygems'
require "test/unit"
require 'selenium-webdriver'

class FrontpageTest < Test::Unit::TestCase

  def setup
    caps = Selenium::WebDriver::Remote::Capabilities.iphone
    caps.version = "5.0"
    caps.platform = :MAC
    caps[:name] = "Testing DIAS Frontpage from iPhone"

    @driver = Selenium::WebDriver.for(
        :remote,
        :url => "http://abwesth:48951bbe-64b5-45c5-b14e-77eb86f320cd@ondemand.saucelabs.com:80/wd/hub",
        :desired_capabilities => caps)
  end

  def test_frontpage
    @driver.navigate.to "http://dias.kb.dk"
    assert @driver.title.include?("DIAS")
  end


  def test_faq
    @driver.navigate.to "http://dias.kb.dk/faq?locale=da"
    assert @driver.title.include?("DIAS")
  end

  def test_dias
    @driver.navigate.to "http://dias.kb.dk/kontakt?locale=da"
    assert @driver.title.include?("DIAS")
  end

  def test_af_soegning


      @driver.navigate.to "http://dias.kb.dk"
      element = @driver.find_element(:name, 'q')
      element.send_keys "kristoffer"
      element.submit
      puts @driver.title
      assert @driver.title.include?("geresultater")
      #element = driver.find_element(:data-counter, '1')
  end
 # def test_dias_search
 #   @driver.navigate.to "http://dias.kb.dk/?utf8=✓&search_field%5B%7B%3Avalue%3D%3E%22%22%7D%5D=&q=kristoffer"
 #   assert @driver.title.include?("gresultater")
 # end


  def teardown
    @driver.quit
  end
end