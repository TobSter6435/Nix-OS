import httpx
import json
from bs4 import BeutifulSoup as bs 


urls = []



class TechScrapper:
    def __init__(self, url):
        self.url = url
    
    def get_html(self):
        response = httpx.get(self.url)
        return response.text
    
    def get_soup(self):
        html = self.get_html()
        soup = bs(html, 'html.parser')
        return soup


if __name__ == "__main__":
    for url in urls:
        scrapper = TechScrapper(url)
        soup = scrapper.get_soup()
        print(soup)