#! /usr/bin/env python
#
# Support module generated by PAGE version 4.4.3c
# In conjunction with Tcl version 8.6
#    Dec 14, 2014 09:38:48 PM


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
    global tch36
    tch36 = StringVar()

    global combobox
    combobox = StringVar()


def init(top, gui, arg=None):
    global w, top_level, root
    w = gui
    top_level = top
    root = top

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None


