class BoardScraperService
  include GenericFunctionality

  def initialize(board)
    @board = board
    @url = board.source_url
    @selectors = JSON.parse(board.listing_selector)
    @session = start_chrome_headless_session
    @total_urls = []
  end

  def scrape_and_parse
    visit_and_apply_filters

    scroll_page if scrolling_enabled?
    accept_cookies if cookies_modal_present?
    show_all_button_click if show_all_selector_present?
    scrape_and_parse_page(@session.body)

    while has_next_page?
      click_next_page
      scrape_and_parse_page(@session.body)
    end
    delete_expired_jobs
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
    job_list.map{ |job| @total_urls << full_url(job.css('a').first['href'])}
    job_list.each do |job_card|
      main_selector_hash = extract_data_from_selector(job_card, @selectors['main_selector'])
      response_data = extract_data_from_selector(job_card, @selectors['response_selector'])
      create_posts(main_selector_hash, response_data)
    end
  end

  def has_next_page?
    return false unless pagination_present?
    @session.has_css?(@selectors['pagination']['next_button'])
  end

  def pagination_present?
    @selectors['pagination']
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

  def click_next_page
    return unless pagination_present?
    next_button = @session.find(pagination['next_button'])
    next_button.click
    sleep(2)
  end

  def show_all_button_click
    return unless show_all_selector_present?
    show_button = @session.find(show_all_button['show_all_button'])
    show_button.click
    sleep(2)
  end

  def visit_and_apply_filters
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
    URI.join(@url, path).to_s
  end

  def extract_data_from_selector(element, selector)
    data_hash = {}
    selector.each do |key, value|
      if key.include?('source_url')
        data_hash[key] = full_url(element.css(value).attr('href').value)
      elsif key.include?('job_type')
      data_hash[key] = element.css(value)&.text&.gsub(/Regular\s*:?/i, ' ')&.squish
      else
        data_hash[key] = element.css(value).text.squish
      end
    end
    data_hash
  end

  def create_posts(main_data, response_data)
    scraped_url = full_url(main_data['source_url'])

    @board.posts.find_or_initialize_by(scraped_url: scraped_url).tap do |post|
      post.update!(
        title: main_data['title'],
        response_data: response_data
      )
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

  def delete_expired_jobs
    previous_jobs = @board.posts.pluck(:scraped_url)
    expired_jobs = previous_jobs - @total_urls
    Post.where(scraped_url: expired_jobs).destroy_all
  end
end
