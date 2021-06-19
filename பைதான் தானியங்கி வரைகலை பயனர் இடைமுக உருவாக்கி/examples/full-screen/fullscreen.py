#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#    May 13, 2021 08:07:52 PM PDT  platform: Linux

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

import fullscreen_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = tk.Tk()
    top = Toplevel1 (root)
    fullscreen_support.init(root, top)
    root.mainloop()

w = None
def create_Toplevel1(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_Toplevel1(root, *args, **kwargs)' .'''
    global w, w_win, root
    #rt = root
    root = rt
    w = tk.Toplevel (root)
    top = Toplevel1 (w)
    fullscreen_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Toplevel1():
    global w
    w.destroy()
    w = None

class Toplevel1:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = 'wheat'  # X11 color: #f5deb3
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'
        font15 = "-family {DejaVu Sans} -size 12"

        top.geometry("600x565+660+244")
        top.minsize(1, 1)
        top.maxsize(1905, 1050)
        top.resizable(0,  0)
        top.title("New Toplevel")
        top.configure(background="wheat")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")
        top.bind('<Key-Escape>',lambda e:fullscreen_support.quitFullScreen(e))
        top.bind('<Key-F11>',lambda e:fullscreen_support.toggleFullScreen(e))

        self.menubar = tk.Menu(top, font="-family {DejaVu Sans} -size 12"
                ,bg='#d9d9d9', fg=_fgcolor)
        top.configure(menu = self.menubar)

        self.sub_menu = tk.Menu(top,
                activebackground="#f4bcb2",
                disabledforeground="#b8a786",
                font="-family {DejaVu Sans} -size 12",
                tearoff=0)
        self.menubar.add_cascade(menu=self.sub_menu,
                label="File")
        self.sub_menu.add_command(
                label="Open")
        self.sub_menu.add_command(
                command=fullscreen_support.quit,
                label="Quit")
        self.sub_menu1 = tk.Menu(top,
                activebackground="#f4bcb2",
                disabledforeground="#b8a786",
                font="-family {DejaVu Sans} -size 12",
                tearoff=0)
        self.menubar.add_cascade(menu=self.sub_menu1,
                label="Screen")
        self.sub_menu1.add_command(
                command=fullscreen_support.full_screen,
                label="Full Screen")
        self.sub_menu1.add_command(
                command=fullscreen_support.partial_screen,
                label="Partial Screen")
        self.sub_menu1.add_command(
                command=fullscreen_support.toggle_screen_fill,
                label="Toggle Screen Fill")
        self.sub_menu12 = tk.Menu(top,
                activebackground="#f4bcb2",
                disabledforeground="#b8a786",
                font="-family {DejaVu Sans} -size 12",
                tearoff=0)
        self.menubar.add_cascade(menu=self.sub_menu12,
                label="Help")
        self.sub_menu12.add_command(
                command=fullscreen_support.help,
                label="Help")
        self.sub_menu12.add_command(
                command=fullscreen_support.about,
                label="About")

        self.Button1 = tk.Button(top)
        self.Button1.place(x=240, y=490, height=39, width=96)
        self.Button1.configure(activebackground="#f4bcb2")
        self.Button1.configure(background="wheat")
        self.Button1.configure(borderwidth="2")
        self.Button1.configure(command=fullscreen_support.quit)
        self.Button1.configure(disabledforeground="#b8a786")
        self.Button1.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Button1.configure(highlightbackground="wheat")
        self.Button1.configure(text='''Quit''')

        self.Text1 = tk.Text(top)
        self.Text1.place(x=80, y=40, height=318, width=426)
        self.Text1.configure(background="white")
        self.Text1.configure(font="-family {DejaVu Sans} -size 14")
        self.Text1.configure(highlightbackground="wheat")
        self.Text1.configure(selectbackground="blue")
        self.Text1.configure(selectforeground="white")
        self.Text1.configure(wrap="word")

        self.Message1 = tk.Message(top)
        self.Message1.place(x=140, y=390, height=64, width=308)
        self.Message1.configure(background="wheat")
        self.Message1.configure(font="-family {DejaVu Sans Mono} -size 14")
        self.Message1.configure(highlightbackground="wheat")
        self.Message1.configure(text='''F11    - Toggle Full Screen
Escape - Quit Full Screen''')
        self.Message1.configure(width=308)

if __name__ == '__main__':
    vp_start_gui()





