require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require_relative 'colors'

class Boots
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
    browser.visit "https://www.boots.com"

    browser.find('.close-btn').click
    browser.find('.search-box').set(keyword)
    browser.find('.submitButton').click

    loop do
      sleep(2)
      print('Loading...
      ')
      if driver.execute_script('return document.readyState') == "complete"
        break
      end
    end

    doc = Nokogiri::HTML(driver.page_source);

    prices = doc.css(".product_price");
    names = doc.css(".product_name > a");
    array_names = []
    array_prices = []

    names.each do |name|
      array_names << name.values[2]
    end

    prices.each do |price|
      array_prices << price.inner_text
    end

    if array_names.count === array_prices.count && array_names != 0
      h = Hash[array_names.zip array_prices]

      puts("
      BOOTS:".bg_red.underline)
      puts("
      -------------------------------------------------------")
      h.each do |key, value|
        puts "-#{key.to_s.cyan}: #{value.red}
        "
      end
      puts("
      -------------------------------------------------------")
    end

  end
end