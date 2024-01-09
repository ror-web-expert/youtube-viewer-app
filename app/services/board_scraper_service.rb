class BoardScraperService
  include GenericFunctionality

  def initialize(board)
    @board = board
    @url = board.source_url
    @selectors = hash_selector(get_listing_selector(board.title)) if board.title.present?
    Rails.application.config.capybara_headless = true
    @session = start_chrome_headless_session
    @logo = get_logo(board.title)
    @total_urls = []
  end

  def scrape_and_parse
    visit_and_apply_filters

    scroll_page if scrolling_enabled?
    accept_cookies if cookies_modal_present?
    execute_script_for_click_on_body if click_on_body.present?
    show_all_button_click if show_all_selector_present?
    sleep(5)
    scrape_and_parse_page(@session.body)
    while has_next_page?
      click_next_page
      scrape_and_parse_page(@session.body)
    end
    expired_jobs
    close_browser
  rescue => e
    puts "URL: #{Rails.application.credentials.base_url}/admin/boards/#{@board.slug} Error: #{e.message}"
    close_browser
  end

  private

  def scraping_enabled?
    @selectors.key?('job-container-list') &&
      @selectors['main_selector'] &&
      @selectors['response_selector']
  end

  def scrolling_enabled?
    @selectors['scrolling'] && @selectors['scrolling']['scroll_count'].to_i.positive?
  end

  def scrape_and_parse_page(html)
    return unless scraping_enabled?

    page = Nokogiri::HTML(html)
    job_list = page.css(@selectors['job-container-list'])
    job_list.map { |job| @total_urls << full_url(job.css('a').first['href']) }
    job_list.each do |job_card|
      main_selector_hash = extract_data_from_selector(job_card, @selectors['main_selector'])
      response_data = extract_data_from_selector(job_card, @selectors['response_selector'])
      if check_keywords_in_title(main_selector_hash["title"])
        response_data["speciality"] = filter_by_title(main_selector_hash["title"]&.squish) if main_selector_hash["title"].present?
        create_posts(main_selector_hash, response_data)
      end
    end
  end

  def has_next_page?
    return false unless pagination_present?
    if next_button_text_present?
      @session.has_css?(next_button_css, text: next_button_text)
    else
      @session.has_css?(next_button_css)
    end
  end

  def pagination_present?
    @selectors['pagination']
  end

  def next_button_text_present?
    next_button_text.present?
  end

  def next_button_css
    @next_button_css ||= @selectors['pagination']['next_button']
  end

  def next_button_text
    @next_button_text ||= @selectors['pagination']['next_button_text']
  end

  def show_all_selector_present?
    show_all_button && @session.has_css?(show_all_button['show_all_button'])
  end

  def pagination
    @pagination ||= @selectors['pagination']
  end

  def show_all_button
    @show_all_button ||= @selectors['pagination_show_all']
  end

  def click_on_body
    @click_on_body ||= @selectors['click_on_body']
  end

  def execute_script_for_click_on_body
    @session.execute_script('document.querySelector("button").click();')
    sleep(2)
  end

  def click_next_page
    return unless pagination_present?
    if next_button_text_present?
      next_button = @session.find(next_button_css, text: next_button_text)
    else
      next_button = @session.find(next_button_css)
    end
    next_button.click
    sleep(2)
  end

  def show_all_button_click
    return unless show_all_selector_present?
    loop do
      show_button = @session.find(show_all_button['show_all_button'])
      show_button.click
      sleep(2)
      break unless show_all_selector_present?
    end
  end

  def visit_and_apply_filters
    # @session.driver.set_proxy("gate.smartproxy.com", 10000, Rails.application.credentials.smartproxy_username, Rails.application.credentials.smartproxy_password)
    @session.visit(@url)

    apply_search_filters if @selectors['search'].present?
  end

  def apply_search_filters
    search_selector = @selectors['search']
    find_and_set(search_selector['search_input'])
    find_and_send(search_selector['search_button'])
  end

  def find_and_set(element_info)
    @session.find(element_info['id']).set(element_info['value'])
  end

  def find_and_send(element_info)
    @session.find(element_info['id']).send(element_info['value'])
  end

  def full_url(path)
    URI.join(@url, path).to_s rescue path
  end

  def extract_data_from_selector(element, selector)
    data_hash = {}
    selector.each do |key, value|
      if key.include?('source_url')
        data_hash[key] = full_url(element.css(value).attr('href')&.value)
      elsif key.include?('job_type')
        data_hash[key] = element.css(value)&.text&.gsub(/Regular\s*:?/i, ' ')&.squish
      elsif key.include?('location')
        data_hash[key] = element.css(value)&.text&.gsub(/Location|Location:|location|location:|home|remote\s*:?/i, ' ')&.gsub(":"," ")&.squish
      elsif key.include?('remote_type')
        data_hash[key] = standardise_remote_type(element.css(value)&.text)
      else
        data_hash[key] = element.css(value).text.squish
      end
    end
    data_hash
  end

  def create_posts(main_data, response_data)
    scraped_url = full_url(main_data['source_url'])
    response_data["logo"] = @logo
    response_data["job_type"] = if main_data["title"]&.squish.include?("PRN")
                                  standardise_job_type("PRN")
                                else
                                  standardise_job_type(response_data["job_type"]&.gsub("-"," ")&.titleize) if response_data["job_type"].present?
                                end
    response_data["shift_type"] = standardise_shift_type(response_data["shift_type"]&.titleize) if response_data["shift_type"].present?
    @board.posts.find_or_initialize_by(scraped_url: scraped_url).tap do |post|
      post.update!(
        title: main_data['title'],
        is_scrap: false,
        response_data: response_data
      )
    rescue ActiveRecord::RecordNotUnique => e
      next
    end
  end

  def scroll_page
    scroll_count = @selectors['scrolling']['scroll_count'].to_i
    scroll_count.times do
      @session.execute_script('window.scrollTo(0, document.body.scrollHeight);')
      sleep(5)
      @session.execute_script('window.scrollTo(0, 0);')
    end
    sleep(2)
  end

  def expired_jobs
    previous_jobs = @board.posts.pluck(:scraped_url)
    expired_jobs = previous_jobs - @total_urls
    Post.where(scraped_url: expired_jobs).update_all(status: 'expire')
  end

  def check_keywords_in_title(title)
    keywords = ["RN", "Registered Nurse", "Registered Nurses", "RNs"]
    pattern = keywords.join("|")
    regex = /\b(?:#{pattern})\b/i
    return title&.tr("()", "")&.squish&.match?(regex)
  end
end
