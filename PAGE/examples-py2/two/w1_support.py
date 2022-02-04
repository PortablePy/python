#! /usr/bin/env python
#
# Support module generated by PAGE version 4.8.7a
# In conjunction with Tcl version 8.6
#    Jan 16, 2017 03:32:33 PM
#    Jan 16, 2017 03:41:56 PM


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

def start2():
    print('w1_support.start2')
    sys.stdout.flush()
    import w2
    w2.create_Window_II(root, 'Hello')


def quit():
    print('w1_support.quit')
    sys.stdout.flush()
    sys.exit()

def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import w1
    w1.vp_start_gui()





