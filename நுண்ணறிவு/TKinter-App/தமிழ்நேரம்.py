import sys
import os
import tkinter as tk
import tkinter.ttk as ttk
import tkinter.simpledialog as sd
import tkinter.messagebox as tkmb
import tkinter.colorchooser as cc
tk_app = tk.Tk()
தலைப்பு = __name__
if தலைப்பு == "__main__":
    தலைப்பு = 'தமிழ் நேரம்'
    தலைப்பு = sys.argv[0]
tk_app.title(தலைப்பு)
பாதை = os.path.join(os.getcwd(),'சின்னம்.icns')
tk_app.iconbitmap(பாதை)

ew1 = ttk.Entry(tk_app, width= 45)
ew1.insert(0, "<பெயர்>")
lw1 = ttk.Label(tk_app, text = "தமிழ் வாழ்க!!")
lw2 = ttk.Label(tk_app, text = "யாதும் ஊரே! யாவருங்கேளிர்!!")
# lw1.pack(expand=tk.YES, fill=tk.BOTH)

def myclick():
    மதிப்பு = sd.askfloat(தலைப்பு, 'எண்')
    k = sd.askinteger(தலைப்பு, 'full number')
    தகவல் = "வணக்கம் " + ew1.get() + str(type (மதிப்பு))+ str(மதிப்பு) + str(type(k)) + str(k)
    lw = ttk.Label(tk_app, text = தகவல்)
    lw.pack()

def dialogs1():
    # k = tkmb.Message(tk_app, Message = "hai")
    # k = tkmb.showinfo(தலைப்பு, 'வணக்கம்')
    k = cc.askcolor()
    print (k)

bw1 = ttk.Button(tk_app, text = "அழுத்து", command = myclick)
bw2 = ttk.Button(tk_app, text = "தகவல்பெட்டி", command = dialogs1)

# lw1.grid(row=0, column=0)
# lw2.grid(row=1, column=1)
# bw1.grid(row=2, column =0)
lw1.pack()
lw2.pack()
ew1.pack()
bw1.pack()
bw2.pack()
tk_app.mainloop()