#! /usr/bin/env python
#
# Generated by PAGE version 4.2
# In conjunction with Tcl version 8.6
#    Jan. 19, 2014 09:47:43 AM


import sys

try:
    from Tkinter import *
except ImportError:
    from tkinter import *
try:
    import ttk
    py3 = 0
except ImportError:
    import tkinter.ttk as ttk
    py3 = 1

def set_Tk_var():
    # These are Tk variables used passed to Tkinter and must be
    # defined before the widgets using them are created.
    global prog_var
    prog_var = IntVar()

top_level = None
def init(top, gui, arg=None):
    global w, top_level
    w = gui
    top_level = top
    update(0.4)

def destroy_window ():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

def update (v):
    print 'Progress_Bar: update: v =', v    # rozen pyp
    prog_var.set(int(v*100))

def close():
    #destroy_Progress_Bar()
    destroy_window()


