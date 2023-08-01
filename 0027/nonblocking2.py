from tkinter import *
import time

ws = Tk()
ws.title('PythonGuides')
ws.geometry('400x300')
ws.config(bg='#5f734c')

time_lbl = Label(
    ws,
    text=time.strftime( "%d/%m/%Y %A %H:%M:%S"),
    font=(21),
    padx=10,
    pady=5,
    bg='#d9d8d7'
    )

time_lbl.pack(expand=True)
ws.update()

while True:
    time.sleep(1)
    time_text=time.strftime("%d/%m/%Y %A %H:%M:%S")
    time_lbl.config(text=time_text)
    ws.update()
    print ("last line printing")
