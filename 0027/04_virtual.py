#!/usr/bin/python3
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

from tkinter import *
from tkinter import ttk        
    
வேர் = Tk()

entry = ttk.Entry(வேர்)
entry.pack()

entry.bind('<<Copy>>', lambda e: print('Copy'))
entry.bind('<<Paste>>', lambda e: print('Paste'))

entry.event_add('<<OddNumber>>', '1', '3', '5', '7', '9')
entry.bind('<<OddNumber>>', lambda e: print('Odd Number!'))

print(entry.event_info('<<OddNumber>>'))

entry.event_generate('<<OddNumber>>')
entry.event_generate('<<Paste>>')

entry.event_delete('<<OddNumber>>')

வேர்.mainloop()
