#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#    May 14, 2021 12:04:44 PM PDT  platform: Linux

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

import Autocomplete_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = tk.Tk()
    Autocomplete_support.set_Tk_var()
    top = Toplevel1 (root)
    Autocomplete_support.init(root, top)
    root.mainloop()

w = None
def create_Toplevel1(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_Toplevel1(root, *args, **kwargs)' .'''
    global w, w_win, root
    #rt = root
    root = rt
    w = tk.Toplevel (root)
    Autocomplete_support.set_Tk_var()
    top = Toplevel1 (w)
    Autocomplete_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Toplevel1():
    global w
    w.destroy()
    w = None

class Toplevel1:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#fffaf0'  # X11 color: '{floral white}'
        _fgcolor = '#2208cc'  # Closest X11 color: '{medium blue}'
        _compcolor = '#d9d9d9' # X11 color: 'gray85'
        _ana1color = '#d9d9d9' # X11 color: 'gray85'
        _ana2color = '#ececec' # Closest X11 color: 'gray92'

        top.geometry("354x142+650+150")
        top.minsize(120, 1)
        top.maxsize(3844, 1061)
        top.resizable(0,  0)
        top.title("Autocomplete")
        top.configure(background="#fffaf0")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")

        self.txtValue = tk.Entry(top)
        self.txtValue.place(x=70, y=97, height=26, width=264)
        self.txtValue.configure(background="white")
        self.txtValue.configure(disabledforeground="#b6b6b6")
        self.txtValue.configure(font="-family {DejaVu Sans Mono} -size 10")
        self.txtValue.configure(foreground="#2208cc")
        self.txtValue.configure(highlightbackground="wheat")
        self.txtValue.configure(selectbackground="blue")
        self.txtValue.configure(selectforeground="white")
        self.txtValue.configure(textvariable=Autocomplete_support.vtxtValue)

        self.btngGetValue = tk.Button(top)
        self.btngGetValue.place(x=152, y=66, height=24, width=80)
        self.btngGetValue.configure(activebackground="#ffffcd")
        self.btngGetValue.configure(activeforeground="#2208cc")
        self.btngGetValue.configure(background="#fffaf0")
        self.btngGetValue.configure(command=Autocomplete_support.btnGetValue_Click)
        self.btngGetValue.configure(disabledforeground="#b6b6b6")
        self.btngGetValue.configure(foreground="#2208cc")
        self.btngGetValue.configure(highlightbackground="#fffaf0")
        self.btngGetValue.configure(pady="0")
        self.btngGetValue.configure(text='''Get Value''')

        self.Frame1 = tk.Frame(top)
        self.Frame1.place(x=71, y=29, height=25, width=260)
        self.Frame1.configure(relief='groove')
        self.Frame1.configure(borderwidth="2")
        self.Frame1.configure(relief="groove")
        self.Frame1.configure(background="#fffaf0")
        self.Frame1.configure(highlightbackground="wheat")

        self.cmbTest = Autocomplete_support.Custom(self.Frame1)
        self.cmbTest.place(x=0, y=0, height=25, width=260)

        self.Label1 = tk.Label(top)
        self.Label1.place(x=14, y=30, height=21, width=50)
        self.Label1.configure(activebackground="#f9f9f9")
        self.Label1.configure(background="#fffaf0")
        self.Label1.configure(disabledforeground="#b6b6b6")
        self.Label1.configure(foreground="#2208cc")
        self.Label1.configure(highlightbackground="wheat")
        self.Label1.configure(text='''Payee :''')

        self.Label2 = tk.Label(top)
        self.Label2.place(x=5, y=100, height=21, width=65)
        self.Label2.configure(activebackground="#f9f9f9")
        self.Label2.configure(background="#fffaf0")
        self.Label2.configure(disabledforeground="#b6b6b6")
        self.Label2.configure(foreground="#2208cc")
        self.Label2.configure(highlightbackground="wheat")
        self.Label2.configure(text='''Selected :''')

if __name__ == '__main__':
    vp_start_gui()





