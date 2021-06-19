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
வேர்.geometry('640x480+200+200')

ttk.Label(வேர், text = 'Yellow', background = 'yellow').place(x = 100, y = 50, width = 100, height = 50)
ttk.Label(வேர், text = 'Blue', background = 'blue').place(relx = 0.5, rely = 0.5, anchor = 'center', relwidth = 0.5, relheight = 0.5)
ttk.Label(வேர், text = 'Green', background = 'green').place(relx = 0.5, x = 100, rely = 0.5, y = 50)
ttk.Label(வேர், text = 'Orange', background = 'orange').place(relx = 1.0, x = -5, y = 5, anchor = 'ne')

வேர்.mainloop()
