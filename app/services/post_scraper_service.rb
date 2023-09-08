class PostScraperService
  include GenericFunctionality

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
    accept_cookies if cookies_modal_present?
    sleep(2)
    page = Nokogiri::HTML(@session.body)
    page.css(@selectors["job-detail-container"]).each do |post|
      response_data = extract_data_from_selector(post, @selectors["response_selector"])
      specialities = { specialities: filter_by_title(@post.title.squish) }
      response_data = response_data.merge(specialities) if specialities.present?
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
        if index.include?('_url')
          data_hash[index] = element.css(value).attr('href').value
        elsif index.include?("job_description_details")
          data_hash[index] = element.css(value&.squish).inner_html
        else
          data_hash[index] = extract_data_without_hash(element, value)
        end
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
    elsif value.key?("get_paragraph") && value.key?("next_element") && value.key?("next_element_css")
      split_data = element.at_css(value["get_paragraph"]).next_element.css(value["next_element_css"]).map { |lu| { "#{lu.previous_sibling&.previous_sibling&.text}": lu.text } }.to_s
    elsif value.key?("list_attribute") && value.key?("list_attribute_css")
      split_data = {}
      element.css('ul.meta-data-options li').map do |li|
        split_data[li.attr("data-label")] = li.css("span").text
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

  def filter_by_title(title)
    Speciality_List.each do |speciality, details|
      abbreviation = details["Abbreviation"] || details[:Abbreviation]
      other_names = details["OtherNames"] || details[:OtherNames]
      if title.include?(abbreviation) || (abbreviation && title.include?(abbreviation)) || other_names&.any? { |name| title.downcase.include?(name.downcase) }
        return speciality.to_s
      end
    end
    return ""
  end
end
