#FLASK_APP=flask_demo.py
#export FLASK_ENV=development
#cd /pygal/course_demos/m4-d04-Flask-app
# run file - python m4-d04-Flask-app.py
# go to the url- http://127.0.0.1:8970/funnel
# and also - http://127.0.0.1:8970/bar-base64

import pygal 
from pygal.style import CleanStyle
from flask import Flask, render_template


app = Flask(__name__)

@app.route('/funnel')
@app.route('/')
def home():
  funnel_chart = pygal.Funnel(style=CleanStyle)

  funnel_chart.title = 'Food Delivery Stats'
  funnel_chart.x_labels = ['Install', 'Register', 
                           'Order', 'Monthly Order' ,
                           'Weekly Order', 'Daily Order'
                           ]
  funnel_chart.add('Install', [10064])
  funnel_chart.add('Register', [7473])
  funnel_chart.add('Order', [6395])
  funnel_chart.add('Monthly Order', [5254])
  funnel_chart.add('Weekly Order', [1805])
  funnel_chart.add('Daily Order', [429])
  
  return funnel_chart.render_response()

@app.route('/bar-base64')
def bar_base64():
   bar_chart = pygal.Bar()
   bar_chart.title = 'Average Fixed Acidity ' + \
                     'By Wine Quality'
   bar_chart.x_title = 'Quality of Wine'
   
   bar_chart.x_labels = range(3, 9)
   bar_chart.add('Fixed Acidity', 
                 [8.36, 7.78, 8.17, 
                 8.35, 8.87, 8.57])
   bar_chart.add('Volatile Acidity', 
                 [0.88, 0.69, 0.58, 0.5,
                  {'value':0.4}, 0.42])

   bar_chart = bar_chart.render_data_uri()

   return render_template('chart_template.html', 
                          chart=bar_chart)

if __name__ == '__main__':
     app.run(port= 8970)

#FLASK_APP=flask_demo.py
#export FLASK_ENV=development

