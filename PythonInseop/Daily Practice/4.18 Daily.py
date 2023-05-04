import selenium
import os
import chromedriver_autoinstaller
import pandas as pd
import time
from selenium import webdriver
from selenium.webdriver.common.by import By

options = webdriver.ChromeOptions()

options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
browser = webdriver.Chrome("chromedriver", options=options)

# -------
print("두 번째, 네이버 뉴스 크롤링하기 - 단, 3페이지 이상 가져오기")
print("제목, 내용, 링크, 언론사")
print()
url = "https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid1=101&sid2=259"
browser.get(url)

title_list = []
content_list = []
link_list = []
press_list = []

page = 1


while page < 6:
    print()
    time.sleep(3)
    print(f"Page {page}")

    title_list = []
    content_list = []
    link_list = []
    press_list = []

    CSS = "dl > dt:nth-child(2) > a"
    CSS_NO_IMG = "dl > dt > a"
    titles = browser.find_elements(By.CSS_SELECTOR, CSS)

    for title in titles:
        title_list.append(title.text)

    contents = browser.find_elements(By.CLASS_NAME, "lede")
    for content in contents:
        content_list.append(content.text)


    links = browser.find_elements(By.CSS_SELECTOR, CSS)
    for link in links:
        if CSS == None:
            CSS = CSS_NO_IMG
        link_list.append(link.get_attribute("href"))

    presses = browser.find_elements(By.CLASS_NAME, "writing")
    for press in presses:
        press_list.append(press.text)


    print(len(title_list))
    for i in title_list:
        print(i)



    print()
    print(len(content_list))
    for j in content_list:
        print(j)

    print()
    print(len(link_list))
    for k in link_list:
        print(k)

    print()
    print(len(press_list))
    for l in press_list:
        print(l)

    print()

    n = page + 1

    page_css = f"#main_content > div.paging > a:nth-child({n})"

    click = browser.find_element(By.CSS_SELECTOR, page_css)
    click.send_keys("\n")

    # title_list = []
    # content_list = []
    # link_list = []
    # press_list = []

    df_title = pd.DataFrame({"title" : title_list,
                            "content" : content_list,
                            "link" : link_list,
                            "press" : press_list})
    # df_content = pd.DataFrame(content_list)
    # df_link = pd.DataFrame(link_list)
    # df_press = pd.DataFrame(press_list)
    df_title.to_csv("./naver_news.csv", encoding="utf-8-sig")
    # naver_news = pd.read_csv("naver_news.csv")
    # naver_news["content"] = content_list
    # naver_news["link"] = df_link
    # naver_news["press"] = df_press

    # naver_news.head()

    page += 1

quit()

