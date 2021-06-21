#! /usr/bin/env python
#
# Support module generated by PAGE version 4.6
# In conjunction with Tcl version 8.6
#    Feb 11, 2016 06:26:56 PM
#    Sep 17, 2016 12:03:01 PM


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





def quit():
    print('popup_support.quit')
    sys.stdout.flush()
    sys.exit()


def how():
    print('popup_support.how')
    sys.stdout.flush()

def moo():
    print('popup_support.moo')
    sys.stdout.flush()

def now():
    print('popup_support.now')
    sys.stdout.flush()

def that():
    print('popup_support.that')
    sys.stdout.flush()

def then():
    print('popup_support.then')
    sys.stdout.flush()

def there():
    print('popup_support.there')
    sys.stdout.flush()

def this():
    print('popup_support.this')
    sys.stdout.flush()

def init(top, gui, *args, **kwargs):
    global w, top_level, வேர்
    w = gui
    top_level = top
    வேர் = top

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import popup
    popup.vp_start_gui()





