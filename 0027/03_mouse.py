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

def mouse_press(event):
    global prev
    print('type: {}'.format(event.type))
    print('widget: {}'.format(event.widget))
    print('num: {}'.format(event.num)) 
    print('x: {}'.format(event.x))
    print('y: {}'.format(event.y))
    print('x_வேர்: {}'.format(event.x_வேர்))
    print('y_வேர்: {}\n'.format(event.y_வேர்))
    prev = event

def draw(event):
    global prev
    canvas.create_line(prev.x, prev.y, event.x, event.y, width = 5)
    prev = event
    
வேர் = Tk()

canvas = Canvas(வேர், width = 640, height = 480, 
                background = 'white')
canvas.pack()
canvas.bind('<ButtonPress>', mouse_press)
canvas.bind('<B1-Motion>', draw)

வேர்.mainloop()
