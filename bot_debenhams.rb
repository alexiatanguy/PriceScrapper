require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require_relative 'colors'

class Debenhams
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
    browser.visit "https://www.debenhams.com/"

    browser.find('.dbh-search-input').set(keyword)
    browser.find('.dbh-search-submit').click

    loop do
      sleep(2)
      print('Loading...
      ')
      if driver.execute_script('return document.readyState') == "complete"
        break
      end
    end

    doc = Nokogiri::HTML(driver.page_source);

    prices = doc.css(".dbh-price > span");
    names = doc.css(".dbh-product-name");
    array_names = []
    array_prices = []

    names.each do |name|
      array_names << name.inner_text
    end

    prices.each do |price|
      array_prices << price.inner_text
    end

    if array_names.count === array_prices.count && array_names != 0
      h = Hash[array_names.zip array_prices]

      puts("
      DEBENHAMS:".bg_red.underline)
      puts("
      -------------------------------------------------------")
      h.each do |key, value|
        puts "-#{key.to_s.cyan}: #{value.red}
        "
      end
      puts("
      -------------------------------------------------------")
    end

    Capybara::Selenium::Driver.class_eval do
      def quit
        puts "Press RETURN to quit the browser"
        $stdin.gets
        @browser.quit
      rescue Errno::ECONNREFUSED
      end
    end
  end
end