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

progressbar = ttk.Progressbar(root, orient = HORIZONTAL, length = 200)
progressbar.pack()

progressbar.config(mode = 'indeterminate')
progressbar.start()
progressbar.stop()

progressbar.config(mode = 'determinate', maximum = 11.0, value = 4.2)
progressbar.config(value = 8.0)
progressbar.step()
progressbar.step(5)

value = DoubleVar()
progressbar.config(variable = value)

scale = ttk.Scale(root, orient = HORIZONTAL,
		  length = 400, variable = value,
		  from_ = 0.0, to = 11.0)
scale.pack()
scale.set(4.2)
print(scale.get())

root.mainloop()
