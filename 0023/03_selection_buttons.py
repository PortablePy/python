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

checkbutton = ttk.Checkbutton(வேர், text = 'SPAM?')
checkbutton.pack()

spam = StringVar()
spam.set('SPAM!')
print(spam.get())

checkbutton.config(variable = spam, onvalue = 'SPAM Please!',
		   offvalue = 'Boo SPAM!')
print(spam.get())

breakfast = StringVar()
ttk.Radiobutton(வேர், text = 'SPAM', variable = breakfast,
		value = 'SPAM').pack()
ttk.Radiobutton(வேர், text = 'Eggs', variable = breakfast,
		value = 'Eggs').pack()
ttk.Radiobutton(வேர், text = 'Sausage', variable = breakfast,
		value = 'Sausage').pack()
ttk.Radiobutton(வேர், text = 'SPAM', variable = breakfast,
		value = 'SPAM').pack()
print(breakfast.get()) # Note: value will be empty if no selection is made

checkbutton.config(textvariable = breakfast)

வேர்.mainloop()
