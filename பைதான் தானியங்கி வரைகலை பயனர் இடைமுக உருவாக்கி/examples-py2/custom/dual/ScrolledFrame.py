import sys

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk


try:
    import ttk
    py3 = 0
except ImportError:
    import tkinter.ttk as ttk
    py3 = 1


# I found this code at http://tkinter.unpythonic.net/wiki/ScrolledFrame and
# just borrowed it for my photo album project. I make no claims for it.


class ScrolledFrame(tk.Frame):
    # XXX These could be options
    x_incr = 10
    y_incr = 10

    def __init__(self, root, *args, **kwargs):

        self.width = 200 # kw.pop('width', 200)
        self.height = 200 # kw.pop('height', 200)

        tk.Frame.__init__(self, root, *args, **kwargs)
        self.canvas = tk.Canvas(self)

        self._hsb = tk.Scrollbar(self, orient='horizontal',
                command=self.canvas.xview)
        self._vsb = tk.Scrollbar(self, orient='vertical',
                command=self.canvas.yview)
        self.canvas.configure(
                xscrollcommand=self._hsb.set,
                yscrollcommand=self._vsb.set)

        self.inner_frame = tk.Frame(self.canvas)

        self._hsb.pack(side="bottom", fill="x")
        self._vsb.pack(side="right", fill="y")
        self.canvas.pack(side="left", fill="both", expand=True)

        #self.window = self.canvas.create_window((0, 0), anchor='nw',
        #                                        window=self.inner_frame)
        self.canvas.create_window((0, 0), anchor='nw',
                                  window=self.inner_frame)
        self.inner_frame.bind('<Configure>', self._prepare_scroll)
        self.inner_frame.bind('<Map>', self._prepare_scroll)
        for widget in (self.inner_frame, self.canvas):
            widget.bind('<Button-4>', self.scroll_up)
            widget.bind('<Button-5>', self.scroll_down)

    def on_frame_configure(self, event):
        """Reset the scroll region to encompass the inner frame"""
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))

    def window_width(self):
        ''' Returns the width of the scrolled window.'''
        return self.canvas.winfo_width()

    def window_height(self):
        ''' Returns the height of scrolled window.'''
        return self._canvas.winfo_height()

    def forget_H_bar(self):
        ''' Remove the scroll_bar.'''
        self._hsb.pack_forget()

    def remember_H_bar(self):
        self._canvas.pack_forget()
        self._hsb.pack(side='bottom', fill='x')
        self._canvas.create_window(0, 0, anchor='nw', window=self._placeholder)
        self._canvas.pack()

    def remove_V_bar(self):
        ''' Remove the scroll_bar.'''
        self._vsb.pack_forget()


    def yscroll(self, *args):
        self.canvas.yview_scroll(*args)


    def scroll_up(self, event=None):
        self.yscroll(-self.y_incr, 'units')


    def scroll_down(self, event=None):
        self.yscroll(self.y_incr, 'units')

    def see(self, event):
        widget = event.widget
        w_height = widget.winfo_reqheight()
        c_height = self.canvas.winfo_height()
        y_pos = widget.winfo_rooty()

        if (y_pos - w_height) < 0:
            # Widget focused is above the current view
            while (y_pos - w_height) < self.y_incr:
                self.scroll_up()
                self.canvas.update_idletasks()
                y_pos = widget.winfo_rooty()
        elif (y_pos - w_height) > c_height:
            # Widget focused is below the current view
            while (y_pos - w_height - self.y_incr) > c_height:
                self.scroll_down()
                self.canvas.update_idletasks()
                y_pos = widget.winfo_rooty()

    def _prepare_scroll(self, event):
        frame = self.inner_frame
        frame.unbind('<Map>')
        frame.bind

        if not frame.children:
            # Nothing to scroll.
            return

        for child in frame.children.itervalues():
            #child.bind('<FocusIn>', self.see)    # Don't understand this line.
            child.bind('<Button-4>', self.scroll_up)
            child.bind('<Button-5>', self.scroll_down)

        new_width, new_height = frame.winfo_reqwidth(), frame.winfo_reqheight()
        self.canvas.configure(scrollregion=(0, 0, new_width, new_height),
                yscrollincrement=self.y_incr, xscrollincrement=self.x_incr)

        self.canvas.configure(width=self.width, height=self.height)
