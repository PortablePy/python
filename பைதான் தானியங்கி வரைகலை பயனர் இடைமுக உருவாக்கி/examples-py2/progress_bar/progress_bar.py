#! /usr/bin/env python
#
# GUI module generated by PAGE version 4.8.7a
# In conjunction with Tcl version 8.6
#    Jan 16, 2017 07:00:12 PM
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

import progress_bar_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, வேர்
    வேர் = Tk()
    progress_bar_support.set_Tk_var()
    top = Progress_Bar (வேர்)
    progress_bar_support.init(வேர், top)
    வேர்.mainloop()

w = None
def create_Progress_Bar(வேர், *args, **kwargs):
    '''Starting point when module is imported by another program.'''
    global w, w_win, rt
    rt = வேர்
    w = Toplevel (வேர்)
    progress_bar_support.set_Tk_var()
    top = Progress_Bar (w)
    progress_bar_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Progress_Bar():
    global w
    w.destroy()
    w = None


class Progress_Bar:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = 'wheat'  # X11 color: #f5deb3
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'
        self.style = ttk.Style()
        if sys.platform == "win32":
            self.style.theme_use('winnative')
        self.style.configure('.',background=_bgcolor)
        self.style.configure('.',foreground=_fgcolor)
        self.style.map('.',background=
            [('selected', _compcolor), ('active',_ana2color)])

        top.geometry("301x129+472+154")
        top.title("Progress Bar")
        top.configure(background="wheat")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")



        self.TProgressbar1 = ttk.Progressbar(top)
        self.TProgressbar1.place(relx=0.17, rely=0.47, relwidth=0.66
                , relheight=0.0, height=19)
        self.TProgressbar1.configure(variable=progress_bar_support.prog_var)






if __name__ == '__main__':
    vp_start_gui()



