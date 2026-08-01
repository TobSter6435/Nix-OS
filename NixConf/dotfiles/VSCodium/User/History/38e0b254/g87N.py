import httpx
import json
from bs4 import BeautifulSoup as bs 

class TechScrapper:
    def __init__(self, urls, keywords):
        # 1. SETUP: Was braucht der Scraper, wenn er gestartet wird?
        self.urls = urls
        self.keywords = keywords
        
        # Ein eigener User-Agent ist wichtig, sonst blocken dich viele Seiten sofort
        self.headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
        }

    def fetch_page(self, url):
        # 2. FÄHIGKEIT 1: Webseite herunterladen
        print(f"Lade herunter: {url}")
        try:
            response = httpx.get(url, headers=self.headers, timeout=10.0)
            response.raise_for_status() # Wirft einen Fehler, wenn die Seite z.B. 404 zurückgibt
            return response.text
        except Exception as e:
            print(f"Fehler bei {url}: {e}")
            return None

    def find_keywords(self, html):
        # 3. FÄHIGKEIT 2: HTML durchsuchen
        soup = bs(html, 'html.parser')
        
        # Hol dir den gesamten sichtbaren Text der Seite und mach ihn kleingeschrieben
        page_text = soup.get_text(separator=' ', strip=True).lower()
        
        # Prüfe, welche Keywords vorhanden sind
        found_keywords = {}
        for word in self.keywords:
            word_lower = word.lower()
            if word_lower in page_text:
                # Zählt sogar, wie oft das Keyword vorkommt
                found_keywords[word] = page_text.count(word_lower)
            else:
                found_keywords[word] = 0
                
        return found_keywords

    def run(self):
        # 4. DER CHEF: Diese Methode steuert den ganzen Ablauf
        results = {}
        
        for url in self.urls:
            html = self.fetch_page(url)
            if html:
                # Wenn wir HTML bekommen haben, such die Keywords
                keyword_data = self.find_keywords(html)
                results[url] = keyword_data
                
        return results

# --- So benutzt du deine neue Klasse ---

if __name__ == "__main__":
    meine_seiten = [
        "https://example.com",
        "https://www.python.org"
    ]
    meine_keywords = ["domain", "python", "javascript", "code"]
    
    # 1. Erschaffe den Arbeiter (Objekt instanziieren)
    scraper = TechScrapper(urls=meine_seiten, keywords=meine_keywords)
    
    # 2. Lass ihn arbeiten
    ergebnisse = scraper.run()
    
    # 3. Ergebnisse schön als JSON ausgeben
    print(json.dumps(ergebnisse, indent=4, ensure_ascii=False))