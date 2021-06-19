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

ttk.Label(வேர், text = 'Yellow', background = 'yellow').grid(row = 0, column = 2, rowspan = 2, sticky = 'nsew')
ttk.Label(வேர், text = 'Blue', background = 'Blue').grid(row = 1, column = 0, columnspan = 2, sticky = 'nsew')
ttk.Label(வேர், text = 'Green', background = 'Green').grid(row = 0, column = 0, sticky = 'nsew', padx = 10, pady = 10)
ttk.Label(வேர், text = 'Orange', background = 'Orange').grid(row = 0, column = 1, sticky = 'nsew', ipadx = 25, ipady = 25)

வேர்.rowconfigure(0, weight = 1)
வேர்.rowconfigure(1, weight = 3)
வேர்.columnconfigure(2, weight = 1)

வேர்.mainloop()
