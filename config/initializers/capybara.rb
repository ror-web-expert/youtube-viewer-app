require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
# Configurations
Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.binary = ENV['CHROME_BIN_PATH']
  options.add_argument('--headless')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
end

