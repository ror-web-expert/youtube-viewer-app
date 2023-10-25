require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
# Configurations
binary = ENV.fetch("GOOGLE_CHROME_BIN", nil)
Capybara.register_driver(:headless_chrome) do |app|
  options = {
    args: %w[headless no-sandbox disable-dev-shm-usage disable-gpu remote-debugging-port=9222],
    binary: binary
  }.compact_blank
  
  capabilities = Selenium::WebDriver::Chrome::Options.new(options)
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: capabilities)
end
Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
end

