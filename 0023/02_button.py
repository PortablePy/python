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

button = ttk.Button(வேர், text = "Click Me")
button.pack()

def callback():
    print('Clicked!')

button.config(command = callback)
button.invoke()

button.state(['disabled'])
print(button.instate(['disabled']))
button.state(['!disabled'])
print(button.instate(['!disabled']))

logo = PhotoImage(file = 'python_logo.gif') # change path to image as necessary
button.config(image = logo, compound = LEFT)
small_logo = logo.subsample(5, 5)
button.config(image = small_logo)

வேர்.mainloop()
