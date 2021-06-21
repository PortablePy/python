#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#    May 14, 2021 12:10:35 PM PDT  platform: Linux

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

import lib_demo_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, வேர்
    வேர் = tk.Tk()
    top = Toplevel1 (வேர்)
    lib_demo_support.init(வேர், top)
    வேர்.mainloop()

w = None
def create_Toplevel1(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_Toplevel1(வேர், *args, **kwargs)' .'''
    global w, w_win, வேர்
    #rt = வேர்
    வேர் = rt
    w = tk.Toplevel (வேர்)
    top = Toplevel1 (w)
    lib_demo_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Toplevel1():
    global w
    w.destroy()
    w = None

class Toplevel1:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#f5deb3'  # X11 color: 'wheat'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'
        font15 = "-family {DejaVu Sans} -size 12"

        top.geometry("600x450")
        top.minsize(1, 1)
        top.maxsize(1905, 1050)
        top.resizable(0,  0)
        top.title("Library Demo")
        top.configure(background="#f5deb3")
        top.configure(highlightbackground="#f5deb3")
        top.configure(highlightcolor="black")

        self.menubar = tk.Menu(top, font="-family {DejaVu Sans} -size 12"
                ,bg=_bgcolor, fg=_fgcolor)
        top.configure(menu = self.menubar)

        self.sub_menu = tk.Menu(top,
                activebackground="#ffffcd",
                activeforeground="black",
                background="#f5deb3",
                disabledforeground="#b8a786",
                foreground="black",
                tearoff=0)
        self.menubar.add_cascade(menu=self.sub_menu,
                activebackground="#f4bcb2",
                activeforeground="#111111",
                background="#f5deb3",
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Zoom")
        self.sub_menu.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lambda:lib_demo_support.zoom('in'),
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Zoom In")
        self.sub_menu.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lambda:lib_demo_support.zoom('out'),
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Zoom Out")
        self.sub_menu.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lambda:lib_demo_support.zoom('default'),
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Default Size")
        self.menubar.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lib_demo_support.refresh,
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Refresh")
        self.menubar.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lib_demo_support.quit,
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Quit")

        self.Custom1 = lib_demo_support.Custom(top)
        self.Custom1.place(x=0, y=0, height=450, width=600)

    @staticmethod
    def popup1(event, *args, **kwargs):
        Popupmenu1 = tk.Menu(வேர், tearoff=0)
        Popupmenu1.configure(activebackground="#ffffcd")
        Popupmenu1.configure(background="#f5deb3")
        Popupmenu1.configure(disabledforeground="#b8a786")
        Popupmenu1.configure(font="-family {DejaVu Sans} -size 10")
        sub_menu = tk.Menu(Popupmenu1,
                activebackground="#ffffcd",
                activeforeground="black",
                background="#f5deb3",
                disabledforeground="#b8a786",
                foreground="black",
                tearoff=0)
        Popupmenu1.add_cascade(menu=sub_menu,
                activebackground="#f4bcb2",
                activeforeground="#111111",
                background="#f5deb3",
                font="-family {DejaVu Sans Mono} -size 14",
                foreground="#000000",
                label="Zoom")
        sub_menu.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lambda:lib_demo_support.zoom('in'),
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Zoom In")
        sub_menu.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lambda:lib_demo_support.zoom('out'),
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Zoom Out")
        sub_menu.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lambda:lib_demo_support.zoom('default'),
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Default Size")
        Popupmenu1.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lib_demo_support.refresh,
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Refresh")
        Popupmenu1.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#f5deb3",
                command=lib_demo_support.quit,
                font="-family {DejaVu Sans} -size 12",
                foreground="#000000",
                label="Quit")
        Popupmenu1.post(event.x_root, event.y_root)

if __name__ == '__main__':
    vp_start_gui()





