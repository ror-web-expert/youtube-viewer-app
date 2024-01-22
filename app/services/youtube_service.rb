
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'nokogiri'
require 'csv'

class YoutubeService
  include GenericFunctionality

  def initialize(url)
    @url = url
    Rails.application.config.capybara_headless = false
    @session = start_chrome_headless_session
  end

  def view_video
    @session.driver.headers = { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" }
    @session.visit(@url)
    sleep(3)
    @session.find(".ytp-play-button.ytp-button").click
    sleep(400)
    binding.pry
    close_browser
  end

end
