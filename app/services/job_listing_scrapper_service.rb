class JobListingScrapperService
  def initialize(job_listing)
    @job_listing = job_listing
    @url = job_listing.source_url
    @selectors = JSON.parse(job_listing.listing_selector)
    @session = Capybara::Session.new(:selenium)
  end

  def scrape_and_parse
    @session.visit @url
    apply_search_filters if @selectors["search"].present?

    sleep(2)

    page = Nokogiri::HTML(@session.body)

    page.css(@selectors["job-container-list"]).each do |job_card|
      main_selector_hash = extract_data_from_selector(job_card, @selectors["main_selector"])
      response_data = extract_data_from_selector(job_card, @selectors["response_selector"])

      @job_listing.job_details.create!(
        title: main_selector_hash["title"],
        scraped_url: main_selector_hash["source_url"],
        response_data: response_data
      )
    end

    close_browser
  end

  def extract_data_from_selector(element, selector)
    data_hash = {}

    selector.keys.each do |index|
      data_hash[index] = index.include?("source_url") ?
                           "#{base_url(@url)}#{element.css(selector[index]).attr("href").value}" :
                           element.css(selector[index]).text
    end

    data_hash
  end

  def apply_search_filters
    search_selector = @selectors["search"]
    search_input = search_selector['search_input']
    search_btn = search_selector['search_button']

    find_and_set(search_input)
    find_and_send(search_btn)
  end

  private

  def find_and_set(element_info)
    element = @session.find(element_info["id"])
    element.set(element_info["value"])
  end

  def find_and_send(element_info)
    element = @session.find(element_info["id"])
    element.send(element_info["value"])
  end

  def base_url(source_url)
    parsed_url = URI.parse(source_url)
    "#{parsed_url.scheme}://#{parsed_url.host}"
  end

  def close_browser
    @session.driver.quit
  end
end
