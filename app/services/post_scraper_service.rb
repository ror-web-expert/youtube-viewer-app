class PostScraperService
  def initialize(post)
    @post = post
    @url = @post.scraped_url
    @board = @post.board
    @selectors = JSON.parse(@board.detail_selector) if @board.detail_selector.present?
    @session = Capybara::Session.new(:selenium)
  end

  def scrape_and_parse
    @session.visit @url

    sleep(2)

    page = Nokogiri::HTML(@session.body)
    page.css(@selectors["job-detail-container"]).each do |post|
      response_data = extract_data_from_selector(post, @selectors["response_selector"])
      response_data = @post.response_data.merge(response_data)
      @post.update(response_data: response_data)
    end

    close_browser
  end

  def extract_data_from_selector(element, selector)
    data_hash = {}

    selector.each do |index, value|
      if value.is_a?(Hash)
        data_hash[index] = extract_data_with_hash(element, value)
      else
        data_hash[index] = extract_data_without_hash(element, value)
      end
    end

    data_hash
  end

  def extract_data_with_hash(element, value)
    if value.key?("get_paragraph") && value.key?("split_base") && value.key?("need_text")
      selected_element = element.at_css(value["get_paragraph"])
      return nil unless selected_element
      split_data = selected_element.next_element.text.split(/#{Regexp.escape(value["split_base"])}/i)
      if split_data.length > 1
        split_data.send(value["need_text"])
      else
        match = split_data.first.match(/hourly (pay )?rate:?\s*\$([\d.]+)/i)
        split_data = split_data.first.split(match.to_s)
        split_data.send(value["need_text"])
      end
    end
  end

  def extract_data_without_hash(element, value)
    selected_elements = element.css(value&.squish)
    selected_elements.empty? ? nil : selected_elements.text.sub(':', '')
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
