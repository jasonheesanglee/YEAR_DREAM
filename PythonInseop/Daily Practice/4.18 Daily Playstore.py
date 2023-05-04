import selenium
import os
import chromedriver_autoinstaller
import pandas as pd
import time
from selenium import webdriver
from selenium.webdriver.common.by import By

options = webdriver.ChromeOptions()

# options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
browser = webdriver.Chrome("chromedriver", options=options)

app_name = input("댓글을 가져오고자 하는 앱 이름을 입력하세요 : ")

url = "https://play.google.com/store/search?q={}&c=apps&hl=ko"
search_url = url.format(app_name)
# print(search_url)

browser.get(search_url)
app_url = browser.find_element(By.CLASS_NAME, "Qfxief").get_attribute("href")
print(app_url)
browser.get(app_url)

XPATH_google = '//*[@id="yDmH0d"]/c-wiz[2]/div/div/div[1]/div[2]/div/div[1]/c-wiz[4]/section/header/div/div[2]/button'

click = browser.find_element(By.XPATH, XPATH_google)
click.click()


modal = browser.find_element(By.CLASS_NAME, 'fysCi')
class Repeat:
    def repeat_scroll(self):
        while True:
            scroll_location = browser.execute_script("return document.body.scrollHeight")

            browser.execute_script("window.scrollTo(0, document.body.scrollHeight")
            time.sleep(2)
            scroll_height = browser.execute_script("return document.body.scrollHeight")

            if scroll_location == scroll_height:
                break
            else:
                scroll_location = browser.execute_script("return document.body.scrollHeight")

# for i in range(3):
#     browser.execute_script("arguments[0].scrollTo(0, arguments[0].scrollHeight)", modal)
#     time.sleep(3)


# def repeat_scroll(self):
#     while True:
#         scroll_location = browser.execute_script("return document.body.scrollHeight")
#
#         browser.execute_script("window.scrollTo(0, document.body.scrollHeight")
#         time.sleep(2)
#         scroll_height = browser.execute_script("return document.body.scrollHeight")
#
#         if scroll_location == scroll_height:
#             break
#         else:
#             scroll_location = browser.execute_script("return document.body.scrollHeight")


reviews = browser.find_elements(By.CLASS_NAME, "RHo1pe")
num_review = 0
data_list = []

for review in reviews:
    num_review += 1
    if num_review == 25000:
        break
    user_names = review.find_element(By.CLASS_NAME, "X5PpBb").text
    ratings = review.find_element(By.CLASS_NAME, 'iXRFPc').get_attribute('aria-label')[6]
    comments = review.find_element(By.CLASS_NAME, "h3YV2d").text
    dates = review.find_element(By.CLASS_NAME, "bp9Aid").text
    data = {"user name": user_names,
            "rating": ratings,
            "content": comments,
            "date": dates}

    data_list.append(data)
    Repeat.repeat_scroll()

df = pd.DataFrame(data_list)
df.to_csv("./google_playstore.csv", encoding="utf-8-sig")

quit()