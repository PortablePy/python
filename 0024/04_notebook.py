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

notebook = ttk.Notebook(root)
notebook.pack()

frame1 = ttk.Frame(notebook)
frame2 = ttk.Frame(notebook)
notebook.add(frame1, text = 'One')
notebook.add(frame2, text = 'Two')
ttk.Button(frame1, text = 'Click Me').pack()

frame3 = ttk.Frame(notebook)
notebook.insert(1, frame3, text = 'Three')
notebook.forget(1)
notebook.add(frame3, text = 'Three')

print(notebook.select())
print(notebook.index(notebook.select()))
notebook.select(2)

notebook.tab(1, state = 'disabled')
notebook.tab(1, state = 'hidden')
notebook.tab(1, state = 'normal')
notebook.tab(1, 'text')
notebook.tab(1)

root.mainloop()
