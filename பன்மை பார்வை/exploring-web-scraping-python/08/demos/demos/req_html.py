from requests_html import HTMLSession


session = HTMLSession()

start_url = 'https://www.iseecars.com/used-cars/used-tesla-for-sale#Location=66952' + \
            '&Radius=all&Make=Tesla&Model=Model+3&Condition=used&_t=a&maxResults=15' + \
            '&sort=BestDeal&sortOrder=desc&lfc_t0=MTU2Nzk2NzkzNDc2NQ%3D%3D'

r = session.get(start_url)
r.html.render(sleep=5)

tesla = r.html.find('div#cars_v2-result-list article', first=True)

model = tesla.find('h3', first=True).text   # '2017 Tesla Model S 60D - 17,181 mi'
                                            # '2018 Tesla Model 3 Mid range battery - 5,818 mi'

print(model)
