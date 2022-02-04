#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 5.5f
#  in conjunction with Tcl version 8.6
#    Oct 06, 2020 07:12:01 PM PDT  platform: Linux

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

import middle_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = tk.Tk()
    top = middle (root)
    middle_support.init(root, top)
    root.mainloop()

w = None
def create_middle(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_middle(root, *args, **kwargs)' .'''
    global w, w_win, root
    #rt = root
    root = rt
    w = tk.Toplevel (root)
    top = middle (w)
    middle_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_middle():
    global w
    w.destroy()
    w = None

class middle:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = 'wheat'  # X11 color: #f5deb3
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'

        top.geometry("600x450")
        top.minsize(1, 1)
        top.maxsize(1905, 1050)
        top.resizable(1,  1)
        top.title("Man in the Middle")
        top.configure(background="orange")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")

        self.Message1 = tk.Message(top)
        self.Message1.place(relx=0.267, rely=0.156, relheight=0.371
                , relwidth=0.557)
        self.Message1.configure(background="orange")
        self.Message1.configure(font="-family {DejaVu Sans} -size 12")
        self.Message1.configure(highlightbackground="wheat")
        self.Message1.configure(text='''This is a man-in-the-middle 
          GUI
It is envoked and intern invokes
another GUI which has a popup and thus 
needs "root"''')
        self.Message1.configure(width=334)

        self.Button1 = tk.Button(top)
        self.Button1.place(relx=0.167, rely=0.689, height=33, width=81)
        self.Button1.configure(activebackground="#f4bcb2")
        self.Button1.configure(background="wheat")
        self.Button1.configure(command=middle_support.invoke)
        self.Button1.configure(disabledforeground="#b8a786")
        self.Button1.configure(font="-family {DejaVu Sans} -size 12")
        self.Button1.configure(highlightbackground="wheat")
        self.Button1.configure(text='''Invoke''')

        self.Button2 = tk.Button(top)
        self.Button2.place(relx=0.6, rely=0.689, height=33, width=61)
        self.Button2.configure(activebackground="#f4bcb2")
        self.Button2.configure(background="wheat")
        self.Button2.configure(command=middle_support.quit)
        self.Button2.configure(disabledforeground="#b8a786")
        self.Button2.configure(font="-family {DejaVu Sans} -size 12")
        self.Button2.configure(highlightbackground="wheat")
        self.Button2.configure(text='''Quit''')

if __name__ == '__main__':
    vp_start_gui()





