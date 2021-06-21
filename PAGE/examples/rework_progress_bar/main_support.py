#! /usr/bin/env python
#
# Generated by PAGE version 4.2
# In conjunction with Tcl version 8.6
#    Jan. 20, 2014 07:06:22 PM


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

import time

def quit():
    sys.exit()

import progress_bar
import progress_bar_support # To allow reference to Tkinter variables
                             # defined in progress_bar_support.

def init(top, gui):
    global w, top_level, root
    w = gui
    top_level = top
    root = top

def destroy_window ():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

def advance():
    global bar, bar_value
    if not progress_bar_support.top_level:
        # If the progress bar has not been previously created,
        # create it; note the parameter 'root'.
        bar = progress_bar.create_Progress_Bar(root)
        # The above gives us access to functions and attributes of
        # the progress_bar object.
        bar_value = progress_bar_support.prog_var.get() / float(100)
        return
    if bar_value < 1.0:
        bar_value += 0.2
        progress_bar_support.update(bar_value)
        root.update() # This updates Tk for both this and the progress_bar.
    if bar_value >= 1.0:
        time.sleep(1)     # Wait one second and then kill the progress bar.
        progress_bar_support.close()
        bar_value = 0.0

