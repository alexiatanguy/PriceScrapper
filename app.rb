require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require_relative 'colors'
require_relative "bot_boots"
require_relative "bot_john_lewis"
require_relative "bot_debenhams"

puts("
 ____________
|PRODUCT NAME|".cyan.bold.underline)
puts("
")
print(">")
product = gets.chomp

boots = Boots.new
boots.search(product)

john_lewis = JohnLewis.new
john_lewis.search(product)

debenhams = Debenhams.new
debenhams.search(product)
