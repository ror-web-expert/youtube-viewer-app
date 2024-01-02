require "capybara/cuprite"
Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, headless: true,  window_size: [1400, 1200],
                                timeout: 90, browser_options: { 'no-sandbox': nil })
end
