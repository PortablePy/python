#! /usr/bin/env python
#  -*- coding: utf-8 -*-
# ======================================================
#     child_support.py
#  ------------------------------------------------------
# Created for Full Circle Magazine #155
# Written by G.D. Walters
# Copyright (c) 2020 by G.D. Walters
# This source code is released under the MIT License
# ======================================================
# Support module generated by PAGE version 5.0.2c
#  in conjunction with Tcl version 8.6
#    Feb 20, 2020 11:49:46 AM CST  platform: Linux
#    Feb 20, 2020 03:46:35 PM CST  platform: Linux
#    Feb 21, 2020 04:08:27 AM CST  platform: Linux

import sys
import shared

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
    global DisplayLabel
    DisplayLabel = tk.StringVar()
    DisplayLabel.set('Label')


def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top
    # ======================================================
    # My init code starts...
    # ======================================================
    global valu
    valu = ''
    setup_bindings()
    shared.child_active = True


def setup_bindings():
    w.btn0.bind('<Button-1>', lambda e: on_btnClick(e, 0))
    w.btn1.bind('<Button-1>', lambda e: on_btnClick(e, 1))
    w.btn2.bind('<Button-1>', lambda e: on_btnClick(e, 2))
    w.btn3.bind('<Button-1>', lambda e: on_btnClick(e, 3))
    w.btn4.bind('<Button-1>', lambda e: on_btnClick(e, 4))
    w.btn5.bind('<Button-1>', lambda e: on_btnClick(e, 5))
    w.btn6.bind('<Button-1>', lambda e: on_btnClick(e, 6))
    w.btn7.bind('<Button-1>', lambda e: on_btnClick(e, 7))
    w.btn8.bind('<Button-1>', lambda e: on_btnClick(e, 8))
    w.btn9.bind('<Button-1>', lambda e: on_btnClick(e, 9))
    w.btnDot.bind('<Button-1>', lambda e: on_btnClick(e, 10))


def on_btnClick(e, which):
    # print(which)
    global valu
    if which < 10:
        valu = valu + str(which)
    elif which == 10:
        valu = valu + "."
    shared.ChildData = valu
    DisplayLabel.set(valu)
    shared.ReadyToRead = True


def on_btnEnter():
    print('child_support.on_btnEnter')
    sys.stdout.flush()


def on_btnExit():
    print('child_support.on_btnExit')
    sys.stdout.flush()
    shared.child_active = False
    destroy_window()


def on_btnClear():
    # print('child_support.on_btnClear')
    # sys.stdout.flush()
    global valu
    valu = ''
    shared.ChildData = valu
    DisplayLabel.set(valu)
    shared.ReadyToRead = True


def on_btnBackspace():
    # print('child_support.on_btnBackspace')
    # sys.stdout.flush()
    global valu
    valu = valu[:len(valu)-1]
    shared.ChildData = valu
    DisplayLabel.set(valu)
    shared.ReadyToRead = True


def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None


if __name__ == '__main__':
    import child
    child.vp_start_gui()
