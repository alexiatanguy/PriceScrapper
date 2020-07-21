require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require_relative 'colors'

class JohnLewis
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.javascript_driver = :chrome
  Capybara.configure do |config|
    config.default_max_wait_time = 10 # seconds
    config.default_driver = :selenium
  end

  def search(keyword)

    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit "https://www.johnlewis.com"
    sleep(1)

    browser.find('button[data-test="allow-all"]').click
    browser.find("#desktopSearch").set(keyword)
    browser.find('button', match: :first).click

    loop do
      sleep(2)
      print('Loading...
      ')
      if driver.execute_script('return document.readyState') == "complete"
        break
      end
    end

    doc = Nokogiri::HTML(driver.page_source);

    prices = doc.css(".product-card__price-span");
    names = doc.css("span.product-card__title-inner");

    array_names = []
    array_prices = []

    names.each do |name|
      array_names << name.children
    end

    prices.each do |price|
      array_prices << price.inner_text
    end

    if array_names.count === array_prices.count && array_names != 0
      h = Hash[array_names.zip array_prices]

      puts("
      JOHN LEWIS:".bg_red.underline)
      puts("
      -------------------------------------------------------")
      h.each do |key, value|
        puts "-#{key.to_s.cyan}: #{value.red.bg_grey}
        "
      end
      puts("
      -------------------------------------------------------")
    end

  end

end