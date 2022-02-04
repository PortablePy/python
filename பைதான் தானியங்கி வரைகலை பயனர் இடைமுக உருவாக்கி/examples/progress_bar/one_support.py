#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 6.1g
#  in conjunction with Tcl version 8.6
#    Mar 09, 2021 08:46:18 AM PST  platform: Linux
#    Mar 09, 2021 09:06:15 AM PST  platform: Linux

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

def set_Tk_var():
    global prog_var
    prog_var = tk.IntVar()

def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top

import time    
def advance():
    global prog_var
    bar_value = prog_var.get() / float(100)
    info = w.TProgressbar1.place_info()
    
    if info == {}:
        w.TProgressbar1.place(relx=0.333, rely=0.378, relwidth=0.333,
                              relheight=0.0, height=19)
        root.update() # This updates Tkinter
       
    if bar_value < 1.0:
        bar_value += 0.2
        print (sys._getframe().f_code.co_name, f': {bar_value = }')   # Rozen dpr
        prog_var.set(int(bar_value*100)) 
        root.update() # This updates Tkinter.
    if bar_value >= 1.0:
        time.sleep(1)        # Wait one second and then kill the progress bar.
        w.TProgressbar1.place_forget()
        info = w.TProgressbar1.place_info()
        prog_var.set(int(0.0))

def quit():
    sys.exit()

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

if __name__ == '__main__':
    import one
    one.vp_start_gui()





