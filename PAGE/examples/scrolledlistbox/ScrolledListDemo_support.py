#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 6.0.1
#  in conjunction with Tcl version 8.6
#    Feb 23, 2021 03:14:14 PM CST  platform: Linux
#    Feb 23, 2021 03:33:05 PM CST  platform: Linux

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
    global SelectedItem
    SelectedItem = tk.StringVar()
    SelectedItem.set("Label")


def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top
    # My Init code..
    SelectedItem.set("")
    global demolist
    demolist = [
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six",
        "Seven",
        "Eight",
        "Nine",
        "Ten",
    ]
    for itm in demolist:
        w.Scrolledlistbox1.insert("end", itm)
    w.Scrolledlistbox1.bind("<<ListboxSelect>>", on_listboxSelect)


def on_listboxSelect(e):
    indx = w.Scrolledlistbox1.curselection()
    itm = w.Scrolledlistbox1.get(indx[0])
    SelectedItem.set(f"Selected Item: {indx[0]} - {itm}")


def on_btnDeleteListItems():
    print("ScrolledListDemo_support.on_btnDeleteListItems")
    sys.stdout.flush()
    w.Scrolledlistbox1.delete(0, tk.END)
    SelectedItem.set("")


def on_btnExit():
    print("ScrolledListDemo_support.on_btnExit")
    sys.stdout.flush()
    destroy_window()


def on_btnFillList():
    print("ScrolledListDemo_support.on_btnFillList")
    sys.stdout.flush()
    global demolist
    for itm in demolist:
        w.Scrolledlistbox1.insert("end", itm)


def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None


if __name__ == "__main__":
    import ScrolledListDemo

    ScrolledListDemo.vp_start_gui()