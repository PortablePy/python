# HTTP Package
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)

# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# https://www.googleapis.com/books/v1/volumes?q=isbn:1101904224

import urllib.request
import json as சாகைபொகு
import textwrap as உரைமடக்கு

with urllib.request.urlopen("https://www.googleapis.com/books/v1/volumes?q=isbn:1101904224") as கோப்பு:
    உரை = கோப்பு.read()
    குறியீட்டு_நீக்கப்பட்ட_உரை = உரை.decode('utf-8')
    அச்சிடு(உரைமடக்கு.fill(குறியீட்டு_நீக்கப்பட்ட_உரை, width=50))

அச்சிடு()

பொருள் = சாகைபொகு.loads(குறியீட்டு_நீக்கப்பட்ட_உரை)
அச்சிடு(பொருள்['kind'])

அச்சிடு(பொருள்['items'][0]['searchInfo']['textSnippet'])
