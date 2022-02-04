#!/usr/bin/env python
# -*- coding: ISO-8859-1 -*-
#
# generated by wxGlade 88adbe54429d+ on Sat Feb  6 22:56:43 2016
#

import wx

# begin wxGlade: dependencies
import gettext
# end wxGlade

# begin wxGlade: extracode
try:
    ID_EDIT = wx.ID_EDIT
except AttributeError:
    ID_EDIT = wx.NewId()
# end wxGlade


class TemplateInfoDialog(wx.Dialog):
    def __init__(self, *args, **kwds):
        # begin wxGlade: TemplateInfoDialog.__init__
        kwds["style"] = wx.DEFAULT_DIALOG_STYLE | wx.MAXIMIZE_BOX | wx.RESIZE_BORDER
        wx.Dialog.__init__(self, *args, **kwds)
        self.template_name = wx.TextCtrl(self, wx.ID_ANY, "")
        self.author = wx.TextCtrl(self, wx.ID_ANY, "")
        self.description = wx.TextCtrl(self, wx.ID_ANY, "", style=wx.TE_MULTILINE)
        self.instructions = wx.TextCtrl(self, wx.ID_ANY, "", style=wx.TE_MULTILINE)
        self.button_1 = wx.Button(self, wx.ID_OK, "")
        self.button_2 = wx.Button(self, wx.ID_CANCEL, "")

        self.__set_properties()
        self.__do_layout()
        # end wxGlade

    def __set_properties(self):
        # begin wxGlade: TemplateInfoDialog.__set_properties
        self.SetTitle(_("wxGlade template information"))
        self.SetSize( (350, 400) )
        self.template_name.SetFocus()
        # end wxGlade

    def __do_layout(self):
        # begin wxGlade: TemplateInfoDialog.__do_layout
        sizer_1 = wx.BoxSizer(wx.VERTICAL)
        sizer_6 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_5 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Instructions")), wx.HORIZONTAL)
        sizer_4 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Description")), wx.HORIZONTAL)
        sizer_3 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Author")), wx.HORIZONTAL)
        sizer_2 = wx.BoxSizer(wx.HORIZONTAL)
        label_template_name = wx.StaticText(self, wx.ID_ANY, _("wxGlade template: "))
        label_template_name.SetFont(wx.Font(-1, wx.DEFAULT, wx.NORMAL, wx.BOLD, 0, ""))
        sizer_2.Add(label_template_name, 0, wx.ALIGN_CENTER_VERTICAL | wx.ALL, 10)
        sizer_2.Add(self.template_name, 1, wx.ALIGN_CENTER_VERTICAL | wx.ALL, 10)
        sizer_1.Add(sizer_2, 0, wx.EXPAND, 0)
        sizer_3.Add(self.author, 1, 0, 0)
        sizer_1.Add(sizer_3, 0, wx.ALL | wx.EXPAND, 5)
        sizer_4.Add(self.description, 1, wx.EXPAND, 0)
        sizer_1.Add(sizer_4, 1, wx.ALL | wx.EXPAND, 5)
        sizer_5.Add(self.instructions, 1, wx.EXPAND, 0)
        sizer_1.Add(sizer_5, 1, wx.ALL | wx.EXPAND, 5)
        sizer_6.Add(self.button_1, 0, 0, 0)
        sizer_6.Add(self.button_2, 0, wx.LEFT, 10)
        sizer_1.Add(sizer_6, 0, wx.ALIGN_RIGHT | wx.ALL, 10)
        self.SetSizer(sizer_1)
        self.Layout()
        self.Centre()
        # end wxGlade

# end of class TemplateInfoDialog

