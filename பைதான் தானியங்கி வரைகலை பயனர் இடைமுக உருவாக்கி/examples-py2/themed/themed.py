#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# GUI module generated by PAGE version 4.20b
#  in conjunction with Tcl version 8.6
#    Jan 16, 2019 08:03:14 AM PST  platform: Linux

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

import themed_support

def vp_start_gui():
    '''Starting point when module is the main routine.'''
    global val, w, வேர்
    வேர் = tk.Tk()
    themed_support.set_Tk_var()
    top = Toplevel1 (வேர்)
    themed_support.init(வேர், top)
    வேர்.mainloop()

w = None
def create_Toplevel1(வேர், *args, **kwargs):
    '''Starting point when module is imported by another program.'''
    global w, w_win, rt
    rt = வேர்
    w = tk.Toplevel (வேர்)
    themed_support.set_Tk_var()
    top = Toplevel1 (w)
    themed_support.init(w, top, *args, **kwargs)
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
        font10 = "-family {DejaVu Sans Mono} -size 14 -weight normal "  \
            "-slant roman -underline 0 -overstrike 0"
        font11 = "TkDefaultFont"
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

        top.geometry("600x881+650+150")
        top.title("New Toplevel 1")
        top.configure(background="wheat")
        top.configure(highlightbackground="wheat")
        top.configure(highlightcolor="black")

        self.TButton1 = ttk.Button(top)
        self.TButton1.place(relx=0.017, rely=0.023, height=33, width=110)
        self.TButton1.configure(takefocus="")
        self.TButton1.configure(text='''Tbutton''')

        self.style.map('TCheckbutton',background=
            [('selected', _bgcolor), ('active', _ana2color)])
        self.TCheckbutton1 = ttk.Checkbutton(top)
        self.TCheckbutton1.place(relx=0.033, rely=0.079, relwidth=0.14
                , relheight=0.0, height=26)
        self.TCheckbutton1.configure(variable=themed_support.tch36)
        self.TCheckbutton1.configure(takefocus="")
        self.TCheckbutton1.configure(text='''Tcheck''')

        self.TCombobox1 = ttk.Combobox(top)
        self.TCombobox1.place(relx=0.033, rely=0.136, relheight=0.02
                , relwidth=0.295)
        self.TCombobox1.configure(textvariable=themed_support.combobox)
        self.TCombobox1.configure(takefocus="")

        self.TEntry1 = ttk.Entry(top)
        self.TEntry1.place(relx=0.05, rely=0.193, relheight=0.02, relwidth=0.273)

        self.TEntry1.configure(takefocus="")
        self.TEntry1.configure(cursor="xterm")

        self.TFrame1 = ttk.Frame(top)
        self.TFrame1.place(relx=0.05, rely=0.238, relheight=0.085
                , relwidth=0.208)
        self.TFrame1.configure(relief='groove')
        self.TFrame1.configure(borderwidth="2")
        self.TFrame1.configure(relief='groove')
        self.TFrame1.configure(width=125)

        self.TLabelframe1 = ttk.Labelframe(top)
        self.TLabelframe1.place(relx=0.05, rely=0.386, relheight=0.085
                , relwidth=0.25)
        self.TLabelframe1.configure(relief='')
        self.TLabelframe1.configure(text='''Tlabelframe''')
        self.TLabelframe1.configure(width=150)

        self.TProgressbar1 = ttk.Progressbar(top)
        self.TProgressbar1.place(relx=0.45, rely=0.636, relwidth=0.167
                , relheight=0.0, height=19)

        self.style.map('TRadiobutton',background=
            [('selected', _bgcolor), ('active', _ana2color)])
        self.TRadiobutton1 = ttk.Radiobutton(top)
        self.TRadiobutton1.place(relx=0.733, rely=0.636, relwidth=0.16
                , relheight=0.0, height=23)
        self.TRadiobutton1.configure(takefocus="")
        self.TRadiobutton1.configure(text='''TRadio''')

        self.TScale1 = ttk.Scale(top, from_=0, to=1.0)
        self.TScale1.place(relx=0.85, rely=0.409, relwidth=0.0, relheight=0.114
                , width=17, bordermode='ignore')
        self.TScale1.configure(orient="vertical")
        self.TScale1.configure(takefocus="")

        self.TScale2 = ttk.Scale(top, from_=0, to=1.0)
        self.TScale2.place(relx=0.45, rely=0.681, relwidth=0.167, relheight=0.0
                , height=17, bordermode='ignore')
        self.TScale2.configure(takefocus="")

        self.Scrolledlistbox1 = ScrolledListBox(top)
        self.Scrolledlistbox1.place(relx=0.05, rely=0.76, relheight=0.073
                , relwidth=0.193)
        self.Scrolledlistbox1.configure(background="white")
        self.Scrolledlistbox1.configure(disabledforeground="#b8a786")
        self.Scrolledlistbox1.configure(font=font11)
        self.Scrolledlistbox1.configure(highlightbackground="wheat")
        self.Scrolledlistbox1.configure(highlightcolor="wheat")
        self.Scrolledlistbox1.configure(selectbackground="#c4c4c4")
        self.Scrolledlistbox1.configure(width=10)

        self.Scrolledtext1 = ScrolledText(top)
        self.Scrolledtext1.place(relx=0.367, rely=0.76, relheight=0.082
                , relwidth=0.213)
        self.Scrolledtext1.configure(background="white")
        self.Scrolledtext1.configure(font=font10)
        self.Scrolledtext1.configure(highlightbackground="wheat")
        self.Scrolledtext1.configure(insertborderwidth="3")
        self.Scrolledtext1.configure(selectbackground="#c4c4c4")
        self.Scrolledtext1.configure(width=10)
        self.Scrolledtext1.configure(wrap='none')

        self.style.configure('TSizegrip', background=_bgcolor)
        self.TSizegrip1 = ttk.Sizegrip(top)
        self.TSizegrip1.place(anchor='se', relx=1.0, rely=1.0)

        self.TLabel1 = ttk.Label(top)
        self.TLabel1.place(relx=0.05, rely=0.341, height=16, width=37)
        self.TLabel1.configure(background="wheat")
        self.TLabel1.configure(foreground="#000000")
        self.TLabel1.configure(relief='flat')
        self.TLabel1.configure(text='''Tlabel''')

        self.style.configure('TNotebook.Tab', background=_bgcolor)
        self.style.configure('TNotebook.Tab', foreground=_fgcolor)
        self.style.map('TNotebook.Tab', background=
            [('selected', _compcolor), ('active',_ana2color)])
        self.TNotebook1 = ttk.Notebook(top)
        self.TNotebook1.place(relx=0.433, rely=0.045, relheight=0.262
                , relwidth=0.503)
        self.TNotebook1.configure(width=300)
        self.TNotebook1.configure(takefocus="")
        self.TNotebook1_t0 = tk.Frame(self.TNotebook1)
        self.TNotebook1.add(self.TNotebook1_t0, padding=3)
        self.TNotebook1.tab(0, text="Page 1",compound="none",underline="-1",)
        self.TNotebook1_t0.configure(background="wheat")
        self.TNotebook1_t0.configure(highlightbackground="wheat")
        self.TNotebook1_t1 = tk.Frame(self.TNotebook1)
        self.TNotebook1.add(self.TNotebook1_t1, padding=3)
        self.TNotebook1.tab(1, text="Page 2",compound="none",underline="-1",)
        self.TNotebook1_t1.configure(background="wheat")
        self.TNotebook1_t1.configure(highlightbackground="wheat")

        self.TPanedwindow2 = ttk.Panedwindow(top, orient="vertical")
        self.TPanedwindow2.place(relx=0.033, rely=0.488, relheight=0.227
                , relwidth=0.333)
        self.TPanedwindow2.configure(width=200)
        self.TPanedwindow2_p1 = ttk.Labelframe(height=75, text='Pane 1')
        self.TPanedwindow2.add(self.TPanedwindow2_p1)
        self.TPanedwindow2_p2 = ttk.Labelframe(text='Pane 2')
        self.TPanedwindow2.add(self.TPanedwindow2_p2)
        self.__funcid0 = self.TPanedwindow2.bind('<Map>', self.__adjust_sash0)

        self.TPanedwindow1 = ttk.Panedwindow(top, orient="horizontal")
        self.TPanedwindow1.place(relx=0.417, rely=0.341, relheight=0.227
                , relwidth=0.333)
        self.TPanedwindow1.configure(width=200)
        self.TPanedwindow1_p1 = ttk.Labelframe(width=75, text='Pane 1')
        self.TPanedwindow1.add(self.TPanedwindow1_p1)
        self.TPanedwindow1_p2 = ttk.Labelframe(text='Pane 2')
        self.TPanedwindow1.add(self.TPanedwindow1_p2)
        self.__funcid1 = self.TPanedwindow1.bind('<Map>', self.__adjust_sash1)

        self.TSeparator1 = ttk.Separator(top)
        self.TSeparator1.place(relx=0.883, rely=0.704, relheight=0.227)
        self.TSeparator1.configure(orient="vertical")

        self.TSeparator2 = ttk.Separator(top)
        self.TSeparator2.place(relx=0.533, rely=0.715, relwidth=0.333)

        self.style.configure('Treeview.Heading',  font=font9)
        self.Scrolledtreeview1 = ScrolledTreeView(top)
        self.Scrolledtreeview1.place(relx=0.133, rely=0.863, relheight=0.12
                , relwidth=0.7)
        self.Scrolledtreeview1.configure(columns="Col1")
        # build_treeview_support starting.
        self.Scrolledtreeview1.heading("#0",text="Tree")
        self.Scrolledtreeview1.heading("#0",anchor="center")
        self.Scrolledtreeview1.column("#0",width="203")
        self.Scrolledtreeview1.column("#0",minwidth="20")
        self.Scrolledtreeview1.column("#0",stretch="1")
        self.Scrolledtreeview1.column("#0",anchor="w")
        self.Scrolledtreeview1.heading("Col1",text="Col1")
        self.Scrolledtreeview1.heading("Col1",anchor="center")
        self.Scrolledtreeview1.column("Col1",width="203")
        self.Scrolledtreeview1.column("Col1",minwidth="20")
        self.Scrolledtreeview1.column("Col1",stretch="1")
        self.Scrolledtreeview1.column("Col1",anchor="w")

    def __adjust_sash0(self, event):
        paned = event.widget
        pos = [75, ]
        i = 0
        for sash in pos:
            paned.sashpos(i, sash)
            i += 1
        paned.unbind('<map>', self.__funcid0)
        del self.__funcid0

    def __adjust_sash1(self, event):
        paned = event.widget
        pos = [75, ]
        i = 0
        for sash in pos:
            paned.sashpos(i, sash)
            i += 1
        paned.unbind('<map>', self.__funcid1)
        del self.__funcid1

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

        #self.configure(yscrollcommand=_autoscroll(vsb),
        #    xscrollcommand=_autoscroll(hsb))
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

class ScrolledListBox(AutoScroll, tk.Listbox):
    '''A standard Tkinter Text widget with scrollbars that will
    automatically show/hide as needed.'''
    @_create_container
    def __init__(self, master, **kw):
        tk.Listbox.__init__(self, master, **kw)
        AutoScroll.__init__(self, master)

class ScrolledTreeView(AutoScroll, ttk.Treeview):
    '''A standard ttk Treeview widget with scrollbars that will
    automatically show/hide as needed.'''
    @_create_container
    def __init__(self, master, **kw):
        ttk.Treeview.__init__(self, master, **kw)
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





