#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#    May 14, 2021 08:52:25 AM PDT  platform: Linux

import sys

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk

try:
    import ttk
    py3 = False
except ImportError:
    import tkinter.ttk as ttk
    py3 = True

import kword_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, வேர்
    வேர் = tk.Tk()
    top = Toplevel1 (வேர்)
    kword_support.init(வேர், top)
    வேர்.mainloop()

w = None
def create_Toplevel1(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_Toplevel1(வேர், *args, **kwargs)' .'''
    global w, w_win, வேர்
    #rt = வேர்
    வேர் = rt
    w = tk.Toplevel (வேர்)
    top = Toplevel1 (w)
    kword_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Toplevel1():
    global w
    w.destroy()
    w = None

class Toplevel1:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = 'wheat'  # X11 color: #f5deb3
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'
        font15 = "-family {Nimbus Sans L} -size 14"

        top.geometry("600x450+650+191")
        top.minsize(1, 1)
        top.maxsize(1905, 1170)
        top.resizable(1,  1)
        top.title("Keyword Parameters")
        top.configure(background="wheat")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")

        self.Button1 = tk.Button(top)
        self.Button1.place(relx=0.233, rely=0.378, height=37, width=105)
        self.Button1.configure(activebackground="#f4bcb2")
        self.Button1.configure(background="wheat")
        self.Button1.configure(disabledforeground="#b8a786")
        self.Button1.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Button1.configure(highlightbackground="wheat")
        self.Button1.configure(text='''Button1''')
        if (வேர்.tk.call('tk', 'windowingsystem')=='aqua'):
            self.Button1.bind('<Control-1>', lambda e: self.popup1(e,which=1))
            self.Button1.bind('<Button-2>', lambda e: self.popup1(e,which=1))
        else:
            self.Button1.bind('<Button-3>', lambda e: self.popup1(e,which=1))

        self.Button2 = tk.Button(top)
        self.Button2.place(relx=0.683, rely=0.378, height=37, width=105)
        self.Button2.configure(activebackground="#f4bcb2")
        self.Button2.configure(background="wheat")
        self.Button2.configure(disabledforeground="#b8a786")
        self.Button2.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Button2.configure(highlightbackground="wheat")
        self.Button2.configure(text='''Button2''')
        if (வேர்.tk.call('tk', 'windowingsystem')=='aqua'):
            self.Button2.bind('<Control-1>', lambda e: self.popup2(e))
            self.Button2.bind('<Button-2>', lambda e: self.popup2(e))
        else:
            self.Button2.bind('<Button-3>', lambda e: self.popup2(e))

        self.menubar = tk.Menu(top, font="-family {Nimbus Sans L} -size 14"
                ,bg=_bgcolor, fg=_fgcolor)
        top.configure(menu = self.menubar)

        self.menubar.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="wheat",
                command=kword_support.quit,
                font="-family {DejaVu Sans} -size 16",
                foreground="#000000",
                label="Quit")

    @staticmethod
    def popup1(event, *args, **kwargs):
        Popupmenu1 = tk.Menu(வேர், tearoff=0)
        Popupmenu1.configure(activebackground="#ffffcd")
        Popupmenu1.configure(background="#dda0dd")
        Popupmenu1.configure(disabledforeground="#b8a786")
        Popupmenu1.configure(font="-family {DejaVu Sans Mono} -size 14")
        Popupmenu1.add_command(
                command=kword_support.this,
                label="This")
        Popupmenu1.add_command(
                command=kword_support.that,
                label="That")
        Popupmenu1.add_separator(
)
        sub_menu = tk.Menu(Popupmenu1,
                activebackground="#ffffcd",
                activeforeground="black",
                background="wheat",
                disabledforeground="#b8a786",
                font="-family {DejaVu Sans Mono} -size 14",
                foreground="black",
                tearoff=0)
        Popupmenu1.add_cascade(menu=sub_menu,
                label="Also")
        sub_menu.add_command(
                command=kword_support.then,
                label="Then")
        sub_menu.add_command(
                command=kword_support.there,
                label="There")
        Popupmenu1.add_command(
                command=lambda:kword_support.which(kwargs['which']),
                label="Which")
        Popupmenu1.post(event.x_root, event.y_root)

    @staticmethod
    def popup2(event, *args, **kwargs):
        Popupmenu2 = tk.Menu(வேர், tearoff=0)
        Popupmenu2.configure(activebackground="#ffffcd")
        Popupmenu2.configure(background="wheat")
        Popupmenu2.configure(disabledforeground="#b8a786")
        Popupmenu2.configure(font="-family {DejaVu Sans Mono} -size 14")
        Popupmenu2.add_command(
                command=kword_support.how,
                label="How")
        Popupmenu2.add_command(
                command=kword_support.now,
                label="Now")
        Popupmenu2.add_separator(
                background="plum")
        sub_menu1 = tk.Menu(Popupmenu2,
                activebackground="#ffffcd",
                activeforeground="black",
                background="wheat",
                disabledforeground="#b8a786",
                font="-family {DejaVu Sans Mono} -size 14",
                foreground="black",
                tearoff=0)
        Popupmenu2.add_cascade(menu=sub_menu1,
                label="BrownCow")
        sub_menu1.add_command(
                command=kword_support.moo,
                label="Moo")
        Popupmenu2.post(event.x_root, event.y_root)

if __name__ == '__main__':
    vp_start_gui()