class TemplateListDialog(wx.Dialog):
    def __init__(self, *args, **kwds):
        # begin wxGlade: TemplateListDialog.__init__
        kwds["style"] = wx.DEFAULT_DIALOG_STYLE
        wx.Dialog.__init__(self, *args, **kwds)
        self.template_names = wx.ListBox(self, wx.ID_ANY, choices=[])
        self.template_name = wx.StaticText(self, wx.ID_ANY, _("wxGlade template:\n"))
        self.author = wx.TextCtrl(self, wx.ID_ANY, "", style=wx.TE_READONLY)
        self.description = wx.TextCtrl(self, wx.ID_ANY, "", style=wx.TE_MULTILINE | wx.TE_READONLY)
        self.instructions = wx.TextCtrl(self, wx.ID_ANY, "", style=wx.TE_MULTILINE | wx.TE_READONLY)
        self.btn_open = wx.Button(self, wx.ID_OPEN, "")
        self.btn_edit = wx.Button(self, ID_EDIT, _("&Edit"))
        self.btn_delete = wx.Button(self, wx.ID_DELETE, "")
        self.btn_cancel = wx.Button(self, wx.ID_CANCEL, "")

        self.__set_properties()
        self.__do_layout()

        self.Bind(wx.EVT_LISTBOX_DCLICK, self.on_open, self.template_names)
        self.Bind(wx.EVT_LISTBOX, self.on_select_template, self.template_names)
        self.Bind(wx.EVT_BUTTON, self.on_open, self.btn_open)
        self.Bind(wx.EVT_BUTTON, self.on_edit, id=ID_EDIT)
        self.Bind(wx.EVT_BUTTON, self.on_delete, self.btn_delete)
        # end wxGlade

    def __set_properties(self):
        # begin wxGlade: TemplateListDialog.__set_properties
        self.SetTitle(_("wxGlade template list"))
        self.SetSize( (600, 400) )
        self.template_name.SetFont(wx.Font(-1, wx.DEFAULT, wx.NORMAL, wx.BOLD, 0, ""))
        # end wxGlade

    def __do_layout(self):
        # begin wxGlade: TemplateListDialog.__do_layout
        sizer_1 = wx.BoxSizer(wx.VERTICAL)
        sizer_8 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_2 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_4 = wx.BoxSizer(wx.VERTICAL)
        sizer_7 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Instructions")), wx.HORIZONTAL)
        sizer_6 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Description")), wx.HORIZONTAL)
        sizer_5 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Author")), wx.HORIZONTAL)
        sizer_3 = wx.StaticBoxSizer(wx.StaticBox(self, wx.ID_ANY, _("Available templates")), wx.VERTICAL)
        sizer_3.Add(self.template_names, 1, wx.ALL | wx.EXPAND, 3)
        sizer_2.Add(sizer_3, 1, wx.ALL | wx.EXPAND, 5)
        sizer_4.Add(self.template_name, 0, wx.ALL, 7)
        sizer_5.Add(self.author, 1, 0, 0)
        sizer_4.Add(sizer_5, 0, wx.ALL | wx.EXPAND, 5)
        sizer_6.Add(self.description, 1, wx.EXPAND, 0)
        sizer_4.Add(sizer_6, 1, wx.ALL | wx.EXPAND, 5)
        sizer_7.Add(self.instructions, 1, wx.EXPAND, 0)
        sizer_4.Add(sizer_7, 1, wx.ALL | wx.EXPAND, 5)
        sizer_2.Add(sizer_4, 2, wx.EXPAND, 0)
        sizer_1.Add(sizer_2, 1, wx.EXPAND, 0)
        sizer_8.Add(self.btn_open, 0, 0, 0)
        sizer_8.Add(self.btn_edit, 0, wx.LEFT, 10)
        sizer_8.Add(self.btn_delete, 0, wx.LEFT, 10)
        sizer_8.Add(self.btn_cancel, 0, wx.LEFT, 10)
        sizer_1.Add(sizer_8, 0, wx.ALIGN_RIGHT | wx.ALL, 10)
        self.SetSizer(sizer_1)
        self.Layout()
        self.Centre()
        # end wxGlade

    def on_open(self, event):  # wxGlade: TemplateListDialog.<event_handler>
        print("Event handler 'on_open' not implemented!")
        event.Skip()

    def on_select_template(self, event):  # wxGlade: TemplateListDialog.<event_handler>
        print("Event handler 'on_select_template' not implemented!")
        event.Skip()

    def on_edit(self, event):  # wxGlade: TemplateListDialog.<event_handler>
        print("Event handler 'on_edit' not implemented!")
        event.Skip()

    def on_delete(self, event):  # wxGlade: TemplateListDialog.<event_handler>
        print("Event handler 'on_delete' not implemented!")
        event.Skip()

# end of class TemplateListDialog
