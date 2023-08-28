require 'nokogiri'
require 'open-uri'

class ScrapperService
  def initialize(job_listing)
    @job_listing = job_listing
    @url = job_listing.source_url
    @selector = job_listing.listing_selector
  end

  def scrape_and_parse
    html = URI.open(@url)
    doc = Nokogiri::HTML(html)

    doc.css('#mosaic-jobResults .job_seen_beacon').each do |job_card|
      title = job_card.css('.jobTitle').text
      scraped_url = job_card.css('.jcs-JobTitle a').text.strip
      @job_listing.job_details.create!(title: title, scraped_url: scraped_url)
    end
  end
end
