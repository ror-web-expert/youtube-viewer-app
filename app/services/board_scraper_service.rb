class BoardScraperService
  def initialize(job_listing)
    @job_listing = job_listing
    @url = job_listing.source_url
    @selectors = JSON.parse(job_listing.listing_selector)
    @session = Capybara::Session.new(:selenium)
  end

  def scrape_and_parse
    visit_and_apply_filters
    sleep(2)

    scrape_and_parse_page(@session.body)

    while has_next_page?
      click_next_page
      sleep(2)
      scrape_and_parse_page(@session.body)
    end

    close_browser
  end

  private

  def scrape_and_parse_page(html)
    page = Nokogiri::HTML(html)
    page.css(@selectors["job-container-list"]).each do |job_card|
      main_selector_hash = extract_data_from_selector(job_card, @selectors["main_selector"])
      response_data = extract_data_from_selector(job_card, @selectors["response_selector"])
      create_job_details(main_selector_hash, response_data)
    end
  end

  def has_next_page?
    return false unless pagination.present?
    @session.has_css?(pagination["next_button"])
  end

  def pagination
    @pagination ||= @selectors["pagination"]
  end

  def click_next_page
    next_button = @session.find(pagination["next_button"])
    next_button.click
  end

  def visit_and_apply_filters
    @session.visit @url
    apply_search_filters if @selectors["search"].present?
  end

  def create_job_details(main_data, response_data)
    @job_listing.job_details.create!(
      title: main_data["title"],
      scraped_url: full_url(main_data["source_url"]),
      response_data: response_data
    )
  end

  def extract_data_from_selector(element, selector)
    data_hash = {}

    selector.each do |key, value|
      data_hash[key] = key.include?("source_url") ? full_url(element.css(value).attr("href").value) : element.css(value).text
    end

    data_hash
  end

  def apply_search_filters
    search_selector = @selectors["search"]
    find_and_set(search_selector['search_input'])
    find_and_send(search_selector['search_button'])
  end

  def find_and_set(element_info)
    @session.find(element_info["id"]).set(element_info["value"])
  end

  def find_and_send(element_info)
    @session.find(element_info["id"]).send(element_info["value"])
  end

  def full_url(path)
    URI.join(@url, path).to_s
  end

  def close_browser
    @session.driver.quit
  end
end
