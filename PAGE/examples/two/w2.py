#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 5.5f
#  in conjunction with Tcl version 8.6
#    Oct 06, 2020 07:35:55 PM PDT  platform: Linux

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

import w2_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = tk.Tk()
    w2_support.set_Tk_var()
    top = Window_II (root)
    w2_support.init(root, top)
    root.mainloop()

w = None
def create_Window_II(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_Window_II(root, *args, **kwargs)' .'''
    global w, w_win, root
    #rt = root
    root = rt
    w = tk.Toplevel (root)
    w2_support.set_Tk_var()
    top = Window_II (w)
    w2_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Window_II():
    global w
    w.destroy()
    w = None

class Window_II:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#f5deb3'  # X11 color: 'wheat'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'
        self.style = ttk.Style()
        if sys.platform == "win32":
            self.style.theme_use('winnative')
        self.style.configure('.',background=_bgcolor)
        self.style.configure('.',foreground=_fgcolor)
        self.style.map('.',background=
            [('selected', _compcolor), ('active',_ana2color)])

        top.geometry("524x350+323+321")
        top.minsize(1, 1)
        top.maxsize(1905, 1050)
        top.resizable(0,  0)
        top.title("Window II")
        top.configure(background="#f5deb3")
        top.configure(highlightbackground="#f5deb3")
        top.configure(highlightcolor="black")

        self.Button1 = tk.Button(top)
        self.Button1.place(x=60, y=150, height=37, width=83)
        self.Button1.configure(activebackground="#f4bcb2")
        self.Button1.configure(background="#f5deb3")
        self.Button1.configure(command=w2_support.close)
        self.Button1.configure(cursor="fleur")
        self.Button1.configure(disabledforeground="#b8a786")
        self.Button1.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Button1.configure(highlightbackground="#f5deb3")
        self.Button1.configure(text='''Close''')

        self.Label1 = tk.Label(top)
        self.Label1.place(x=160, y=80, height=27, width=212)
        self.Label1.configure(activebackground="#ffffcd")
        self.Label1.configure(background="#f5deb3")
        self.Label1.configure(disabledforeground="#b8a786")
        self.Label1.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Label1.configure(highlightbackground="#f5deb3")
        self.Label1.configure(text='''Greetings''')
        self.Label1.configure(textvariable=w2_support.greeting)

        self.TProgressbar1 = ttk.Progressbar(top)
        self.TProgressbar1.place(x=220, y=260, width=100, height=19)
        self.TProgressbar1.configure(variable=w2_support.t)

        self.Button2 = tk.Button(top)
        self.Button2.place(x=203, y=150, height=37, width=105)
        self.Button2.configure(activebackground="#f4bcb2")
        self.Button2.configure(background="#f5deb3")
        self.Button2.configure(command=w2_support.hide)
        self.Button2.configure(cursor="fleur")
        self.Button2.configure(disabledforeground="#b8a786")
        self.Button2.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Button2.configure(highlightbackground="#f5deb3")
        self.Button2.configure(text='''Hide W1''')

        self.Button3 = tk.Button(top)
        self.Button3.place(x=368, y=150, height=37, width=94)
        self.Button3.configure(activebackground="#f4bcb2")
        self.Button3.configure(background="#f5deb3")
        self.Button3.configure(command=w2_support.show)
        self.Button3.configure(cursor="fleur")
        self.Button3.configure(disabledforeground="#b8a786")
        self.Button3.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Button3.configure(highlightbackground="#f5deb3")
        self.Button3.configure(text='''Show W1''')

if __name__ == '__main__':
    vp_start_gui()





