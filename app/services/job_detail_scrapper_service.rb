class JobDetailScrapperService
  def initialize(job_detail)
    @job_detail = job_detail
    @url = @job_detail.scraped_url
    @job_listing = @job_detail.job_listing
    @selectors = JSON.parse(@job_listing.detail_selector) if @job_listing.detail_selector.present?
    @session = Capybara::Session.new(:selenium)
  end

  def scrape_and_parse
    @session.visit @url

    sleep(2)

    page = Nokogiri::HTML(@session.body)
    page.css(@selectors["job-detail-container"]).each do |job_detail|
      response_data = extract_data_from_selector(job_detail, @selectors["response_selector"])
      response_data = @job_detail.response_data.merge(response_data)
      @job_detail.update(response_data: response_data)
    end

    close_browser
  end

  def extract_data_from_selector(element, selector)
    data_hash = {}
    selector.keys.each do |index|
      data_hash[index] = element.css(selector[index]&.squish).text
    end

    data_hash
  end

  private

  def base_url(source_url)
    parsed_url = URI.parse(source_url)
    "#{parsed_url.scheme}://#{parsed_url.host}"
  end

  def close_browser
    @session.driver.quit
  end
end
