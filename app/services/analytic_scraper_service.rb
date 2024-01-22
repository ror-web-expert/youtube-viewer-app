# app/services/job_scraper_service.rb
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'nokogiri'
require 'csv'

class AnalyticScraperService
  include GenericFunctionality

  def initialize
    @url = "https://www.indeed.com/jobs?q=registered+nurse&l=Arizona"
    Rails.application.config.capybara_headless = true
    @session = start_chrome_headless_session
  end

  def scrape_jobs
    @session.driver.headers = { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" }
    @session.visit(@url)

    retry_with_proxy_if_blocked
    collect_companies

    write_to_csv
    close_browser
  end

  private

  def collect_companies
    @companies = {}
    while true
      html_full = Nokogiri::HTML(@session.body)
      soup = html_full.css('div#jobsearch-Main')

      table_cells = soup.css('td.resultContent')

      table_cells.each do |tc|
        company = tc.css("span[data-testid='company-name']").text

        @companies[company] ||= 0
        @companies[company] += 1
      end

      begin
        @session.find("a[data-testid='pagination-page-next']").click
        sleep(2)

      rescue StandardError
        puts 'No more pages left'
        break
      end
    end
  end

  def write_to_csv
    file_path = Rails.configuration.temp_file_storage('job_analytics.csv')

    CSV.open(file_path, 'w', write_headers: true, headers: ['Company', 'Count']) do |csv|
      @companies.each do |company, count|
        csv << [company, count]
      end
    end
  end
end
