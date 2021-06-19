#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 5.1
#  in conjunction with Tcl version 8.6
#    Apr 21, 2020 06:40:28 AM PDT  platform: Linux

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

def change():
    print('tip_support.change')
    sys.stdout.flush()
    w.btn_dest_tooltip.update("New tooltip")
    # The following code works because the ToolTip class was defined
    # in the GUI module and the that code was placed there because I
    # had created tooltips in the GUI.
    import tip
    other_tip = tip.ToolTip(w.btn_quit,w.tooltip_font,"Exit Button", delay=0.5)

def quit():
    print('tip_support.quit')
    sys.stdout.flush()
    sys.exit()

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import tip
    tip.vp_start_gui()





