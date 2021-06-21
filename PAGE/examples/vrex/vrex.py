#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#    May 14, 2021 10:01:41 AM PDT  platform: Linux

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

import vrex_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, root
    root = tk.Tk()
    top = Toplevel1 (root)
    vrex_support.init(root, top)
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
    vrex_support.init(w, top, *args, **kwargs)
    return (w, top)

def destroy_Toplevel1():
    global w
    w.destroy()
    w = None

class Toplevel1:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#d9d9d9'  # X11 color: 'gray85'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#b2c9f4' # Closest X11 color: 'SlateGray2'
        _ana1color = '#eaf4b2' # Closest X11 color: '{pale goldenrod}'
        _ana2color = '#f4bcb2' # Closest X11 color: 'RosyBrown2'
        font12 = "-family {DejaVu Sans Mono} -size 14"
        font15 = "-family {DejaVu Sans} -size 12"
        self.style = ttk.Style()
        if sys.platform == "win32":
            self.style.theme_use('winnative')
        self.style.configure('.',background=_bgcolor)
        self.style.configure('.',foreground=_fgcolor)
        self.style.configure('.',font=font12)
        self.style.map('.',background=
            [('selected', _compcolor), ('active',_ana2color)])

        top.geometry("609x605+645+221")
        top.minsize(1, 1)
        top.maxsize(1905, 1170)
        top.resizable(0,  0)
        top.title("Vrex for Python")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")

        self.TPanedwindow1 = ttk.Panedwindow(top, orient="vertical")
        self.TPanedwindow1.place(x=12, y=20, height=499, width=585)
        self.TPanedwindow1_f1 = ttk.Labelframe(self.TPanedwindow1, height=75
                , text='Regular Expression')
        self.TPanedwindow1.add(self.TPanedwindow1_f1, weight=0)
        self.TPanedwindow1_f2 = ttk.Labelframe(self.TPanedwindow1, height=75
                , text='Sample')
        self.TPanedwindow1.add(self.TPanedwindow1_f2, weight=0)
        self.TPanedwindow1_f3 = ttk.Labelframe(self.TPanedwindow1
                , text='Matches')
        self.TPanedwindow1.add(self.TPanedwindow1_f3, weight=0)
        self.__funcid0 = self.TPanedwindow1.bind('<Map>', self.__adjust_sash0)

        self.Expression = ScrolledText(self.TPanedwindow1_f1)
        self.Expression.place(x=10, y=20, height=56, width=561
                , bordermode='ignore')
        self.Expression.configure(background="white")
        self.Expression.configure(font="-family {Nimbus Sans L} -size 12 -weight bold")
        self.Expression.configure(highlightbackground="wheat")
        self.Expression.configure(insertborderwidth="3")
        self.Expression.configure(selectbackground="#c4c4c4")
        self.Expression.configure(wrap="none")

        self.Sample = ScrolledText(self.TPanedwindow1_f2)
        self.Sample.place(x=10, y=23, height=50, width=561, bordermode='ignore')
        self.Sample.configure(background="white")
        self.Sample.configure(font="-family {Nimbus Sans L} -size 12 -weight bold")
        self.Sample.configure(insertborderwidth="3")
        self.Sample.configure(selectbackground="#c4c4c4")
        self.Sample.configure(wrap="none")
        self.Sample.bind('<Button-1>',vrex_support.sync_matches)

        self.Matches = ScrolledText(self.TPanedwindow1_f3)
        self.Matches.place(x=10, y=19, height=304, width=561
                , bordermode='ignore')
        self.Matches.configure(background="white")
        self.Matches.configure(font="-family {Nimbus Sans L} -size 12 -weight bold")
        self.Matches.configure(insertborderwidth="3")
        self.Matches.configure(selectbackground="#c4c4c4")
        self.Matches.configure(wrap="none")
        self.Matches.bind('<Button-1>',vrex_support.sync_sample)

        self.menubar = tk.Menu(top, font="-family {DejaVu Sans} -size 12"
                ,bg=_bgcolor, fg=_fgcolor)
        top.configure(menu = self.menubar)

        self.sub_menu = tk.Menu(top,
                activebackground="#f9f9f9",
                activeforeground="black",
                disabledforeground="#b8a786",
                foreground="black",
                tearoff=0)
        self.menubar.add_cascade(menu=self.sub_menu,
                background="#d9d9d9",
                font="-family {Nimbus Sans L} -size 14",
                label="File")
        self.sub_menu.add_command(
                background="#d9d9d9",
                command=vrex_support.load_regular_expression,
                font="-family {Nimbus Sans L} -size 14",
                label="Load regular expression")
        self.sub_menu.add_command(
                background="#d9d9d9",
                command=vrex_support.save_regular_expression,
                font="-family {Nimbus Sans L} -size 14",
                label="Save regular expression")
        self.sub_menu.add_separator(
                background="#d9d9d9")
        self.sub_menu.add_command(
                background="#d9d9d9",
                command=vrex_support.load_sample,
                font="-family {Nimbus Sans L} -size 14",
                label="Load sample")
        self.sub_menu.add_command(
                background="#d9d9d9",
                command=vrex_support.save_sample,
                font="-family {Nimbus Sans L} -size 14",
                label="Save sample")
        self.sub_menu.add_separator(
                background="#d9d9d9")
        self.sub_menu.add_command(
                background="#d9d9d9",
                command=vrex_support.quit,
                font="-family {Nimbus Sans L} -size 14",
                label="Quit")
        self.sub_menu1 = tk.Menu(top,
                activebackground="#ffffcd",
                activeforeground="black",
                background="wheat",
                disabledforeground="#b8a786",
                foreground="black",
                tearoff=0)
        self.menubar.add_cascade(menu=self.sub_menu1,
                activebackground="#f4bcb2",
                activeforeground="#111111",
                background="#d9d9d9",
                font="-family {Nimbus Sans L} -size 14",
                foreground="#000000",
                label="Help")
        self.sub_menu1.add_command(
                activebackground="#f4bcb2",
                activeforeground="#111111",
                background="#d9d9d9",
                command=vrex_support.help,
                font="TkDefaultFont",
                foreground="#000000",
                label="Vrex Help")

        self.Quit = tk.Button(top)
        self.Quit.place(x=541, y=550, height=29, width=53)
        self.Quit.configure(activebackground="#f9f9f9")
        self.Quit.configure(command=vrex_support.quit)
        self.Quit.configure(disabledforeground="#b8a786")
        self.Quit.configure(highlightbackground="wheat")
        self.Quit.configure(text='''Quit''')

        self.Match = tk.Button(top)
        self.Match.place(x=62, y=550, height=29, width=65)
        self.Match.configure(activebackground="#f9f9f9")
        self.Match.configure(command=lambda:vrex_support.display(0))
        self.Match.configure(disabledforeground="#b8a786")
        self.Match.configure(highlightbackground="wheat")
        self.Match.configure(text='''Match''')

        self.Button1 = tk.Button(top)
        self.Button1.place(x=136, y=550, height=29, width=36)
        self.Button1.configure(activebackground="#f9f9f9")
        self.Button1.configure(background="#ffffff")
        self.Button1.configure(command=lambda:vrex_support.display(1))
        self.Button1.configure(disabledforeground="#b8a786")
        self.Button1.configure(foreground="blue")
        self.Button1.configure(highlightbackground="wheat")
        self.Button1.configure(text='''1''')

        self.Button2 = tk.Button(top)
        self.Button2.place(x=181, y=550, height=29, width=36)
        self.Button2.configure(activebackground="#f9f9f9")
        self.Button2.configure(background="#ffffff")
        self.Button2.configure(command=lambda:vrex_support.display(2))
        self.Button2.configure(disabledforeground="#b8a786")
        self.Button2.configure(foreground="darkgreen")
        self.Button2.configure(highlightbackground="wheat")
        self.Button2.configure(text='''2''')

        self.Button3 = tk.Button(top)
        self.Button3.place(x=226, y=550, height=29, width=36)
        self.Button3.configure(activebackground="#f9f9f9")
        self.Button3.configure(background="#ffffff")
        self.Button3.configure(command=lambda:vrex_support.display(3))
        self.Button3.configure(disabledforeground="#b8a786")
        self.Button3.configure(foreground="magenta")
        self.Button3.configure(highlightbackground="wheat")
        self.Button3.configure(text='''3''')

        self.Button4 = tk.Button(top)
        self.Button4.place(x=271, y=550, height=29, width=36)
        self.Button4.configure(activebackground="#f9f9f9")
        self.Button4.configure(background="#ffffff")
        self.Button4.configure(command=lambda:vrex_support.display(4))
        self.Button4.configure(disabledforeground="#b8a786")
        self.Button4.configure(foreground="sienna")
        self.Button4.configure(highlightbackground="wheat")
        self.Button4.configure(text='''4''')

        self.Button5 = tk.Button(top)
        self.Button5.place(x=316, y=550, height=29, width=36)
        self.Button5.configure(activebackground="#f9f9f9")
        self.Button5.configure(background="#ffffff")
        self.Button5.configure(command=lambda:vrex_support.display(5))
        self.Button5.configure(disabledforeground="#b8a786")
        self.Button5.configure(foreground="purple")
        self.Button5.configure(highlightbackground="wheat")
        self.Button5.configure(text='''5''')

        self.Button6 = tk.Button(top)
        self.Button6.place(x=361, y=550, height=29, width=36)
        self.Button6.configure(activebackground="#f9f9f9")
        self.Button6.configure(background="#ffffff")
        self.Button6.configure(command=lambda:vrex_support.display(6))
        self.Button6.configure(disabledforeground="#b8a786")
        self.Button6.configure(foreground="firebrick")
        self.Button6.configure(highlightbackground="wheat")
        self.Button6.configure(text='''6''')

        self.Button7 = tk.Button(top)
        self.Button7.place(x=406, y=550, height=29, width=36)
        self.Button7.configure(activebackground="#f9f9f9")
        self.Button7.configure(background="#ffffff")
        self.Button7.configure(command=lambda:vrex_support.display(7))
        self.Button7.configure(disabledforeground="#b8a786")
        self.Button7.configure(foreground="deeppink")
        self.Button7.configure(highlightbackground="wheat")
        self.Button7.configure(text='''7''')

        self.Button8 = tk.Button(top)
        self.Button8.place(x=451, y=550, height=29, width=36)
        self.Button8.configure(activebackground="#f9f9f9")
        self.Button8.configure(background="#ffffff")
        self.Button8.configure(command=lambda:vrex_support.display(8))
        self.Button8.configure(disabledforeground="#b8a786")
        self.Button8.configure(foreground="green4")
        self.Button8.configure(highlightbackground="wheat")
        self.Button8.configure(text='''8''')

        self.Button9 = tk.Button(top)
        self.Button9.place(x=496, y=550, height=29, width=36)
        self.Button9.configure(activebackground="#f9f9f9")
        self.Button9.configure(background="#ffffff")
        self.Button9.configure(command=lambda:vrex_support.display(9))
        self.Button9.configure(disabledforeground="#b8a786")
        self.Button9.configure(foreground="deepskyblue1")
        self.Button9.configure(highlightbackground="wheat")
        self.Button9.configure(text='''9''')

        self.Go = tk.Button(top)
        self.Go.place(x=9, y=550, height=29, width=44)
        self.Go.configure(activebackground="#f9f9f9")
        self.Go.configure(command=vrex_support.go)
        self.Go.configure(disabledforeground="#b8a786")
        self.Go.configure(highlightbackground="wheat")
        self.Go.configure(text='''Go''')

        self.style.configure('TSizegrip', background=_bgcolor)
        self.TSizegrip1 = ttk.Sizegrip(top)
        self.TSizegrip1.place(anchor='se', relx=1.0, rely=1.0)

    def __adjust_sash0(self, event):
        paned = event.widget
        pos = [82, 167, ]
        i = 0
        for sash in pos:
            paned.sashpos(i, sash)
            i += 1
        paned.unbind('<map>', self.__funcid0)
        del self.__funcid0

