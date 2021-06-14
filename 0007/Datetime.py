# Datetime Module Part I

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

from  datetime import datetime as நாள்நேரம்

now = நாள்நேரம்.now()

அச்சிடு(now.date())

அச்சிடு(now.year)

அச்சிடு(now.month)

அச்சிடு(now.hour)

அச்சிடு(now.minute)

அச்சிடு(now.second)

அச்சிடு(now.time())
