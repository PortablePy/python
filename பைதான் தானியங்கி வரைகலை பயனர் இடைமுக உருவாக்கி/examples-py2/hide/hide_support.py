#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 4.15a
# In conjunction with Tcl version 8.6
#    Jun 17, 2018 04:42:14 PM


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

def hide():
    print('hide_support.hide')
    sys.stdout.flush()
    w.Button1.place_forget()

def unhide():
    print('hide_support.unhide')
    sys.stdout.flush()
    w.Button1.place(rely=p_info['rely'],
                    relx=p_info['relx'],
                    )


def init(top, gui, *args, **kwargs):
    global w, top_level, வேர்
    w = gui
    top_level = top
    வேர் = top
    global p_info
    p_info = w.Button1.place_info()
    print p_info

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import hide
    hide.vp_start_gui()


