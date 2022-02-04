# -*- coding: ISO-8859-1 -*-
#
# generated by wxGlade
#

import wx

# begin wxGlade: dependencies
# end wxGlade

# begin wxGlade: extracode
import my_panel
# end wxGlade


class MyDialog(wx.Dialog):
    def __init__(self, *args, **kwds):
        # begin wxGlade: MyDialog.__init__
        kwds["style"] = kwds.get("style", 0) | wx.DEFAULT_DIALOG_STYLE
        wx.Dialog.__init__(self, *args, **kwds)
        self.SetTitle("dialog")

        main_sizer = wx.BoxSizer(wx.VERTICAL)

        self.panel_1 = my_panel.MyPanel(self, wx.ID_ANY)
        main_sizer.Add(self.panel_1, 1, wx.EXPAND, 0)

        self.SetSizer(main_sizer)
        main_sizer.Fit(self)

        self.Layout()
        # end wxGlade

# end of class MyDialog
