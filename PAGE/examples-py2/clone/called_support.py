#! /usr/bin/env python
#
# Support module generated by PAGE version 4.6
# In conjunction with Tcl version 8.6
#    Feb 10, 2016 09:22:55 AM
#    Feb 10, 2016 09:22:55 AM
#    Feb 13, 2016 09:39:13 AM
#    Feb 13, 2016 10:37:07 AM
#    Feb 13, 2016 03:52:04 PM
#    Oct 03, 2018 10:01:48 AM PDT  platform: Linux

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

colors = ['white', 'gold', 'cyan', 'salmon', 'wheat', 'pale green',
          'dodger blue', 'pink', 'burlywood1',]
cc = -1

def set_Tk_var():
    # These are Tk variables used passed to Tkinter and must be
    # defined before the widgets using them are created.
    global created_by
    created_by = StringVar()
    created_by.set('Created by Rozen')

    global instance
    instance = StringVar()
    instance.set('Label')

def quit():
    print('called_support.quit')
    sys.stdout.flush()
    sys.exit()

def create_Called(root, *args, **kwargs):
    '''Starting point when module is imported by another program.'''
    global w, w_win, rt
    rt = root
    w = Toplevel (root)
    top = Called (w)
    called_support.init(w, top, *args, **kwargs)
    return (w, top)

def create_called(rt):
    import called
    cl = len(colors)
    global cc
    cc += 1
    if cc == cl - 1:
        cc = 0
    color = colors[cc]
    g = "+100+%s" % str(65 + (cc * 100))
    called.create_Called(rt, geom=g, color=color)

count = 0
def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top
    color = kwargs['color']
    geom = kwargs['geom']
    global count
    count += 1
    string = "Instance = %s" % str(count)
    instance.set(string)
    top_level.geometry(geom)
    top_level.configure(background = color)
    root.update()

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import called.tcl
    called.tcl.vp_start_gui()




