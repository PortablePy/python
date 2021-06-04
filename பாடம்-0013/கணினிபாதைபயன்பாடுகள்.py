#
# os.path தொகுதிடன் பணியாற்றுவதற்கான எடுத்துக்காட்டு கோப்பு
#

import os
from os import path
import datetime
from datetime import date, time, timedelta
import time

def   முதன்மை():
  # இயக்க முறைமையின் பெயரை அச்சிடுக
  print (os.name)
  
  # உருப்படி இருப்பதையும் சரிபார்க்கவும் மற்றும் வகை அறிதல்
  print ("உருப்படி உள்ளதா? " + str(path.exists("உரைகோப்பு.உரை")))
  print ("உருப்படி ஒரு கோப்பு வகையா?  " + str(path.isfile("உரைகோப்பு.உரை")))
  print ("உருப்படி ஒரு அடைவு வகையா?  " + str(path.isdir("உரைகோப்பு.உரை")))
  
  #  கோப்பு பாதைகளுடன் வேலை செய்யுங்கள்
  print ("உருப்படியின் பாதை: " + str(path.realpath("உரைகோப்பு.உரை")))
  print ("உருப்படியின் பாதை மற்றும் பெயர்: " + str(path.split(path.realpath("உரைகோப்பு.உரை"))))
  
  # மாற்றியமைக்கும் நேரத்தைப் பெறுங்கள்
  நேரம் = time.ctime(path.getmtime("உரைகோப்பு.உரை"))
  print (நேரம்)
  print (datetime.datetime.fromtimestamp(path.getmtime("உரைகோப்பு.உரை")))
  
  # உருப்படி எவ்வளவு காலத்திற்கு முன்பு மாற்றப்பட்டது என்பதைக் கணக்கிடுங்கள்
  கடந்தநேரம்= datetime.datetime.now() - datetime.datetime.fromtimestamp(path.getmtime("உரைகோப்பு.உரை"))
  print ("இது கோப்பு மாற்றியமைக்கப்பட்டதிலிருந்து " + str(கடந்தநேரம்) + "நேரம் ஆகும்")
  print ("அல்லது, " + str(கடந்தநேரம்.total_seconds()) + " வினாடிகள்")


if __name__ == "__main__":
  முதன்மை()
