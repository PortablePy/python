from selenium import webdriver

driver = webdriver.Firefox()
driver.get('https://selenium.dev')

element_id = driver.find_element_by_id('gsc-iw-id1')
print(element_id)

element_name = driver.find_element_by_name('submit')
print(element_name)

element_xpath = driver.find_element_by_xpath("//section[@class = 'hero homepage']/h1[1]")
print(element_xpath)

element_classname = driver.find_element_by_class_name('selenium-backers')
print(element_classname)

driver.close()
