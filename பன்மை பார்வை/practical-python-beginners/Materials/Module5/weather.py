# Note you need to run 'pip install requests' to use the requests module
import requests
  
api_key = '67da29cb91129f1a68c1c06c1be92daa'
city = 'Orlando'
url = 'http://api.openweathermap.org/data/2.5/weather?q='+city+'&units=imperial&appid='+api_key
request = requests.get(url)

weather_json = request.json()

description = weather_json.get('weather')[0].get('description')
temp_min = weather_json.get('main').get('temp_min')
temp_max = weather_json.get('main').get('temp_max')

print("Today's forecast is " + description)
print("With a minimum temperature of " + str(temp_min) + " degrees")
print("And a maximum temperature of " + str(temp_max) + " degrees")

