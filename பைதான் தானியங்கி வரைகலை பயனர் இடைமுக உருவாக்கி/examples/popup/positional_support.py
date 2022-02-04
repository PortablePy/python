#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 5.5f
#  in conjunction with Tcl version 8.6
#    Oct 06, 2020 01:10:21 PM PDT  platform: Linux

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

def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top

def how():
    print('positional_support.how')
    sys.stdout.flush()

def milk():
    print('positional_support.milk')
    sys.stdout.flush()

def moo():
    print('positional_support.moo')
    sys.stdout.flush()

def now():
    print('positional_support.now')
    sys.stdout.flush()

def quit():
    print('positional_support.quit')
    sys.stdout.flush()
    sys.exit()

def then():
    print('positional_support.then')
    sys.stdout.flush()

def there():
    print('positional_support.there')
    sys.stdout.flush()

def this():
    print('positional_support.this')
    sys.stdout.flush()

def which(p1):
    print('positional_support.which')
    print('p1={0}'.format(p1))
    sys.stdout.flush()

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import positional
    positional.vp_start_gui()




