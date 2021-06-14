#!/usr/bin/python3
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

from tkinter import *      
    
root = Tk()

window = Toplevel(root)
window.title('New Window')

window.lower()
window.lift(root)

window.state('zoomed')
window.state('withdrawn')
window.state('iconic')
window.state('normal')
print(window.state())
window.state('normal')

window.iconify()
window.deiconify()

window.geometry('640x480+50+100')
print(window.geometry())
window.resizable(False, False)
window.maxsize(640, 480)
window.minsize(200, 200)
window.resizable(True, True)

root.destroy()

root.mainloop()
