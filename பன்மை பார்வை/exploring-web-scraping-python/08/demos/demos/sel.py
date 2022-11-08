from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
import time


start_url = 'https://www.iseecars.com/used-cars/used-tesla-for-sale#Location=66952' + \
            '&Radius=all&Make=Tesla&Model=Model+3&Condition=used&_t=a&maxResults=15' + \
            '&sort=BestDeal&sortOrder=desc&lfc_t0=MTU2Nzk2NzkzNDc2NQ%3D%3D'

with webdriver.Firefox() as driver:
    wait = WebDriverWait(driver, 10)
    driver.get(start_url)

    time.sleep(10)

    teslas = driver.find_element_by_css_selector('div#cars_v2-result-list article')
    model = teslas.find_element_by_css_selector('h3')

    print(model.text)
