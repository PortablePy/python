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
    
root = Tk()

ttk.Label(root, text = 'Hello, Tkinter!',
          background = 'yellow').pack(side = LEFT, anchor = 'nw')
ttk.Label(root, text = 'Hello, Tkinter!',
          background = 'blue').pack(side = LEFT, padx = 10, pady = 10)
label = ttk.Label(root, text = 'Hello, Tkinter!',
          background = 'green')
label.pack(side = LEFT, ipadx = 10, ipady = 10)
print(label)

for widget in root.pack_slaves():
    widget.pack_configure(fill = BOTH, expand = True)
    print(widget.pack_info())

label.pack_forget()

root.mainloop()
