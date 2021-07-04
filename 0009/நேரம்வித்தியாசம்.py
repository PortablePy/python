#
# நேரம்வித்தியாசம் பொருள்களுடன் வேலை செய்வதற்கான எடுத்துக்காட்டு கோப்பு
#


#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

from datetime import date
from datetime import time
from datetime import datetime
from datetime import timedelta

# ஒரு அடிப்படை நேர அட்டவணையை உருவாக்கி அதை அச்சிடுக
அச்சிடு (timedelta(days=365, hours=5, minutes=1)) #(நாட்கள் = 365, மணிநேரம் = 5, நிமிடங்கள் = 1))

# இன்றைய தேதியை அச்சிடுக
இப்போது = datetime.now ()
அச்சிடு ("இன்று:" + str (இப்போது))

# இப்போதிலிருந்து ஒரு வருடத்தி்ற்கு பிறகு இன்றைய தேதியை அச்சிடுக
அச்சிடு("இப்போதிலிருந்து ஒரு வருடத்தி்ற்கு பிறகு இதுவாக இருக்கும்:" + str (இப்போது + timedelta(days=365)))

# ஒன்றுக்கு மேற்பட்ட வாதங்களைப் பயன்படுத்தும் நேர அட்டவணையை உருவாக்கவும்
அச்சிடு ("இரண்டு வாரங்கள் மற்றும் 3 நாட்களில் இது இருக்கும்:" + str (இப்போது + timedelta(weeks=2, days=3)))

# 1 வாரத்திற்கு முன்பு ஒரு சரமாக வடிவமைக்கப்பட்ட தேதியைக் கணக்கிடுங்கள்
நே = datetime.now () - timedelta(weeks= 1)
சரம் = நே.strftime ("%A %B %d, %Y")
அச்சிடு ("ஒரு வாரத்திற்கு முன்பு அது " + சரம்)

### ஏப்ரல் முட்டாள்கள் தினம் வரை எத்தனை நாட்கள்?

இன்று = date.today () # இன்றைய தேதியைப் பெறுங்கள்
சித்திரை = date (இன்று.year, 4, 14) # அதே ஆண்டிற்கான ஏப்ரல் முட்டாள்களைப் பெறுங்கள்
# சித்திரை முட்டாள்கள் ஏற்கனவே இந்த ஆண்டாக சென்றிருக்கிறதா என்று பார்க்க தேதி ஒப்பீடு பயன்படுத்தவும்
# அது இருந்தால், அடுத்த ஆண்டுக்கான தேதியைப் பெற மாற்று () செயல்பாட்டைப் பயன்படுத்தவும்
if சித்திரை <இன்று:
  அச்சிடு ("சித்திரை முட்டாளின் நாள் ஏற்கனவே %d நாட்களுக்கு முன்பு சென்றது"% ((இன்று-சித்திரை). days))
  சித்திரை = சித்திரை.replace (year = இன்று.year + 1) # அப்படியானால், அடுத்த ஆண்டுக்கான தேதியைப் பெறுங்கள்

# இப்போது ஏப்ரல் முட்டாள் தினம் வரையிலான நேரத்தைக் கணக்கிடுங்கள்
சித்திரைக்குநேரம் = சித்திரை - இன்று
அச்சிடு ("இது தான்", சித்திரைக்குநேரம்.days, "அடுத்த சித்திரை முட்டாள்கள் தினம் வரை நாட்கள்!")


திகதி = இப்போது  + timedelta(days=2)
என்திகதி = இப்போது  - timedelta(weeks=3)

அச்சிடு(திகதி.date())
அச்சிடு(என்திகதி.date())

if திகதி > என்திகதி:
    அச்சிடு("ஒப்பீடு வேலை செய்கிறது ")

