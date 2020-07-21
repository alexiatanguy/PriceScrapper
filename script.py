import requests
from bs4 import BeautifulSoup
import csv
import time

URL = "https://www.boots.com/sitesearch?searchTerm=si_armani"
r = requests.get(URL)

soup = BeautifulSoup(r.content, 'html5lib')
print(soup)
mydivs = soup.findAll("div", {"class": "estore_product_container"})# table = soup.find('div', attrs = {'class':'container'})
# print(mydivs.get_text())
print(mydivs)

price = soup.findAll("div", {"class": "product_price"})# table = soup.find('div', attrs = {'class':'container'})
# print(mydivs.get_text())
print(price)

# filename = 'inspirational_quotes.csv'
# with open(filename, 'w') as f:
#     w = csv.DictWriter(f,['theme','url','img','lines','author'])
#     w.writeheader()
#     for quote in quotes:
#         w.writerow(quote)
