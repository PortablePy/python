import random
import tkinter as tk
from tkinter import ttk


class Root(tk.Tk):
    def __init__(self, T="RootWindow", W=600, H=400, Timer=1000):
        super().__init__()
        self.title(T)
        self.width = W
        self.height = H
        # get the screen dimension
        screen_width = self.winfo_screenwidth()
        screen_height = self.winfo_screenheight()
        # find the center point
        center_x = int(screen_width/2 - self.width / 2)
        center_y = int(screen_height/2 - self.height / 2)
        # set the position of the window to the center of the screen
        self.geometry(f'{self.width}x{self.height}+{center_x}+{center_y}')
        # Self-closing and killing the root-loop
        self.protocol("WM_DELETE_WINDOW", self.quit)
        if Timer != -1:
            self.timer = self.after(Timer, self.timeout)

    def createtimerhandler(self, Timer, timeout):
        pass

    def timeout(self):
        print("every one second event by mainloop" )
        self.timer = self.after(Timer, self.timeout)


class Top(tk.Toplevel):
    def __init__(self, T="TopWindow", W=600, H=400, Timer=-1):
        super().__init__()
        self.title(T)
        self.width = W
        self.height = H
        # get the screen dimension
        screen_width = self.winfo_screenwidth()
        screen_height = self.winfo_screenheight()
        # find the center point
        center_x = int(screen_width/2 - self.width / 2)
        center_y = int(screen_height/2 - self.height / 2)
        # set the position of the window to the center of the screen
        self.geometry(f'{self.width}x{self.height}+{center_x}+{center_y}')
        # Self-closing and destory the root-loop
        self.protocol("WM_DELETE_WINDOW", self._close)
        if Timer != -1:
            self.timer = self.after(Timer, self.timeout)

    def timeout(self):
        print(random.random())

    def createtimeouthandler(self):
        pass

    def _close(self):
        self.destroy()
        self.update()

def select(option):
    print(option)


def add():
    tk.Toplevel(root, bg='grey')


# root = tk.Tk()
root = Root()
# root.withdraw()

# root.deiconify()
btn = ttk.Button(root, text="Exit Application", command=root.quit)
btn.pack()


top = tk.Toplevel(root,)
top.protocol("WM_DELETE_WINDOW", top.destroy)

top2 = tk.Toplevel(root,)
top2.protocol("WM_DELETE_WINDOW", top2.destroy)

top3 = tk.Toplevel(root,)
top3.protocol("WM_DELETE_WINDOW", top3.destroy)
# place a label on the top window
message = tk.Label(top, text="Hello, World!")
message.pack()

ttk.Button(top, text="rock", command=lambda: select('Rock')).pack()
ttk.Button(top, text="Add", command=lambda: add()).pack()


root.mainloop()