# The following code is added to facilitate the Scrolled widgets you specified.
class AutoScroll(object):
    '''Configure the scrollbars for a widget.'''
    def __init__(self, master):
        #  Rozen. Added the try-except clauses so that this class
        #  could be used for scrolled entry widget for which vertical
        #  scrolling is not supported. 5/7/14.
        try:
            vsb = ttk.Scrollbar(master, orient='vertical', command=self.yview)
        except:
            pass
        hsb = ttk.Scrollbar(master, orient='horizontal', command=self.xview)
        try:
            self.configure(yscrollcommand=self._autoscroll(vsb))
        except:
            pass
        self.configure(xscrollcommand=self._autoscroll(hsb))
        self.grid(column=0, row=0, sticky='nsew')
        try:
            vsb.grid(column=1, row=0, sticky='ns')
        except:
            pass
        hsb.grid(column=0, row=1, sticky='ew')
        master.grid_columnconfigure(0, weight=1)
        master.grid_rowconfigure(0, weight=1)
        # Copy geometry methods of master  (taken from ScrolledText.py)
        if py3:
            methods = tk.Pack.__dict__.keys() | tk.Grid.__dict__.keys() \
                  | tk.Place.__dict__.keys()
        else:
            methods = tk.Pack.__dict__.keys() + tk.Grid.__dict__.keys() \
                  + tk.Place.__dict__.keys()
        for meth in methods:
            if meth[0] != '_' and meth not in ('config', 'configure'):
                setattr(self, meth, getattr(master, meth))

    @staticmethod
    def _autoscroll(sbar):
        '''Hide and show scrollbar as needed.'''
        def wrapped(first, last):
            first, last = float(first), float(last)
            if first <= 0 and last >= 1:
                sbar.grid_remove()
            else:
                sbar.grid()
            sbar.set(first, last)
        return wrapped

    def __str__(self):
        return str(self.master)

