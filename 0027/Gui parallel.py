from tkinter import *
from threading import Thread
from time import sleep
from random import randint

class GUI():

    def __init__(self):
        self.root = Tk()
        self.root.geometry("200x200")

        self.btn = Button(self.root,text="launch")
        self.btn.pack(expand=True)

        self.btn.config(command=self.action)

    def run(self):
        self.root.mainloop()

    def add(self,string,buffer):
        while  self.txt:
            msg = str(randint(1,100))+string+"\n"
            self.txt.insert(END,msg)
            sleep(0.5)

    def reset_lbl(self):
        self.txt = None
        self.second.destroy()

    def action(self):
        self.second = Toplevel()
        self.second.geometry("100x100")
        self.txt = Text(self.second)
        self.txt.pack(expand=True,fill="both")

        self.t = Thread(target=self.add,args=("new",None))
        self.t.setDaemon(True)
        self.t.start()

        self.second.protocol("WM_DELETE_WINDOW",self.reset_lbl)

a = GUI()
a.run()
