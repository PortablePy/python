#
# os.path தொகுதிடன் பணியாற்றுவதற்கான எடுத்துக்காட்டு கோப்பு
#

import os as முறைமை
from os import path as பாதை

import datetime as திகதி
from datetime import date as தேதி
from datetime import time as நேரம்1
from datetime import timedelta as கழிந்தநேரம்

import time as நேரம்


#from datetime import date, time, timedelta as தேதி, நேரம், கழிந்தநேரம்

def   முதன்மை():
  # இயக்க முறைமையின் பெயரை அச்சிடுக
  print (முறைமை.name)
  
  # உருப்படி இருப்பதையும் சரிபார்க்கவும் மற்றும் வகை அறிதல்
  print ("உருப்படி உள்ளதா? " + str(பாதை.exists("உரைகோப்பு.உரை")))
  print ("உருப்படி ஒரு கோப்பு வகையா?  " + str(பாதை.isfile("உரைகோப்பு.உரை")))
  print ("உருப்படி ஒரு அடைவு வகையா?  " + str(பாதை.isdir("உரைகோப்பு.உரை")))
  
  #  கோப்பு பாதைகளுடன் வேலை செய்யுங்கள்
  print ("உருப்படியின் பாதை: " + str(பாதை.realpath("உரைகோப்பு.உரை")))
  print ("உருப்படியின் பாதை மற்றும் பெயர்: " + str(பாதை.split(பாதை.realpath("உரைகோப்பு.உரை"))))
  
  # மாற்றியமைக்கும் நேரத்தைப் பெறுங்கள்
  நே = நேரம்.ctime(பாதை.getmtime("உரைகோப்பு.உரை"))
  print (நே)
  print (திகதி.datetime.fromtimestamp(பாதை.getmtime("உரைகோப்பு.உரை")))
  
  # உருப்படி எவ்வளவு காலத்திற்கு முன்பு மாற்றப்பட்டது என்பதைக் கணக்கிடுங்கள்
  கடந்தநே= திகதி.datetime.now() - திகதி.datetime.fromtimestamp(பாதை.getmtime("உரைகோப்பு.உரை"))
  print ("இது கோப்பு மாற்றியமைக்கப்பட்டதிலிருந்து " + str(கடந்தநே) + "நேரம் ஆகும்")
  print ("அல்லது, " + str(கடந்தநே.total_seconds()) + " வினாடிகள்")


if __name__ == "__main__":
  முதன்மை()