def _create_container(func):
    '''Creates a ttk Frame with a given master, and use this new frame to
    place the scrollbars and the widget.'''
    def wrapped(cls, master, **kw):
        container = ttk.Frame(master)
        container.bind('<Enter>', lambda e: _bound_to_mousewheel(e, container))
        container.bind('<Leave>', lambda e: _unbound_to_mousewheel(e, container))
        return func(cls, container, **kw)
    return wrapped

class ScrolledText(AutoScroll, tk.Text):
    '''A standard Tkinter Text widget with scrollbars that will
    automatically show/hide as needed.'''
    @_create_container
    def __init__(self, master, **kw):
        tk.Text.__init__(self, master, **kw)
        AutoScroll.__init__(self, master)

import platform
def _bound_to_mousewheel(event, widget):
    child = widget.winfo_children()[0]
    if platform.system() == 'Windows' or platform.system() == 'Darwin':
        child.bind_all('<MouseWheel>', lambda e: _on_mousewheel(e, child))
        child.bind_all('<Shift-MouseWheel>', lambda e: _on_shiftmouse(e, child))
    else:
        child.bind_all('<Button-4>', lambda e: _on_mousewheel(e, child))
        child.bind_all('<Button-5>', lambda e: _on_mousewheel(e, child))
        child.bind_all('<Shift-Button-4>', lambda e: _on_shiftmouse(e, child))
        child.bind_all('<Shift-Button-5>', lambda e: _on_shiftmouse(e, child))

