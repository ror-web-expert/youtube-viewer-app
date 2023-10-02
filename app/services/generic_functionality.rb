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
    Capybara::Session.new(:selenium_chrome_headless)
  end

  def filter_by_title(title)
    temp_title = remove_standard_words(title)&.tr("()","")&.squish
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
end
