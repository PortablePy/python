# ======================================================
#     ScrolledCheckedListBox.py
#  ------------------------------------------------------
# Created for the Learning Page Book Project
# Written by G.D. Walters
# Copyright (c) 2018 by G.D. Walters
# This source code is released under the MIT License
# (See MIT_License.txt)
# Version 1.1
# ------------------------------------------------------
# Version 1.1 adds mousewheel support
# ======================================================
# Original Code from https://stackoverflow.com/questions/31028874/
#                 why-does-place-not-work-for-widgets-in-a-frame-in-a-canvas
# Some code from Don's PAGE examples of custom widget
# MANY thanks to Don Rozenberg for help getting this tweaked to be able
# to load without modifying the main GUI.py file.
# =====================================================================
# To use this widget with Page:
# In your layout create a frame the size and position as a place holder
# Then place a Custom widget into the frame. Initialize the widget within
# the _support.py file.
# BE SURE TO COPY THIS FILE INTO THE FOLDER WHERE YOU ARE SAVING
# THE PROJECT!
# ========================================================================

from time import sleep
import platform

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk


class ScrolledCheckedListBox(tk.Frame):

    def __init__(self,
                 root,
                 *args,
                 **kwargs):

        # Start up self
        tk.Frame.__init__(self, root, *args, **kwargs)
        # Put a canvas in the frame (self)
        self.canvas = tk.Canvas(self)
        # Put scrollbars in the frame (self)
        self.horizontal_scrollbar = tk.Scrollbar(
            self, orient="horizontal", command=self.canvas.xview
            )
        self.vertical_scrollbar = tk.Scrollbar(
            self, orient="vertical", command=self.canvas.yview
            )
        self.canvas.configure(
            yscrollcommand=self.vertical_scrollbar.set,
            xscrollcommand=self.horizontal_scrollbar.set
            )
        # Put a frame in the canvas, to hold all the widgets
        self.inner_frame = tk.Frame(
            self.canvas)
        # Pack the scroll bars and the canvas (in self)
        self.horizontal_scrollbar.pack(side="bottom", fill="x")
        self.vertical_scrollbar.pack(side="right", fill="y")
        self.canvas.pack(side="left", fill="both", expand=True)
        self.canvas.create_window((0, 0), window=self.inner_frame, anchor="nw")
        self.inner_frame.bind("<Configure>", self.on_frame_configure)
        # GDW Added 6/30/18 mousewheel support
        # from various web sources
        self.canvas.bind('<Enter>', self._bound_to_mousewheel)
        self.canvas.bind('<Leave>', self._unbound_to_mousewheel)
        # self.canvas.bind_all("<MouseWheel>", self._on_mousewheel)  # Win/MacOS
        # self.canvas.bind_all("<Button-4>", self._on_mousewheel)  # Linux
        # self.canvas.bind_all("<Button-5>", self._on_mousewheel)  # Linux

    def on_frame_configure(self, event):
        """Reset the scroll region to encompass the inner frame"""
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))

    def _bound_to_mousewheel(self, event):
        if platform.system() == 'Windows':
            self.canvas.bind_all("<MouseWheel>", self._on_mousewheel)
        else:
            self.canvas.bind_all("<Button-4>", self._on_mousewheel)
            self.canvas.bind_all("<Button-5>", self._on_mousewheel)

    def _unbound_to_mousewheel(self, event):
        if platform.system() == 'Windows':
            self.canvas.unbind_all("<MouseWheel>")
        else:
            self.canvas.unbind_all("<Button-4>")
            self.canvas.unbind_all("<Button-5>")

    def _on_mousewheel(self, event):
        if platform.system() == 'Windows':
            self.canvas.yview_scroll(-1*int(event.delta/120),"units")
        else:
            # This works on Linux, but not on Windows or MacOS
            if event.num == 4:
                self.canvas.yview_scroll(-1, "units")
            elif event.num == 5:
                self.canvas.yview_scroll(1, "units")


# ======================================================
# function get()
# returns a list of text of all checked items
# ======================================================
    def get(self):
        global keys, single

        checked = []
        temp = []
        for i in range(items):
            if vars[i].get() == '1':
                if single == True:
                    checked.append(cb[i].cget("text"))
                else:
                    txt = cb[i].cget("text")
                    key = keys[i]
                    temp.append(txt)
                    temp.append(key)
                    checked.append(temp)
                    temp = []
        return checked


# ======================================================
# function clear()
# clears all checked items
# ======================================================
    def clear(self):
        for i in range(items):
            if vars[i].get() == '1':
                vars[i].set('0')


# ======================================================
# function load()
# Loads a list of items into the checked list box
# ======================================================
    def load(self, ListItems):
        global cb
        global id
        global items
        global vars
        global keys
        global single
        cb = {}
        id = {}
        vars = []
        idkey = []
        keys = []
        items = len(ListItems)
        single = True
        for j in range(len(ListItems)):
            vars.append(tk.StringVar())
            vars[-1].set(0)
            if len(ListItems[j]) == 2:
                single = False
                txt = ListItems[j][0]
                key = ListItems[j][1]
                cb[j] = tk.Checkbutton(
                                       self.inner_frame,
                                       text=ListItems[j][0],
                                       height=1)
                keys.append(key)
            else:
                single = True
                cb[j] = tk.Checkbutton(
                                       self.inner_frame,
                                       text=ListItems[j],
                                       height=1)

            cb[j].grid(row=j, column=0)
            # Since under Linux <Button-1> fires before the command event,
            # and under Windows command fires after both, we should be able
            # to use <Button-1> to set the selected item and command to actually
            # get the rest of the information
            # cb[j].bind('<ButtonRelease-1>', self.select_button)
            cb[j].bind('<Button-1>', self.select_button)
            cb[j].config(anchor="w")
            cb[j].config(width=110)
            cb[j].config(variable=vars[-1])
            cb[j].cntr=j
            cb[j].config(command=self.select_button_cmd)
            id[cb[j].winfo_id()] = j


# ======================================================
# function select_button()
# is called when any of the checked boxes is clicked.
# send item number of checkbutton and text to
# callback routine pass into __init__
# ======================================================
    def select_button(self, event):
        global selected
        selected = id[event.widget.winfo_id()]
        # self.invoke(select_button_cmd(selected))
        # tx = cb[selected].cget("text")
        # rtn = [selected, tx]
        # if callable(self.cback):
            # self.cback(rtn)
        # return tx

# ======================================================
# function select_button()
# is called when any of the checked boxes is clicked.
# send item number of checkbutton and text to
# callback routine pass into __init__
# ======================================================
    def select_button_cmd(self,which=None):
        global selected
        tx = cb[selected].cget("text")
        rtn = [selected, tx]
        if callable(self.cback):
            self.cback(rtn)
        return tx
# ======================================================
# function set()
# takes a list of items to set to checked upon load
# i.e. set items to database information for edit form
# ======================================================
    def set(self, items_to_check):
        for c in items_to_check:
            for i in range(items):
                if cb[i].cget("text") == c:
                    vars[i].set(1)

# ======================================================
# End of Class ScrolledFrame
# ======================================================