def _unbound_to_mousewheel(event, widget):
    if platform.system() == 'Windows' or platform.system() == 'Darwin':
        widget.unbind_all('<MouseWheel>')
        widget.unbind_all('<Shift-MouseWheel>')
    else:
        widget.unbind_all('<Button-4>')
        widget.unbind_all('<Button-5>')
        widget.unbind_all('<Shift-Button-4>')
        widget.unbind_all('<Shift-Button-5>')

def _on_mousewheel(event, widget):
    if platform.system() == 'Windows':
        widget.yview_scroll(-1*int(event.delta/120),'units')
    elif platform.system() == 'Darwin':
        widget.yview_scroll(-1*int(event.delta),'units')
    else:
        if event.num == 4:
            widget.yview_scroll(-1, 'units')
        elif event.num == 5:
            widget.yview_scroll(1, 'units')

def _on_shiftmouse(event, widget):
    if platform.system() == 'Windows':
        widget.xview_scroll(-1*int(event.delta/120), 'units')
    elif platform.system() == 'Darwin':
        widget.xview_scroll(-1*int(event.delta), 'units')
    else:
        if event.num == 4:
            widget.xview_scroll(-1, 'units')
        elif event.num == 5:
            widget.xview_scroll(1, 'units')

if __name__ == '__main__':
    vp_start_gui()





