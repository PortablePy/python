#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 6.1g
#  in conjunction with Tcl version 8.6
#    Mar 07, 2021 04:56:37 PM PST  platform: Linux
#    Mar 07, 2021 05:51:46 PM PST  platform: Linux

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

import globals

def set_Tk_var():
    global prog_var
    prog_var = tk.IntVar()

def init(top, gui, *args, **kwargs):
    global w, top_level, வேர்
    w = gui
    top_level = top
    வேர் = top
    globals.prog_var = prog_var
    globals.destroy_window = destroy_window

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()

    print("spot destroy")
    top_level = None

if __name__ == '__main__':
    import progress_bar
    progress_bar.vp_start_gui()





