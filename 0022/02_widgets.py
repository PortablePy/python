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

button = ttk.Button(root, text = 'Click Me')
button.pack()

அச்சிடு(button['text'])
button['text'] = 'Press Me'
button.config(text = 'Push Me')
அச்சிடு(button.config())

அச்சிடு(str(button))
அச்சிடு(str(root))

ttk.Label(root, text ='Hello, Tkinter!').pack()

# mainloop() add
root.mainloop()
