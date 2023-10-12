class PostScraperService
  include GenericFunctionality

  def initialize(post)
    @post = post
    @url = @post.scraped_url
    @board = @post.board
    @selectors = hash_selector(get_detail_selector(@board.title)) if @board.title.present?
    @session = start_chrome_headless_session
  end

  def scrape_and_parse
    @session.visit @url

    sleep(2)
    accept_cookies if cookies_modal_present?
    sleep(2)
    page = Nokogiri::HTML(@session.body)
    page.css(@selectors["job-detail-container"]).each do |post|
      response_data = extract_data_from_selector(post, @selectors["response_selector"])
      response_data["speciality"] = filter_by_title(@post.title.squish)
      response_data = @post.response_data.merge(response_data) if @post.response_data.present?
      @post.update(response_data: response_data, is_scrap: true)
      HtmlParser.new(@post).formatted_markdown
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
          data_hash[index] = url_for_apply_now(element.css(value&.squish)&.attr('href')&.value ||  @session.current_url)
        elsif index.include?("description_raw_html")
          data_hash[index] = element.css(value&.squish)&.inner_html
        elsif index.include?("department")
          data_hash[index] = extract_data_without_hash(element, value)&.gsub(/Department\s*:?/i, ' ')&.squish
        elsif index.include?("shift_type")
          data_hash[index] = extract_data_without_hash(element, value)&.gsub(/\d+\s*-\s*([a-zA-Z]+)/) { $1 }&.squish&.gsub(/Shifts|shift|#\s*:?/i, ' ')&.squish
        elsif index.include?("job_type") || index.include?("schedule")
          data_hash[index] = extract_data_without_hash(element, value)&.gsub(/\d+\s*-\s*([a-zA-Z]+)/) { $1 }&.squish&.gsub(/Weekly|Schedule|Type|Employment|Shifts|Pay|Posted|#\s*:?/i, ' ')&.squish
        elsif index.include?("get_from_content")
          job_description           = extract_data_without_hash(element, value)&.squish
          data_hash["job_type"]     = get_job_type_from_description(job_description) if @post.response_data["job_type"].blank?
          data_hash["salary_range"] = get_salary_range_from_description(job_description)
        else
          data_hash[index] = extract_data_without_hash(element, value)&.gsub(/Shifts|Pay|Posted|Schedule|Date|Facility|Weekly|Job Reference|#\s*:?/i, ' ')&.squish
        end
      end
    end
    data_hash
  end

  def get_job_type_from_description(job_description)
    job_type_regex = /(Full[-\s]?Time|full[-\s]?time|part[-\s]?time|Part[-\s]?Time|prn)/i
    job_type_match = job_description.match(job_type_regex)
    job_type_match[1] if job_type_match
  end

  def get_salary_range_from_description(job_description)
    salary_regex = /up\s+to\s+\$([\d,]+)/i
    second_salary_regex = /\$\d+\.\d{2} - \$\d+\.\d{2}|\$\d+\.\d{2} – \$\d+\.\d{2}/

    if job_description.present? && job_description.match(salary_regex).present?
      salary_match = job_description.match(salary_regex)
      "bonus #{salary_match.to_s }" if salary_match
    elsif job_description.present?
      salary_match = job_description.match(second_salary_regex)
      salary_match.to_s
    end
  end

  def extract_data_with_hash(element, value)
    case
    when value.key?("get_paragraph") && value.key?("split_base") && value.key?("need_text")
      extract_text_from_paragraph(element, value)
    when value.key?("get_paragraph") && value.key?("next_element") && value.key?("inner_html")
      extract_inner_html(element, value)
    when value.key?("get_paragraph") && value.key?("next_element") && value.key?("next_element_css")
      extract_next_element_css(element, value)
    when value.key?("list_attribute") && value.key?("list_attribute_css")
      extract_list_attributes(element)
    when value.key?("next_sibling") && value.key?("next_element")
      extract_next_sibling_text(element, value)
    else
      nil
    end
  end

  def extract_text_from_paragraph(element, value)
    selected_element = element.at_css(value["get_paragraph"])
    return nil unless selected_element

    split_data = selected_element.next_element.text.split(/#{Regexp.escape(value["split_base"])}/i)
    return nil if split_data.empty?

    split_data.send(value["need_text"])
  end

  def extract_inner_html(element, value)
    if value["get_paragraph"].include?("descHeader")
      input1 = element.at('input[type="hidden"]#descHeader')
      input2 = element.at('input[type="hidden"]#descFooter')
      inner_html_content = ""

      current_element = input1.next_element
      while current_element && current_element != input2
        inner_html_content += current_element.to_s
        current_element = current_element.next_element
      end
    else
      inner_html_content = element.at_css(value["get_paragraph"]).next_element.inner_html
    end

    inner_html_content
  end

  def extract_next_element_css(element, value)
    selected_element = element.at_css(value["get_paragraph"])
    return nil unless selected_element

    selected_element.next_element.css(value["next_element_css"]).map { |lu| { "#{lu.previous_sibling&.previous_sibling&.text}": lu.text } }.to_s
  end

  def extract_list_attributes(element)
    split_data = {}
    element.css('ul.meta-data-options li').map do |li|
      split_data[li.attr("data-label")] = li.css("span").text
    end
    split_data
  end

  def extract_next_sibling_text(element, value)
    element.at(value["element_css"])&.next_element&.next_element&.next_sibling&.text&.squish || ""
  end


  def extract_data_without_hash(element, value)
    selected_elements = element.css(value&.squish)
    selected_elements.empty? ? nil : selected_elements.text.sub(':', '')
  end

  private
  def url_for_apply_now(path)
    if path.start_with?('/')
      parsed_url = URI.parse(@url)
      URI.join("#{parsed_url.scheme}://#{parsed_url.host}", path).to_s
    else
      path
    end
  end
end
