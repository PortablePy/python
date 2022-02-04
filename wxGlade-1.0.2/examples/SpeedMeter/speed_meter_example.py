#!/usr/bin/env python
# -*- coding: UTF-8 -*-
#
# generated by wxGlade 0.8.0a9 on Mon Nov 20 23:05:27 2017
#

import wx

# begin wxGlade: dependencies
# end wxGlade

# begin wxGlade: extracode
import wx.lib.agw.speedmeter as SM

# import these on module level to use them in the Extra Properties
from math import pi, sqrt
# end wxGlade


class MyFrame(wx.Frame):
    def __init__(self, *args, **kwds):
        # begin wxGlade: MyFrame.__init__
        kwds["style"] = kwds.get("style", 0) | wx.DEFAULT_FRAME_STYLE
        wx.Frame.__init__(self, *args, **kwds)
        self.SetSize((400, 349))
        self.SetTitle("wx.lib.agw.speedmeter example")
        
        sizer_1 = wx.BoxSizer(wx.VERTICAL)
        
        self.panel_1 = wx.Panel(self, wx.ID_ANY)
        sizer_1.Add(self.panel_1, 1, wx.EXPAND, 0)
        
        sizer_2 = wx.BoxSizer(wx.VERTICAL)
        
        #################################################################
        # the custom widget SpeedMeter:
        # we use the following styles:
        # SM_DRAW_HAND: We Want To Draw The Hand (Arrow) Indicator
        # SM_DRAW_SECTORS: Full Sectors Will Be Drawn, To Indicate Different Intervals
        # SM_DRAW_MIDDLE_TEXT: We Draw Some Text In The Center Of SpeedMeter
        # SM_DRAW_SECONDARY_TICKS: We Draw Secondary (Intermediate) Ticks Between the Main Ticks (Intervals)
        self.speed_meter = SM.SpeedMeter(self.panel_1, wx.ID_ANY, agwStyle=SM.SM_DRAW_HAND | SM.SM_DRAW_SECTORS | SM.SM_DRAW_MIDDLE_TEXT | SM.SM_DRAW_SECONDARY_TICKS)
        # see also extra properties
        
        intervals = list(range(0, 201, 20))
        self.speed_meter.SetIntervals(intervals)
        
        self.speed_meter.SetIntervalColours([wx.BLACK]*10)
        
        # Assign The Ticks: Here They Are Simply The String Equivalent Of The Intervals
        ticks = [str(interval) for interval in intervals]
        self.speed_meter.SetTicks(ticks)
        
        # Do Not Draw The External (Container) Arc.
        # Drawing The External Arc May Sometimes Create Uglier Controls.
        # Try To Comment This Line And See It For Yourself!
        self.speed_meter.DrawExternalArc(False)
        #################################################################
        self.speed_meter.SetAngleRange(-pi/6, 7*pi/6)
        self.speed_meter.SetHandColour(wx.Colour(255, 50, 0))
        self.speed_meter.SetIntervalColours([wx.BLACK]*10)
        self.speed_meter.SetMiddleText("Km/h")
        self.speed_meter.SetMiddleTextColour(wx.WHITE)
        self.speed_meter.SetMiddleTextFont(wx.Font(8, wx.FONTFAMILY_SWISS, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD))
        self.speed_meter.SetSpeedValue(44)
        self.speed_meter.SetTicksColour(wx.WHITE)
        self.speed_meter.SetTicksFont(wx.Font(10, wx.FONTFAMILY_SWISS, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL))
        sizer_2.Add(self.speed_meter, 1, wx.ALL | wx.EXPAND, 3)
        
        sizer_3 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_2.Add(sizer_3, 0, wx.EXPAND, 0)
        
        label_1 = wx.StaticText(self.panel_1, wx.ID_ANY, "Drag this:")
        sizer_3.Add(label_1, 0, wx.ALIGN_CENTER_VERTICAL, 0)
        
        self.slider_1 = wx.Slider(self.panel_1, wx.ID_ANY, 44, 0, 200)
        sizer_3.Add(self.slider_1, 1, wx.EXPAND, 0)
        
        self.panel_1.SetSizer(sizer_2)
        
        self.SetSizer(sizer_1)
        
        self.Layout()

        self.Bind(wx.EVT_COMMAND_SCROLL, lambda event: self.speed_meter.SetSpeedValue(event.GetEventObject().GetValue()), self.slider_1)
        # end wxGlade

# end of class MyFrame

class MyApp(wx.App):
    def OnInit(self):
        self.frame = MyFrame(None, wx.ID_ANY, "")
        self.SetTopWindow(self.frame)
        self.frame.Show()
        return True

# end of class MyApp

if __name__ == "__main__":
    app = MyApp(0)
    app.MainLoop()
