#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 4.17.4
# In conjunction with Tcl version 8.6
#    Sep 16, 2018 09:47:23 PM PDT  platform: Linux

import sys

try:
    from Tkinter import *
except ImportError:
    from tkinter import *

try:
    import ttk
    py3 = False
except ImportError:
    import tkinter.ttk as ttk
    py3 = True

import dual_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = Tk()
    top = Two_Custom_Widgets (root)
    dual_support.init(root, top)
    root.mainloop()

w = None
def create_Two_Custom_Widgets(root, *args, **kwargs):
    '''Starting point when module is imported by another program.'''
    global w, w_win, rt
    rt = root
    w = Toplevel (root)
    top = Two_Custom_Widgets (w)
    dual_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Two_Custom_Widgets():
    global w
    w.destroy()
    w = None


class Two_Custom_Widgets:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#d9d9d9'  # X11 color: 'gray85'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}' 
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2' 
        font10 = "-family {DejaVu Sans} -size 14 -weight normal -slant"  \
            " roman -underline 0 -overstrike 0"
        font11 = "-family {DejaVu Sans} -size 12 -weight normal -slant"  \
            " roman -underline 0 -overstrike 0"
        font13 = "-family {DejaVu Sans Mono} -size 11 -weight normal "  \
            "-slant roman -underline 0 -overstrike 0"
        font9 = "-family {DejaVu Sans Mono} -size 14 -weight normal "  \
            "-slant roman -underline 0 -overstrike 0"
        self.style = ttk.Style()
        if sys.platform == "win32":
            self.style.theme_use('winnative')
        self.style.configure('.',background=_bgcolor)
        self.style.configure('.',foreground=_fgcolor)
        self.style.configure('.',font=font9)
        self.style.map('.',background=
            [('selected', _compcolor), ('active',_ana2color)])

        top.geometry("1097x789+235+112")
        top.title("Two Custom Widgets")
        top.configure(highlightbackground="#f5deb3")
        top.configure(highlightcolor="black")



        self.menubar = Menu(top,font=font10,bg=_bgcolor,fg=_fgcolor)
        top.configure(menu = self.menubar)

        self.zoom = Menu(top,tearoff=0)
        self.menubar.add_cascade(menu=self.zoom,
                activebackground="#f4bcb2",
                activeforeground="#111111",
                background="#d9d9d9",
                font=font11,
                foreground="#000000",
                label="Zoom")
        self.zoom.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=lambda:dual_support.zoom('in'),
                font=font11,
                foreground="#000000",
                label="Zoom In")
        self.zoom.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=lambda:dual_support.zoom('out'),
                font=font11,
                foreground="#000000",
                label="Zoom Out")
        self.zoom.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=lambda:dual_support.zoom('default'),
                font=font11,
                foreground="#000000",
                label="Default Size")
        self.menubar.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=dual_support.refresh,
                font=font11,
                foreground="#000000",
                label="Refresh")
        self.menubar.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=dual_support.quit,
                font=font11,
                foreground="#000000",
                label="Quit")


        self.Frame1 = Frame(top)
        self.Frame1.place(relx=0.073, rely=0.101, relheight=0.475
                , relwidth=0.242)
        self.Frame1.configure(relief=GROOVE)
        self.Frame1.configure(borderwidth="2")
        self.Frame1.configure(relief=GROOVE)
        self.Frame1.configure(highlightbackground="#f5deb3")
        self.Frame1.configure(width=265)

        self.Custom1_4 = dual_support.Custom_g(self.Frame1)
        self.Custom1_4.place(relx=0.0, rely=0.0, relheight=1.0, relwidth=1.0)

        self.btnGetChecks = Button(top)
        self.btnGetChecks.place(relx=0.119, rely=0.621, height=30, width=160)
        self.btnGetChecks.configure(activebackground="#d9d9d9")
        self.btnGetChecks.configure(command=dual_support.on_btnGetChecks)
        self.btnGetChecks.configure(disabledforeground="#b8a786")
        self.btnGetChecks.configure(font=font9)
        self.btnGetChecks.configure(highlightbackground="#f5deb3")
        self.btnGetChecks.configure(text='''Get Checks''')

        self.btnClearChecks = Button(top)
        self.btnClearChecks.place(relx=0.119, rely=0.71, height=30, width=160)
        self.btnClearChecks.configure(activebackground="#d9d9d9")
        self.btnClearChecks.configure(command=dual_support.on_btnClearChecks)
        self.btnClearChecks.configure(disabledforeground="#b8a786")
        self.btnClearChecks.configure(font=font9)
        self.btnClearChecks.configure(highlightbackground="#f5deb3")
        self.btnClearChecks.configure(text='''Clear Checks''')

        self.btnExit = Button(top)
        self.btnExit.place(relx=0.146, rely=0.824, height=30, width=110)
        self.btnExit.configure(activebackground="#d9d9d9")
        self.btnExit.configure(command=dual_support.on_btnExit)
        self.btnExit.configure(disabledforeground="#b8a786")
        self.btnExit.configure(font=font9)
        self.btnExit.configure(highlightbackground="#f5deb3")
        self.btnExit.configure(text='''Exit''')

        self.Message1 = Message(top)
        self.Message1.place(relx=0.009, rely=0.013, relheight=0.08
                , relwidth=0.384)
        self.Message1.configure(font=font13)
        self.Message1.configure(highlightbackground="#f5deb3")
        self.Message1.configure(relief=SUNKEN)
        self.Message1.configure(text='''Message''')
        self.Message1.configure(width=421)

        self.style.configure('TSizegrip', background=_bgcolor)
        self.TSizegrip1 = ttk.Sizegrip(top)
        self.TSizegrip1.place(anchor=SE, relx=1.0, rely=1.0)
        self.TSizegrip1.bind('<ButtonRelease-1>',lambda e:dual_support.refresh())

        self.Frame2 = Frame(top)
        self.Frame2.place(relx=0.428, rely=0.101, relheight=0.639
                , relwidth=0.506)
        self.Frame2.configure(relief=GROOVE)
        self.Frame2.configure(borderwidth="2")
        self.Frame2.configure(relief=GROOVE)
        self.Frame2.configure(highlightbackground="#f5deb3")
        self.Frame2.configure(width=555)

        self.Custom1 = dual_support.Custom_d(self.Frame2)
        self.Custom1.place(relx=0.0, rely=0.0, relheight=1.0, relwidth=1.0)

    @staticmethod
    def popup1(event, *args, **kwargs):
        font11 = "-family {DejaVu Sans} -size 12 -weight normal -slant"  \
            " roman -underline 0 -overstrike 0"
        font12 = "-family {DejaVu Sans} -size 10 -weight normal -slant"  \
            " roman -underline 0 -overstrike 0"
        font9 = "-family {DejaVu Sans Mono} -size 14 -weight normal "  \
            "-slant roman -underline 0 -overstrike 0"
        Popupmenu1 = Menu(root, tearoff=0)
        Popupmenu1.configure(activebackground="#ffffcd")
        Popupmenu1.configure(disabledforeground="#b8a786")
        Popupmenu1.configure(font=font12)
        zoom = Menu(Popupmenu1,tearoff=0)
        Popupmenu1.add_cascade(menu=zoom,
                activebackground="#f4bcb2",
                activeforeground="#111111",
                background="#d9d9d9",
                font=font9,
                foreground="#000000",
                label="Zoom")
        zoom.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=lambda:dual_support.zoom('in'),
                font=font11,
                foreground="#000000",
                label="Zoom In")
        zoom.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=lambda:dual_support.zoom('out'),
                font=font11,
                foreground="#000000",
                label="Zoom Out")
        zoom.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=lambda:dual_support.zoom('default'),
                font=font11,
                foreground="#000000",
                label="Default Size")
        Popupmenu1.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=dual_support.refresh,
                font=font11,
                foreground="#000000",
                label="Refresh")
        Popupmenu1.add_command(
                activebackground="#f4bcb2",
                activeforeground="#000000",
                background="#d9d9d9",
                command=dual_support.quit,
                font=font11,
                foreground="#000000",
                label="Quit")
        Popupmenu1.post(event.x_root, event.y_root)






if __name__ == '__main__':
    vp_start_gui()



