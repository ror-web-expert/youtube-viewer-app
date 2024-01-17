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
    Rails.application.config.capybara_headless = false
    @session = start_chrome_headless_session
  end

  def scrape_jobs
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
        company = tc.css('span.css-1x7z1ps.eu4oa1w0').text

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
    filename = "public/job_analytics.csv"
    CSV.open(filename, 'w', write_headers: true, headers: ['Company', 'Count']) do |csv|
      @companies.each do |company, count|
        csv << [company, count]
      end
    end
  end
end
