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
end
