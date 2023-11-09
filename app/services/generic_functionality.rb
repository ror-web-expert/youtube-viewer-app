module GenericFunctionality
  def close_browser
    @session.driver.quit
  end

  def cookies_modal_present?
    @selectors['cookies_modal'] && @session.has_css?(@selectors['cookies_modal']['id'], wait: 10)
  end

  def accept_cookies
    cookies_modal = @selectors['cookies_modal']
    @session.click_button(cookies_modal['button_text']) if cookies_modal_present?
    sleep(2)
  end

  def start_chrome_headless_session
    Capybara::Session.new(:selenium)
  end

  def filter_by_title(title)
    temp_title = remove_standard_words(title)&.tr("()", "")&.squish
    Speciality_List.each do |speciality, details|
      abbreviation = details["Abbreviation"] || details[:Abbreviation]
      other_names = details["OtherNames"] || details[:OtherNames]
      if (abbreviation.present? && temp_title.split(/\s+/).include?(abbreviation)) || other_names&.any? { |name| temp_title.downcase.include?(name.downcase) }
        return abbreviation
      end
    end
    return title.include?("ICU") ? "ICU" : nil
  end

  def remove_standard_words(title)
    standard_words = ["Nursing", "ICU", "Nurse", "RN", "Registered"]
    words_to_remove = standard_words.map { |word| Regexp.escape(word) }
    pattern = Regexp.new("\\b(?:#{words_to_remove.join('|')})\\b", Regexp::IGNORECASE)
    title.gsub(pattern, '')
  end

  def convert_to_uppercase_with_underscores(title)
    return title.upcase.gsub(/\s+/, '_')
  end

  def hash_selector(selector)
    selector.class == Hash ? selector : JSON.parse(selector)
  end

  def get_listing_selector(title)
    get_constant(title)[:listing_selector].to_json if get_constant(title).present?
  end

  def get_detail_selector(title)
    get_constant(title)[:detail_selector].to_json if get_constant(title).present?
  end

  def get_logo(title)
    get_constant(title)[:logo]
  end

  def get_constant(title)
    convert_to_uppercase_with_underscores(title)&.safe_constantize
  end

  def standardise_job_type(job_type)
    case job_type
    when  *["Temporary Full Time", "Full Time", "Full-Time", "FT"]
      "Full Time"
    when *["Temporary Part Time", "Part Time", "Part-Time", "PT"]
      "Part Time"
    else
      nil
    end
  end

  def standardise_remote_type(job_type)
    case job_type
    when  *["Remote", "remote", "Yes", "yes"]
      "Yes"
    else
      "No"
    end
  end

  def standardise_shift_type(shift_type)
    case shift_type
    when  *["Nights", "Night"]
      "Night"
    when *["Days", "Day"]
      "Day"
    when *["Evenings", "Evening"]
      "Evening"
    when *["Varies", "Varied", "Varie"]
      "Varies"
    when *["Mids", "Mid"]
      "Mid"
    else
      nil
    end
  end
end
