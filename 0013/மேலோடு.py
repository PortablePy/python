#
# கோப்பு முறைமை மேலோடு முறைகளுடன் பணிபுரியும் எடுத்துக்காட்டு கோப்பு
#
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import os as முறைமை
from os import path as பாதை
import shutil as மேலோடுபயன்
from shutil import make_archive as காப்பகம் 
from zipfile import ZipFile as இறுக்குகோப்பு

def முதன்மை():
  அச்சிடு (முறைமை.getcwd())  
  # ஏற்கனவே இருக்கும் கோப்பின் நகலை உருவாக்கவும்
  if பாதை.exists("உரைகோப்பு.உரை"):
    # தற்போதைய கோப்பகத்தில் கோப்பிற்கான பாதையைப் பெறுங்கள்
    மூலம் = பாதை.realpath("உரைகோப்பு.உரை");
        
    # பெயருக்கு "காப்பு" சேர்ப்பதன் மூலம் காப்பு நகலை உருவாக்குவோம்
    இலக்கு = மூலம் + ".காப்பு"
    # இப்போது கோப்பின் நகலை உருவாக்க மேலோடு பயன்படுத்தவும்
    மேலோடுபயன்.copy(மூலம்,இலக்கு)
    
    # அனுமதிகள், மாற்றியமைக்கும் நேரங்கள் மற்றும் பிற தகவல்களை நகலெடுக்கவும்
    மேலோடுபயன்.copystat(மூலம், இலக்கு)
    
    # அசல் கோப்பினை மறுபெயரிடுக
    #os.rename("உரைகோப்பு.உரை", "புதியகோப்பு.உரை")
    
    # இப்போது கோப்புகளை ஒரு "இறுக்கு" காப்பகத்தில் வைக்கவும் 
    வேர்_dir,tail = பாதை.split(மூலம்)
    #மேலோடுபயன்.make_archive("காப்பகம்", "zip", வேர்_dir) #காப்பகம் பழைய முறை 
    காப்பகம்("காப்பகம்", "zip", வேர்_dir) #காப்பகம் புதிய முறை 
    # இறுக்கு கோப்புகளின் மீது இன்னும் கூடுதலான கட்டுப்பாடு
    with இறுக்குகோப்பு("சோதனை.இறுக்கு","w") as புதியிறுக்கு:
      புதியிறுக்கு.write("புதியகோப்பு.உரை")
      புதியிறுக்கு.write("உரைகோப்பு.உரை.காப்பு")
            
if __name__ == "__main__":
  முதன்மை()
