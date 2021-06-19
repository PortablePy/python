#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 4.17.4
# In conjunction with Tcl version 8.6
#    Sep 16, 2018 09:50:37 PM PDT  platform: Linux

import sys

try:
    from Tkinter import *
except ImportError:
    from tkinter import *

try:
    import ttk
    py3 = False
except ImportError:
    import tkinter.ttk as ttk
    py3 = True

import main_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = Tk()
    top = Main (root)
    main_support.init(root, top)
    root.mainloop()

w = None
def create_Main(root, *args, **kwargs):
    '''Starting point when module is imported by another program.'''
    global w, w_win, rt
    rt = root
    w = Toplevel (root)
    top = Main (w)
    main_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Main():
    global w
    w.destroy()
    w = None


class Main:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = 'wheat'  # X11 color: #f5deb3
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}' 
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2' 
        font10 = "-family {DejaVu Sans} -size 14 -weight normal -slant"  \
            " roman -underline 0 -overstrike 0"
        font11 = "-family {DejaVu Sans} -size 12 -weight normal -slant"  \
            " roman -underline 0 -overstrike 0"

        top.geometry("600x450+918+173")
        top.title("Main")
        top.configure(background="wheat")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")



        self.Button1 = Button(top)
        self.Button1.place(relx=0.333, rely=0.4, height=31, width=203)
        self.Button1.configure(activebackground="#f9f9f9")
        self.Button1.configure(background="wheat")
        self.Button1.configure(command=main_support.advance)
        self.Button1.configure(disabledforeground="#b8a786")
        self.Button1.configure(font=font11)
        self.Button1.configure(highlightbackground="wheat")
        self.Button1.configure(text='''Advance Progress Bar''')

        self.Button2 = Button(top)
        self.Button2.place(relx=0.45, rely=0.667, height=31, width=59)
        self.Button2.configure(activebackground="#f9f9f9")
        self.Button2.configure(background="wheat")
        self.Button2.configure(command=main_support.quit)
        self.Button2.configure(disabledforeground="#b8a786")
        self.Button2.configure(font=font11)
        self.Button2.configure(highlightbackground="wheat")
        self.Button2.configure(text='''Quit''')

        self.Label1 = Label(top)
        self.Label1.place(relx=0.233, rely=0.178, height=49, width=352)
        self.Label1.configure(activebackground="#f9f9f9")
        self.Label1.configure(background="wheat")
        self.Label1.configure(disabledforeground="#b8a786")
        self.Label1.configure(font=font10)
        self.Label1.configure(highlightbackground="wheat")
        self.Label1.configure(text='''Example of Using a Progress bar''')






if __name__ == '__main__':
    vp_start_gui()



