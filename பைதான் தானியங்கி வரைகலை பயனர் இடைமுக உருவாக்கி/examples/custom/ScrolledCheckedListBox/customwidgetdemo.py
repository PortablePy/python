#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#    May 17, 2021 06:32:30 AM PDT  platform: Linux

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

import customwidgetdemo_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, வேர்
    வேர் = tk.Tk()
    top = formCustomDemo (வேர்)
    customwidgetdemo_support.init(வேர், top)
    வேர்.mainloop()

w = None
def create_formCustomDemo(rt, *args, **kwargs):
    '''Starting point when module is imported by another module.
       Correct form of call: 'create_formCustomDemo(வேர், *args, **kwargs)' .'''
    global w, w_win, வேர்
    #rt = வேர்
    வேர் = rt
    w = tk.Toplevel (வேர்)
    top = formCustomDemo (w)
    customwidgetdemo_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_formCustomDemo():
    global w
    w.destroy()
    w = None

class formCustomDemo:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#d9d9d9'  # X11 color: 'gray85'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#d9d9d9' # X11 color: 'gray85'
        _ana1color = '#d9d9d9' # X11 color: 'gray85'
        _ana2color = '#d9d9d9' # X11 color: 'gray85'
        self.style = ttk.Style()
        if sys.platform == "win32":
            self.style.theme_use('winnative')
        self.style.configure('.',background=_bgcolor)
        self.style.configure('.',foreground=_fgcolor)
        self.style.map('.',background=
            [('selected', _compcolor), ('active',_ana2color)])

        top.geometry("529x522+296+123")
        top.minsize(1, 1)
        top.maxsize(1265, 770)
        top.resizable(1,  1)
        top.title("Custom Widget Demo")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")

        self.style.configure('TSizegrip', background=_bgcolor)
        self.TSizegrip1 = ttk.Sizegrip(top)
        self.TSizegrip1.place(anchor='se', relx=1.0, rely=1.0)

        self.Message1 = tk.Message(top)
        self.Message1.place(relx=0.038, rely=0.029, relheight=0.121
                , relwidth=0.928)
        self.Message1.configure(font="-family {DejaVu Sans Mono} -size 10")
        self.Message1.configure(highlightbackground="wheat")
        self.Message1.configure(relief="sunken")
        self.Message1.configure(text='''Message''')
        self.Message1.configure(width=491)

        self.Frame1 = tk.Frame(top)
        self.Frame1.place(relx=0.057, rely=0.211, relheight=0.718
                , relwidth=0.501)
        self.Frame1.configure(relief='groove')
        self.Frame1.configure(borderwidth="2")
        self.Frame1.configure(relief="groove")
        self.Frame1.configure(highlightbackground="wheat")

        self.Custom1 = customwidgetdemo_support.Custom(self.Frame1)
        self.Custom1.place(relx=0.0, rely=0.0, relheight=1.0, relwidth=1.0)

        self.btnGetChecks = tk.Button(top)
        self.btnGetChecks.place(relx=0.681, rely=0.335, height=30, width=110)
        self.btnGetChecks.configure(activebackground="#d9d9d9")
        self.btnGetChecks.configure(command=customwidgetdemo_support.on_btnGetChecks)
        self.btnGetChecks.configure(disabledforeground="#b8a786")
        self.btnGetChecks.configure(font="-family {DejaVu Sans Mono} -size 10")
        self.btnGetChecks.configure(highlightbackground="wheat")
        self.btnGetChecks.configure(text='''Get Checks''')

        self.btnClearChecks = tk.Button(top)
        self.btnClearChecks.place(relx=0.681, rely=0.527, height=30, width=110)
        self.btnClearChecks.configure(activebackground="#d9d9d9")
        self.btnClearChecks.configure(command=customwidgetdemo_support.on_btnClearChecks)
        self.btnClearChecks.configure(disabledforeground="#b8a786")
        self.btnClearChecks.configure(font="-family {DejaVu Sans Mono} -size 10")
        self.btnClearChecks.configure(highlightbackground="wheat")
        self.btnClearChecks.configure(text='''Clear Checks''')

        self.btnExit = tk.Button(top)
        self.btnExit.place(relx=0.681, rely=0.718, height=30, width=110)
        self.btnExit.configure(activebackground="#d9d9d9")
        self.btnExit.configure(command=customwidgetdemo_support.on_btnExit)
        self.btnExit.configure(disabledforeground="#b8a786")
        self.btnExit.configure(font="-family {DejaVu Sans Mono} -size 10")
        self.btnExit.configure(highlightbackground="wheat")
        self.btnExit.configure(text='''Exit''')

if __name__ == '__main__':
    vp_start_gui()





