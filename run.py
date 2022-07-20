#!/usr/bin/python3

import time
import sys
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from fake_useragent import UserAgent
import argparse

class fetcher:
    def __init__(self, url, output):
        self.url = url
        self.output = output

parser = argparse.ArgumentParser(description="fetcher data script", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("-u", "--url", help="url to fetch")
parser.add_argument("-o", "--output", help="output file")

if len(sys.argv)==1:
    parser.print_help()
    parser.exit()
args = parser.parse_args()

data = fetcher(str(args.url), str(args.output))
ua = UserAgent(use_cache_server=False)
srv=Service("/usr/bin/chromedriver")

userAgent = ua.random
options = Options()
options.add_argument('--headless')
options.add_experimental_option ('excludeSwitches', ['enable-logging'])
options.add_argument("start-maximized")
options.add_argument('window-size=1920x1080')
options.add_argument('--no-sandbox')
options.add_argument('--disable-gpu')
options.add_argument(f'user-agent={userAgent}')
options.add_argument('--disable-dev-shm-usage')        
options.binary_location = "/usr/bin/chromium-browser"
driver = webdriver.Chrome (service=srv, options=options)
driver.get (data.url)
with open(data.output, "w") as data:
    data.write(driver.page_source)
