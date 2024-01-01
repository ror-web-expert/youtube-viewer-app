# require 'selenium-webdriver'
# require 'nokogiri'
# require 'capybara'
# # Configurations
# Capybara.register_driver :selenium do |app|
#   options = Selenium::WebDriver::Chrome::Options.new
#
#   options.add_argument('--no-sandbox')
#   options.add_argument('--headless')
#   options.add_argument('--disable-gpu')
#   options.add_argument('--disable-dev-shm-usage')
#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end
# Capybara.javascript_driver = :selenium
# Capybara.configure do |config|
#   config.default_max_wait_time = 10 # seconds
#   config.default_driver = :selenium
# end
require "capybara/cuprite"
Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  # Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
  Capybara::Cuprite::Driver.new(app, headless: true,  window_size: [1400, 1200],
                                timeout: 90, browser_options: { 'no-sandbox': nil })
end
