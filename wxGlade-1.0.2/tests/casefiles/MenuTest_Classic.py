#!/usr/bin/env python
# -*- coding: UTF-8 -*-
#
# generated by wxGlade
#

import wx

# begin wxGlade: dependencies
# end wxGlade

# begin wxGlade: extracode
# end wxGlade


class MenuTestFrame(wx.Frame):
    def __init__(self, *args, **kwds):
        # begin wxGlade: MenuTestFrame.__init__
        kwds["style"] = kwds.get("style", 0) | wx.DEFAULT_FRAME_STYLE
        wx.Frame.__init__(self, *args, **kwds)
        self.SetSize((800, 417))
        self.SetTitle("All Widgets")
        _icon = wx.NullIcon
        _icon.CopyFromBitmap(wx.ArtProvider.GetBitmap(wx.ART_TIP, wx.ART_OTHER, (32, 32)))
        self.SetIcon(_icon)

        # Menu Bar
        self.test_menubar = wx.MenuBar()
        global mn_ID1; mn_ID1 = wx.NewId()
        global mn_ID2; mn_ID2 = wx.NewId()
        global mn_ID3; mn_ID3 = wx.NewId()
        global mn_ID4; mn_ID4 = wx.NewId()
        global mn_ID1C; mn_ID1C = wx.NewId()
        global mn_ID2C; mn_ID2C = wx.NewId()
        global mn_ID3C; mn_ID3C = wx.NewId()
        global mn_ID4C; mn_ID4C = wx.NewId()
        global mn_ID1R; mn_ID1R = wx.NewId()
        global mn_ID2R; mn_ID2R = wx.NewId()
        global mn_ID3R; mn_ID3R = wx.NewId()
        global mn_ID4R; mn_ID4R = wx.NewId()
        wxglade_tmp_menu = wx.Menu()
        wxglade_tmp_menu.Append(wx.ID_OPEN, "&Open", "Stock ID")
        wxglade_tmp_menu.Append(wx.ID_HELP, "Manual", "Stock ID, handler")
        self.Bind(wx.EVT_MENU, self.onShowManual, id=wx.ID_HELP)
        self.test_menubar.m_Close = wxglade_tmp_menu.Append(wx.ID_CLOSE, "&Close file", "Stock ID, name, handler")
        self.Bind(wx.EVT_MENU, self.onCloseFile, id=wx.ID_CLOSE)
        self.test_menubar.m_Exit = wxglade_tmp_menu.Append(wx.ID_EXIT, "E&xit", "Stock ID, name")
        wxglade_tmp_menu.AppendSeparator()
        wxglade_tmp_menu.Append(wx.ID_OPEN, "&Open", "Stock ID", wx.ITEM_CHECK)
        wxglade_tmp_menu.Append(wx.ID_HELP, "Manual", "Stock ID, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.onShowManual, id=wx.ID_HELP)
        self.test_menubar.m_Close = wxglade_tmp_menu.Append(wx.ID_CLOSE, "&Close file", "Stock ID, name, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.onCloseFile, id=wx.ID_CLOSE)
        self.test_menubar.m_Exit = wxglade_tmp_menu.Append(wx.ID_EXIT, "E&xit", "Stock ID, name", wx.ITEM_CHECK)
        wxglade_tmp_menu_sub = wx.Menu()
        wxglade_tmp_menu_sub.Append(wx.ID_OPEN, "&Open", "Stock ID", wx.ITEM_RADIO)
        wxglade_tmp_menu_sub.Append(wx.ID_HELP, "Manual", "Stock ID, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.onShowManual, id=wx.ID_HELP)
        self.test_menubar.m_Close = wxglade_tmp_menu_sub.Append(wx.ID_CLOSE, "&Close file", "Stock ID, name, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.onCloseFile, id=wx.ID_CLOSE)
        self.test_menubar.m_Exit = wxglade_tmp_menu_sub.Append(wx.ID_EXIT, "E&xit", "Stock ID, name", wx.ITEM_RADIO)
        wxglade_tmp_menu.AppendMenu(wx.ID_ANY, "Radio", wxglade_tmp_menu_sub, "")
        self.test_menubar.Append(wxglade_tmp_menu, "&Stock IDs")
        wxglade_tmp_menu = wx.Menu()
        wxglade_tmp_menu.Append(mn_ID1, "Named 1", "Named ID")
        wxglade_tmp_menu.Append(mn_ID2, "Named 2", "Named ID, handler")
        self.Bind(wx.EVT_MENU, self.on_named2, id=mn_ID2)
        self.test_menubar.m_named = wxglade_tmp_menu.Append(mn_ID3, "Named 3", "Named ID, name, handler")
        self.Bind(wx.EVT_MENU, self.on_named3, id=mn_ID3)
        self.test_menubar.m_named4 = wxglade_tmp_menu.Append(mn_ID4, "Named 4", "Named ID, name")
        wxglade_tmp_menu.AppendSeparator()
        wxglade_tmp_menu.Append(mn_ID1C, "Named 1", "Named ID", wx.ITEM_CHECK)
        wxglade_tmp_menu.Append(mn_ID2C, "Named 2", "Named ID, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.on_named2, id=mn_ID2C)
        self.test_menubar.m_named3C = wxglade_tmp_menu.Append(mn_ID3C, "Named 3", "Named ID, name, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.on_named3, id=mn_ID3C)
        self.test_menubar.m_named4C = wxglade_tmp_menu.Append(mn_ID4C, "Named 4", "Named ID, name", wx.ITEM_CHECK)
        wxglade_tmp_menu_sub = wx.Menu()
        wxglade_tmp_menu_sub.Append(mn_ID1R, "Named 1", "Named ID", wx.ITEM_RADIO)
        wxglade_tmp_menu_sub.Append(mn_ID2R, "Named 2", "Named ID, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.on_named2, id=mn_ID2R)
        self.test_menubar.m_named3R = wxglade_tmp_menu_sub.Append(mn_ID3R, "Named 3", "Named ID, name, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.on_named3, id=mn_ID3R)
        self.test_menubar.m_named4R = wxglade_tmp_menu_sub.Append(mn_ID4R, "Named 4", "Named ID, name", wx.ITEM_RADIO)
        wxglade_tmp_menu.AppendMenu(wx.ID_ANY, "Radio", wxglade_tmp_menu_sub, "")
        self.test_menubar.Append(wxglade_tmp_menu, "&Named ID")
        wxglade_tmp_menu = wx.Menu()
        wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 1", "Auto ID")
        item = wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 2", "Auto ID, handler")
        self.Bind(wx.EVT_MENU, self.on_auto2, item)
        self.test_menubar.m_auto3 = wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 3", "Auto ID, name, handler")
        self.Bind(wx.EVT_MENU, self.on_auto3, self.test_menubar.m_auto3)
        self.test_menubar.m_auto4 = wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 4", "Auto ID, name")
        wxglade_tmp_menu.AppendSeparator()
        wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 1", "Auto ID", wx.ITEM_CHECK)
        item = wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 2", "Auto ID, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.on_auto2, item)
        self.test_menubar.m_auto3C = wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 3", "Auto ID, name, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.on_auto3, self.test_menubar.m_auto3C)
        self.test_menubar.m_auto4C = wxglade_tmp_menu.Append(wx.ID_ANY, "Auto 4", "Auto ID, name", wx.ITEM_CHECK)
        wxglade_tmp_menu_sub = wx.Menu()
        wxglade_tmp_menu_sub.Append(wx.ID_ANY, "Auto 1", "Auto ID", wx.ITEM_RADIO)
        item = wxglade_tmp_menu_sub.Append(wx.ID_ANY, "Auto 2", "Auto ID, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.on_auto2, item)
        self.test_menubar.m_auto3R = wxglade_tmp_menu_sub.Append(wx.ID_ANY, "Auto 3", "Auto ID, name, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.on_auto3, self.test_menubar.m_auto3R)
        self.test_menubar.m_auto4R = wxglade_tmp_menu_sub.Append(wx.ID_ANY, "Auto 4", "Auto ID, name", wx.ITEM_RADIO)
        wxglade_tmp_menu.AppendMenu(wx.ID_ANY, "Radio", wxglade_tmp_menu_sub, "")
        self.test_menubar.Append(wxglade_tmp_menu, "&Auto ID")
        wxglade_tmp_menu = wx.Menu()
        wxglade_tmp_menu.Append(wx.NewId(), "Minus1 1", "Minus1 ID")
        item = wxglade_tmp_menu.Append(wx.NewId(), "Minus1 2", "Minus1 ID, handler")
        self.Bind(wx.EVT_MENU, self.on_Minus12, item)
        self.test_menubar.m_Minus13 = wxglade_tmp_menu.Append(wx.NewId(), "Minus1 3", "Minus1 ID, name, handler")
        self.Bind(wx.EVT_MENU, self.on_Minus13, self.test_menubar.m_Minus13)
        self.test_menubar.m_Minus14 = wxglade_tmp_menu.Append(wx.NewId(), "Minus1 4", "Minus1 ID, name")
        wxglade_tmp_menu.AppendSeparator()
        wxglade_tmp_menu.Append(wx.NewId(), "Minus1 1", "Minus1 ID", wx.ITEM_CHECK)
        item = wxglade_tmp_menu.Append(wx.NewId(), "Minus1 2", "Minus1 ID, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.on_Minus12, item)
        self.test_menubar.m_Minus13C = wxglade_tmp_menu.Append(wx.NewId(), "Minus1 3", "Minus1 ID, name, handler", wx.ITEM_CHECK)
        self.Bind(wx.EVT_MENU, self.on_Minus13, self.test_menubar.m_Minus13C)
        self.test_menubar.m_Minus14C = wxglade_tmp_menu.Append(wx.NewId(), "Minus1 4", "Minus1 ID, name", wx.ITEM_CHECK)
        wxglade_tmp_menu_sub = wx.Menu()
        wxglade_tmp_menu_sub.Append(wx.NewId(), "Minus1 1", "Minus1 ID", wx.ITEM_RADIO)
        item = wxglade_tmp_menu_sub.Append(wx.NewId(), "Minus1 2", "Minus1 ID, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.on_Minus12, item)
        self.test_menubar.m_Minus13R = wxglade_tmp_menu_sub.Append(wx.NewId(), "Minus1 3", "Minus1 ID, name, handler", wx.ITEM_RADIO)
        self.Bind(wx.EVT_MENU, self.on_Minus13, self.test_menubar.m_Minus13R)
        self.test_menubar.m_Minus14R = wxglade_tmp_menu_sub.Append(wx.NewId(), "Minus1 4", "Minus1 ID, name", wx.ITEM_RADIO)
        wxglade_tmp_menu.AppendMenu(wx.ID_ANY, "Radio", wxglade_tmp_menu_sub, "")
        self.test_menubar.Append(wxglade_tmp_menu, "&Minus1 ID")
        self.SetMenuBar(self.test_menubar)
        # Menu Bar end
        self.Layout()
        self.Centre()

        # end wxGlade

    def onShowManual(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'onShowManual' not implemented!")
        event.Skip()

    def onCloseFile(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'onCloseFile' not implemented!")
        event.Skip()

    def on_named2(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'on_named2' not implemented!")
        event.Skip()

    def on_named3(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'on_named3' not implemented!")
        event.Skip()

    def on_auto2(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'on_auto2' not implemented!")
        event.Skip()

    def on_auto3(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'on_auto3' not implemented!")
        event.Skip()

    def on_Minus12(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'on_Minus12' not implemented!")
        event.Skip()

    def on_Minus13(self, event):  # wxGlade: MenuTestFrame.<event_handler>
        print("Event handler 'on_Minus13' not implemented!")
        event.Skip()

# end of class MenuTestFrame

class MenuTestClass(wx.App):
    def OnInit(self):
        self.MenuTest = MenuTestFrame(None, wx.ID_ANY, "")
        self.SetTopWindow(self.MenuTest)
        self.MenuTest.Show()
        return True

# end of class MenuTestClass

if __name__ == "__main__":
    MenuTest = MenuTestClass(0)
    MenuTest.MainLoop()
