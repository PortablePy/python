##############################################################################
# $Id: globals.tcl,v 1.42 2003/05/14 06:10:19 cgavin Exp $
#
# globals.tcl - global variables
#
# Copyright (C) 1996-1998 Stewart Allen
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

##############################################################################
#

# bind record format:
# { {bindtag} {bind list record} }  ...

# bind list record format: # { {event} {command} } ...

# option list record format:
# { {name} {value} } ...
# widget manager record format:
# {type} {option list} {manager specific list}

global vTcl
namespace eval ::vTcl::balloon {}

set vTcl(running)        1
set vTcl(rework)         1
set vTcl(borrow)         0
set vTcl(action)         ""
set vTcl(action_index)   -1
set vTcl(action_limit)   -1
set ::vTcl::balloon::first  0
set ::vTcl::balloon::set    0
set ::vTcl::balloon::soon   0
# autosave stuff must be in the order below
set vTcl(autosave_time)  [clock seconds]
set vTcl(project,file)   ""
set vTcl(autosave_skip)  1
set vTcl(change)         0
set vTcl(autosave_skip)  0
set vTcl(initial_open)   0
set vTcl(bind,ignore)    ""
set vTcl(gui_change_time)    0    ;# Rozen. Time when GUI changed, milliseconds.
set vTcl(gui_py_change_time) 0    ;# Rozen. Time when GUI py module changed, ms.
set vTcl(copy)           0    ;# Rozen turns on when user hits copy. Off after.
set vTcl(paste)          0    ;# See above vTcl(copy).
set vTcl(redo)           0
set vTcl(console)        0
set vTcl(cursor,last)    ""
#set vTcl(procs)          "init main"
set vTcl(procs)          ""   ;# Rozen   Don't know why I commented this out
set vTcl(state)      "normal"
set vTcl(file,base)      [pwd]
set vTcl(file,mode)      ""
set vTcl(file,type)      "*.tcl"
set vTcl(mouse,X)    0
set vTcl(mouse,Y)    0
set vTcl(mouse,x)    0
set vTcl(mouse,y)    0
set vTcl(paste,x)    0
set vTcl(paste,y)    0
set vTcl(grid,x)         10   ;#  User to snap widget placement to
                               #  grid lines. Rozen comment
set vTcl(grid,y)         10   ;#  Same as above. Rozen
set vTcl(ide_cmd)        ""
set vTcl(max_bak)    2
set vTcl(python_cmd)        "python3"
set vTcl(gui,main)       ".vTcl"
set vTcl(gui,tool)       "$vTcl(gui,main).toolbar"
set vTcl(gui,ae)         "$vTcl(gui,main).ae"
set vTcl(gui,command)    "$vTcl(gui,main).comm"
set vTcl(gui,gui_console)    "$vTcl(gui,main).gui_console"
set vTcl(gui,supp_console)    "$vTcl(gui,main).supp_console"
set vTcl(gui,proc)       "$vTcl(gui,main).proc"
set vTcl(gui,proclist)   "$vTcl(gui,main).proclist"
set vTcl(gui,toplist)    "$vTcl(gui,main).toplist"
set vTcl(gui,mgr)        "$vTcl(gui,main).mgr"
set vTcl(gui,prefs)      "$vTcl(gui,main).prefs"
set vTcl(gui,rc_menu)    "$vTcl(gui,main).rc"
set vTcl(gui,varlist)    "$vTcl(gui,main).varlist"
set vTcl(gui,statbar)    "$vTcl(gui,main).stat.f.bar"
set vTcl(gui,callback)   "$vTcl(gui,main).callback"
set vTcl(gui,apply)      "$vTcl(gui,main).apply"
set vTcl(gui,tree)       "$vTcl(gui,main).tree"
set vTcl(gui,newtag)       "$vTcl(gui,main).newtag"
set vTcl(gui,newbind)       "$vTcl(gui,main).newbind"
set vTcl(gui,showlist)   ".vTcl.toolbar .vTcl.ae .vTcl.tree"

# set vTcl(containers)     [list Toplevel Frame Labelframe TFrame TLabelframe]
set vTcl(containers)     [list Toplevel Frame Labelframe TFrame TLabelframe Canvas]
set vTcl(tree_containers)     [list Toplevel Frame Labelframe TFrame TLabelframe Canvas TNoteboob PNotebook TPanedwindow]
set vTcl(h,exist)        0
set vTcl(h,size)         3
set vTcl(h,size)         5
set vTcl(hide)           ""
set vTcl(item_num)       1
set vTcl(toplevel_num)   0
set vTcl(key,x)          1
set vTcl(key,y)          1
set vTcl(key,w)          1
set vTcl(key,h)          1
set vTcl(mgrs,update)    yes
# preferences
set vTcl(pr,attr_on)     1
set vTcl(pr,balloon)     1         ;# Rozen
set vTcl(pr,encase)      list
set vTcl(pr,font_dft)           TkDefaultFont
set vTcl(pr,gui_font_dft)       TkDefaultFont   ;# Rozen
set vTcl(pr,font_fixed)         TkFixedFont
set vTcl(pr,gui_font_text)      TkTextFont     ;# Rozen
set vTcl(pr,gui_font_fixed)     TkFixedFont
set vTcl(pr,gui_font_menu)      TkMenuFont      ;# Rozen
set vTcl(pr,gui_font_tooltip)   TkDefaultFont      ;# Rozen
set vTcl(pr,gui_font_treeview)  TkDefaultFont      ;# Rozen
set vTcl(pr,getname)     0
#set vTcl(pr,getname)     1         ;# Rozen TEMP NEEDS WORK   6/11/11
set vTcl(pr,geom_on)     1
set vTcl(pr,geom_comm)   "350x200"
set vTcl(pr,geom_proc)   "500x400"
#set vTcl(pr,geom_vTcl)   "565x110"
set vTcl(pr,geom_vTcl)   "700x50"  ;# Rozen
set vTcl(pr,geom_new)    "600x450+650+150"
#set vTcl(pr,geom_new)    "600x450" ;# Rozen
set vTcl(skip_save_prefs) 0

#Code block below attemps to put the new toplevel window in the center.
set toplevel_width 600 ;    set toplevel_height 450
# set x_1 [ expr {([ winfo vrootwidth  . ] - $toplevel_width ) / 2 }]
# set y_1 [ expr {([ winfo vrootheight . ] - $toplevel_height ) / 3 }]
set x_1 [ expr {([ winfo screenwidth  . ] - $toplevel_width ) / 2 }]
set y_1 [ expr {([ winfo screenheight . ] - $toplevel_height ) / 3 }]
set vTcl(geom_center) ${toplevel_width}x${toplevel_height}+$x_1+$y_1
#set vTcl(geom_center) ${toplevel_width}x${toplevel_height}
set vTcl(default_coordinates) "+$x_1+$y_1"

set vTcl(pr,relative_placement) 1
set vTcl(pr,default_origin) 0
set vTcl(pr,check_identifiers) 0
set vTcl(pr,info_on)     1
set vTcl(pr,manager)     place
set vTcl(pr,shortname)   1
set vTcl(pr,saveglob)    0
set vTcl(pr,custom_sizes) ""       ;# Rozen
set vTcl(pr,show_func)   1
set vTcl(pr,show_func)   0         ;# Rozen
set vTcl(pr,show_var)    -1
set vTcl(pr,show_top)    -1
set vTcl(pr,winfocus)    0
set vTcl(pr,autoplace)   0
set vTcl(pr,autoalias)   1
set vTcl(pr,multiplace)  0
set vTcl(pr,cmdalias)    1
set vTcl(pr,fullcfg)     0
set vTcl(pr,autoloadcomp) 0
set vTcl(pr,autoloadcompfile) ""
set vTcl(pr,projecttype) "single"
set vTcl(pr,imageeditor) ""
set vTcl(pr,saveimagesinline) 0
set vTcl(pr,projfile)    0
set vTcl(pr,saveasexecutable) 0    ;# Rozen
set vTcl(pr,dontshowtips) 0
set vTcl(pr,dontshownews) 1
#set vTcl(pr,bgcolor) ""
#set vTcl(tk_default_bgcolor) [. cget -background]   ;# Rozen
#puts "globals.tcl: spot1: vTcl(tk_default_bgcolor) = $vTcl(tk_default_bgcolor)"
#if {$vTcl(tk_default_bgcolor) == ""} {
#    set vTcl(tk_default_bgcolor) "#d9d9d9"
#}
;#jg
#set vTcl(pr,bgcolor) "#d9d9d9"

# Color redo started March 2022.

# There will be only the following vTcl(pr,.*color) entries in the rc
# files.

set vTcl(default_bg_color)   "#d9d9d9"
set vTcl(default_fg_color)   "#000000"

set vTcl(pr,page_bg_color)   $vTcl(default_bg_color)
set vTcl(pr,page_fg_color)   $vTcl(default_fg_color)
set vTcl(pr,gui_bg_color)    $vTcl(default_bg_color)
# set vTcl(pr,gui_comp_color)  "#c3c3c3"
set vTcl(pr,gui_comp_color)  gray40
set vTcl(pr,gui_ana1_color)  "#ececec"
set vTcl(pr,gui_ana2_color)  "#d9d9d9"
set vTcl(pr,gui_fg_color)    $vTcl(default_fg_color)

set vTcl(pr,menu_bg_color)   $vTcl(default_bg_color)
set vTcl(pr,menu_fg__color)  $vTcl(default_fg_color)



set vTcl(tk_default_bgcolor) "#d9d9d9"   ;# Rozen
set vTcl(tk_default_analog_color) "#ececec"
set vTcl(tk_default_fgcolor) "#000000"   ;# Rozen
set vTcl(tk_default_guibgcolor) $vTcl(tk_default_bgcolor)   ;# Rozen
set vTcl(tk_default_guifgcolor) $vTcl(tk_default_fgcolor)   ;# Rozen
set vTcl(tk_default_menubgcolor) $vTcl(tk_default_bgcolor)   ;# Rozen
set vTcl(tk_default_menufgcolor) $vTcl(tk_default_fgcolor)   ;# Rozen
set vTcl(tk_default_activebackground) "#ececec"  ;# The color I found.
set vTcl(pr,bgcolor) $vTcl(tk_default_bgcolor)      ;# Rozen
set vTcl(pr,fgcolor) $vTcl(tk_default_fgcolor)      ;# Rozen
set vTcl(pr,active_bgcolor) $vTcl(tk_default_analog_color)

set vTcl(pr,bganalogcolor)   $vTcl(tk_default_analog_color)
set vTcl(pr,guibgcolor)      $vTcl(tk_default_bgcolor)
set vTcl(pr,guifgcolor)      $vTcl(tk_default_fgcolor)
set vTcl(pr,guianalogcolor)  $vTcl(tk_default_analog_color)
set vTcl(pr,menubgcolor)     $vTcl(tk_default_bgcolor)
set vTcl(pr,menufgcolor)     $vTcl(tk_default_fgcolor)
set vTcl(pr,menuanalogcolor) $vTcl(tk_default_analog_color)
set vTcl(select_background) blue
set vTcl(select_foreground) white

# Rozen Stuff I put in to work with auto choosing foreground and selected colors, complements and analogous doesn't work well with foreground gray.
set vTcl(contrast_color) ""

set vTcl(complement_color) "#c3c3c3"
set vTcl(analog_color_p) ""
set vTcl(analog_color_m) "#ececec"
set vTcl(pr,guicontrast_color) $vTcl(tk_default_bgcolor)
set vTcl(pr,guicomplement_color) $vTcl(tk_default_bgcolor)
set vTcl(pr,guianalog_color_p) $vTcl(tk_default_bgcolor)
set vTcl(pr,guianalog_color_m) $vTcl(tk_default_analog_color)

## this is for Linux/UNIX systems only, on Windows we use default colors
# if {$tcl_platform(platform) != "windows"} {
#     set vTcl(pr,bgcolor) "#d9d9d9" ;#  Rozen
#     #set vTcl(pr,bgcolor) white
#     #set vTcl(pr,bgcolor) wheat
# }
# set
#vTcl(pr,bgcolor) "#d9d9d9" ;#  Rozen NEEDS WORK


# Rozen
set vTcl(area_bg) #d9d9d9
set vTcl(pr,interface_color) wheat
set vTcl(pr,entrybgcolor) #ffffff
set vTcl(pr,guientrybgcolor) #ffffff   ;# Rozen 11/6/12

set vTcl(pr,guibgcolor) $vTcl(tk_default_bgcolor)         ;# Rozen 11/9/12
set vTcl(pr,guifgcolor) $vTcl(tk_default_fgcolor)         ;# Rozen 11/9/12


# Added by Rozen so that in the Attribute Editor disabled fields stand out.
set vTcl(pr,disablebg) plum
set vTcl(pr,disablefg) black
# ---
set vTcl(pr,entryactivecolor) #ffffff
set vTcl(pr,guientryactivecolor) #ffffff  ;# Rozen 11/6/12
set vTcl(pr,listboxbgcolor) #ffffff       ;# Rozen apparently never used.
set vTcl(pr,guilistboxbgcolor) #ffffff    ;# Rozen 11/6/12
set vTcl(tk_default_treehighlight) firebrick
set vTcl(pr,treehighlight) $vTcl(tk_default_treehighlight)
set vTcl(pr,menubgcolor) $vTcl(tk_default_bgcolor)
set vTcl(pr,menufgcolor) #000000
set vTcl(pr,activebackground) $vTcl(tk_default_bgcolor)
set vTcl(pr,activeforeground) #000000

if {$vTcl(platform) eq "windows"} {
    set vTcl(pr,python_cmd)    "python"
} else {
    set vTcl(pr,python_cmd)    "python3"
}

# Rozen

# list of those widget classes having both text and textvariable options.
set vTcl(text_widgets) [list Button Checkbutton Label Menubutton \
                         Message Radiobutton TButton TCheckbutton  \
                         TLabel TMenubutton  TRadiobutton TTreeview]

# list of those widget classes having the textvariable option.
set vTcl(textvariable_widgets) [list Button Checkbutton Entry Label Menubutton \
                               Message Radiobutton Spinbox TButton TCheckbutton \
                               TCombobox TEntry TLabel TMenubutton TRadiobutton]

set vTcl(project_specified) 0
# To facilitate saving defaults in the generated tcl program.
set vTcl(actual_gui_bg) ""
set vTcl(actual_gui_fg) ""
set vTcl(actual_gui_font_dft) ""
set vTcl(actual_gui_font_text) ""
set vTcl(actual_gui_font_fixed) ""
set vTcl(actual_gui_font_menu) ""
set vTcl(actual_gui_font_treeview) ""

# Rozen - hack to allow deletion of widgets.
#set vTcl(dump,userFonts) {}
set vTcl(save2_running) 0
set vTcl(first_time) 1

set vTcl(pr,texteditor)  ""
set vTcl(numRcFiles)     5
set vTcl(numBcFiles)     5
# end preferences
# Rozen for errors with respect to menus
set vTcl(skip_error)     0
# end
# Rozen for keeping track of notebook tabs.
set vTcl(tab_count)      2
# end
set vTcl(proc,name)      ""
set vTcl(proc,args)      ""
set vTcl(proc,body)      ""
set vTcl(proc,ignore)    "tcl* tk* auto_* vTcl:* bgerror .*"
set vTcl(project,name)   ""
set vTcl(project,dir)    "Projects"
set vTcl(project,types)  {"Visual Tcl Project"}
set vTcl(quit)           0
set vTcl(tool,list)      ""
set vTcl(tool,last)      ""
set vTcl(toolbar,width) 2
set vTcl(tops)           ""
set vTcl(undo)           ""
set vTcl(vars)           ""
set vTcl(var,name)       ""
set vTcl(var,value)      ""
set vTcl(var,ignore)     "vTcl.*|tix.*"
set vTcl(var_update)     "yes"
set vTcl(w,alias)        ""
set vTcl(alias_cnt)      1
set vTcl(existing_aliases) [list]
set vTcl(w,class)        ""
set vTcl(w,def_mgr)      $vTcl(pr,manager)
set vTcl(w,grabbed)      0
set vTcl(w,info)         ""
set vTcl(w,insert)       .
set vTcl(w,libs)         ""
set vTcl(w,libsnames)    ""
set vTcl(w,manager)      ""
set vTcl(w,mgrs)         "grid pack place wm"
set vTcl(w,options)      ""
set vTcl(w,widget)       ""
set vTcl(w,selected)       ""
set vTcl(winname)        "vTclWindow"
#set vTcl(windows)        ".vTcl.toolbar .vTcl.mgr .vTcl.ae .vTcl.wstat
#                          .vTcl.proclist .vTcl.toplist .vTcl.tree
#                          .vTcl.tkcon .vTcl.prefs .vTcl.about .vTcl.bind
#                          .vTcl.imgManager .vTcl.fontManager .vTcl.inspector
#                          .vTcl.help .vTcl.gui_console .vTcl.supp_console
#                          .vTcl.callback .vTcl.apply"
# List of windows the location of which we want to save.
set vTcl(windows)        ".vTcl .vTcl.toolbar .vTcl.ae .vTcl.apply
                          .vTcl.tree .vTcl.tkcon .vTcl.prefs .vTcl.about
                          .vTcl.bind .vTcl.gui_console .vTcl.supp_console
                          .vTcl.callback .vTcl.apply vTclWindow.vTcl.itemEdit"
# Candidates for the show list.
set vTcl(startup_windows) ".vTcl .vTcl.toolbar .vTcl.ae .vTcl.tree"
# Initial sash position for console windows.
set vTcl(gui,pos) 0
set vTcl(supp,pos) 0

set vTcl(newtops)        1
set vTcl(mode)           "Absolute"
set vTcl(pwd)            [pwd]
#set vTcl(redo)           ""
set vTcl(save)           ""
set vTcl(tab)            "    "
set vTcl(tab2)           "$vTcl(tab)$vTcl(tab)"
set vTcl(tab_width)      4
set vTcl(images,stock)   ""
set vTcl(images,user)    ""
set vTcl(fonts,stock)    ""
set vTcl(fonts,user)     "gui_font_dft"

set vTcl(pr,proprelief)  "flat"
set vTcl(reliefs)        "flat groove raised ridge sunken solid"

set vTcl(cmpd,list)      ""
set vTcl(syscmpd,list)   ""

set vTcl(attr,tops)     "aspect command focusmodel geometry grid
                         iconbitmap iconmask iconname iconposition
                         iconwindow maxsize minsize overrideredirect
                         resizable sizefrom state toptitle"
                      # resizable sizefrom state title" ;# NEEDS WORK - toptitle

set vTcl(attr,winfo)    "children class geometry height ismapped
                         manager name parent rootx rooty toplevel
                         width x y"

set vTcl(global_string) ""              ;# Rozen
set vTcl(template)      0               ;# Rozen

# Globals added for reducing reduntant saves. Rozen
set vTcl(last_save,tcl_file)       ""
set vTcl(last_save,GUI)       ""
set vTcl(last_save,Support)   ""

# Globals added for generating the support python.
set vTcl(tk_import)     \
"
import sys

try:
$vTcl(tab)from Tkinter import *
except ImportError:
$vTcl(tab)from tkinter import *

try:
$vTcl(tab)import ttk
$vTcl(tab)py3 = False
except ImportError:
$vTcl(tab)import tkinter.ttk as ttk
$vTcl(tab)py3 = True"


#
# Default attributes to append on insert
#
set vTcl(grid,insert)   ""
set vTcl(pack,insert)   ""
#set vTcl(place,insert)  "-x 5 -y 5 -bordermode ignore"
set vTcl(place,insert)  "-bordermode ignore"         ;# Rozen 5/11/18


#
# Initial placement of windows
#
set vTcl(geom_option_list) [list -x -y -width -height \
                              -relx -rely -relwidth -relheight]

set vTcl(default,.vTcl) +0+0
set vTcl(default,.vTcl.toolbar) +0+130
set vTcl(default,.vTcl.ae) -0+0
set vTcl(default,.vTcl.proclist) +766+654
set vTcl(default,.vTcl.tree) +0-0
set vTcl(default,.vTcl.bind) -0-0
set vTcl(default,.vTcl.apply) -0-0
set vTcl(default,.vTcl.callback) -0-0
set vTcl(default,.vTcl.gui_console) +0+100      ;# NEEDS DUP
set vTcl(default,.vTcl.supp_console) -0+100      ;# NEEDS DUP
set vTcl(default_locatiions) 0

set vTcl(geometry,.vTcl)  $vTcl(default,.vTcl)
set vTcl(geometry,.vTcl.toolbar) $vTcl(default,.vTcl.toolbar)
set vTcl(geometry,.vTcl.ae) $vTcl(default,.vTcl.ae)
set vTcl(geometry,.vTcl.proclist) $vTcl(default,.vTcl.proclist)
set vTcl(geometry,.vTcl.tree) $vTcl(default,.vTcl.tree)
set vTcl(geometry,.vTcl.bind) $vTcl(default,.vTcl.bind)
set vTcl(geometry,.vTcl.apply) $vTcl(default,.vTcl.apply)
set vTcl(geometry,.vTcl.callback) $vTcl(default,.vTcl.callback)
set vTcl(geometry,.vTcl.gui_console)  $vTcl(default,.vTcl.gui_console)
set vTcl(geometry,.vTcl.supp_console) $vTcl(default,.vTcl.supp_console)
set vTcl(geometry,menu_editor) 550x450+350+150

# Geometry Manager Attributes       LabelName     Balloon  Type   Choices   CfgCmd     Group
#
#
set vTcl(m,pack,list) "-anchor -expand -fill -side -ipadx -ipady -padx -pady -in"
set vTcl(m,pack,-anchor)           { anchor          {}       choice  {n ne e se s sw w nw center} }
set vTcl(m,pack,-expand)           { expand          {}       boolean {0 1} }
set vTcl(m,pack,-fill)             { fill            {}       choice  {none x y both} }
set vTcl(m,pack,-side)             { side            {}       choice  {top bottom left right} }
set vTcl(m,pack,-ipadx)            { {int. x pad}    {}       type    {} }
set vTcl(m,pack,-ipady)            { {int. y pad}    {}       type    {} }
set vTcl(m,pack,-padx)             { {ext. x pad}    {}       type    {} }
set vTcl(m,pack,-pady)             { {ext. y pad}    {}       type    {} }
set vTcl(m,pack,-in)               { inside          {}       type    {} }
set vTcl(m,pack,extlist) "propagate"
set vTcl(m,pack,propagate)         { propagate       {}        boolean {0 1} {vTcl:pack:conf_ext} }

set vTcl(m,place,list) "-anchor -x -y -relx -rely -width -height -relwidth -relheight"
#set vTcl(m,place,extlist) ""
set vTcl(m,place,extlist) "locked"
set vTcl(m,place,locked)           { locked          {}       boolean {0 1} {vTcl:place:conf_geom} }
set vTcl(m,place,-anchor)          { {anchor}        {}       choice  {n ne e se s sw w nw center} }
set vTcl(m,place,-x)               { {x position}    {}       type    {} }
set vTcl(m,place,-y)               { {y position}    {}       type    {} }
set vTcl(m,place,-width)           { width           {}       type    {} }
set vTcl(m,place,-height)          { height          {}       type    {} }
set vTcl(m,place,-relx)            { {relative x}    {}       type    {} }
set vTcl(m,place,-rely)            { {relative y}    {}       type    {} }
set vTcl(m,place,-relwidth)        { {rel. width}    {}       type    {} }
set vTcl(m,place,-relheight)       { {rel. height}   {}       type    {} }
set vTcl(m,place,-in)              { inside          {}       type    {} }
# Default value for place geometry
set vTcl(w,place,locked)           0      ;# 8/9/18

set vTcl(m,grid,list) "-sticky -row -column -rowspan -columnspan -ipadx -ipady -padx -pady -in"
set vTcl(m,grid,-sticky)           { sticky          {}       type    {n s e w} }
set vTcl(m,grid,-row)              { row             {}       type    {} }
set vTcl(m,grid,-column)           { column          {}       type    {} }
set vTcl(m,grid,-rowspan)          { {row span}      {}       type    {} }
set vTcl(m,grid,-columnspan)       { {col span}      {}       type    {} }
set vTcl(m,grid,-ipadx)            { {int. x pad}    {}       type    {} }
set vTcl(m,grid,-ipady)            { {int. y pad}    {}       type    {} }
set vTcl(m,grid,-padx)             { {ext. x pad}    {}       type    {} }
set vTcl(m,grid,-pady)             { {ext. y pad}    {}       type    {} }
set vTcl(m,grid,-in)               { inside          {}       type    {} }

set vTcl(m,grid,extlist) "row,weight column,weight row,minsize  column,minsize propagate"
set vTcl(m,grid,column,weight)     { {col weight}    {}       type    {} {vTcl:grid:conf_ext} }
set vTcl(m,grid,column,minsize)    { {col minsize}   {}       type    {} {vTcl:grid:conf_ext} }
set vTcl(m,grid,row,weight)        { {row weight}    {}       type    {} {vTcl:gri#d:conf_ext} }
set vTcl(m,grid,row,minsize)       { {row minsize}   {}       type    {} {vTcl:grid:conf_ext} }
set vTcl(m,grid,propagate)         { propagate       {}       boolean {0 1} {vTcl:grid:conf_ext} }

set vTcl(m,wm,list) ""
#set vTcl(m,wm,extlist) "set,origin geometry,x geometry,y set,size geometry,w geometry,h
#                        resizable,w resizable,h minsize,x minsize,y maxsize,x maxsize,y state title runvisible"
#set vTcl(m,wm,extlist) "rel,geom dflt,origin geometry,x geometry,y geometry,w geometry,h
#resizable,w resizable,h minsize,x minsize,y maxsize,x maxsize,y state title"
#set vTcl(m,wm,extlist) "prop,geom dflt,origin geometry,x geometry,y geometry,w geometry,h
#resizable,w resizable,h minsize,x minsize,y maxsize,x maxsize,y title"
set vTcl(m,wm,extlist) "dflt,origin geometry,x geometry,y geometry,w geometry,h
resizable,w resizable,h minsize,x minsize,y maxsize,x maxsize,y"
# resizable,w resizable,h minsize,x minsize,y maxsize,x maxsize,y title"
#set vTcl(m,wm,savelist) "set,origin set,size runvisible"
#set vTcl(m,wm,savelist) "rel,origin set,origin set,size runvisible"
#set vTcl(m,wm,savelist) "rel,geom dflt,origin set,size runvisible"
#set vTcl(m,wm,savelist) "prop,geom dflt,origin runvisible"
set vTcl(m,wm,savelist) "dflt,origin runvisible"

#set vTcl(m,wm,prop,geom)            { {prop geom}    {}       \
                                   boolean {1 0}  {vTcl:wm:relative_geometry} }
#set vTcl(m,wm,dflt,origin)         { {dflt origin}    {}       \
                                         boolean {0 1}  {vTcl:wm:conf_geom} }
set vTcl(m,wm,dflt,origin)         { {dflt origin}    {}       \
                                     boolean {0 1}  {vTcl:wm:conf_dflt_origin} }
#set vTcl(m,wm,set,origin)         { {set origin}    {}       \
                                         boolean {0 1}  {vTcl:wm:conf_geom} }
set vTcl(m,wm,geometry,x)          { {x position}    {}       \
                                         type    {} {vTcl:wm:conf_geom} }
set vTcl(m,wm,geometry,y)          { {y position}    {}       \
                                         type    {} {vTcl:wm:conf_geom} }
set vTcl(m,wm,set,size)            { {set size}      {}       \
                                         boolean {0 1}  {vTcl:wm:conf_geom} }
set vTcl(m,wm,geometry,w)          { width           {}       \
                                         type    {} {vTcl:wm:conf_geom} }
set vTcl(m,wm,geometry,h)          { height          {}       \
                                         type    {} {vTcl:wm:conf_geom} }
set vTcl(m,wm,resizable,w)         { {resize width}  {}       \
                                         boolean {0 1} {vTcl:wm:conf_resize} }
set vTcl(m,wm,resizable,h)         { {resize height} {}       \
                                         boolean {0 1} {vTcl:wm:conf_resize} }
set vTcl(m,wm,minsize,x)           { {x minsize}     {}       \
                                         type    {} {vTcl:wm:conf_minmax} }
set vTcl(m,wm,minsize,y)           { {y minsize}     {}       \
                                         type    {} {vTcl:wm:conf_minmax} }
set vTcl(m,wm,maxsize,x)           { {x maxsize}     {}       \
                                         type    {} {vTcl:wm:conf_minmax} }
set vTcl(m,wm,maxsize,y)           { {y maxsize}     {}       \
                                         type    {} {vTcl:wm:conf_minmax} }
set vTcl(m,wm,state)               { state           {}
              choice  {iconify deiconify withdraw} {vTcl:wm:conf_state} }
set vTcl(m,wm,runvisible)          { {run visible}   {}       \
                                         boolean {0 1} {vTcl:wm:conf_geom} }
set vTcl(m,wm,title)               { title           {}       \
                                         type    {} {vTcl:wm:conf_title} }

set vTcl(m,menebar,list) ""
set vTcl(m,menubar,extlist) ""

# Provide default values for menus managed by wm
set vTcl(w,wm,geometry,w)    0
set vTcl(w,wm,geometry,h)    0
set vTcl(w,wm,geometry,x)    0
set vTcl(w,wm,geometry,y)    0
set vTcl(w,wm,minsize,x)     0
set vTcl(w,wm,minsize,y)     0
set vTcl(w,wm,maxsize,x)     0
set vTcl(w,wm,maxsize,y)     0
set vTcl(w,wm,aspect,minnum) 0
set vTcl(w,wm,aspect,minden) 1
set vTcl(w,wm,aspect,maxnum) 0
set vTcl(w,wm,aspect,maxden) 1
set vTcl(w,wm,resizable,w)   0
set vTcl(w,wm,resizable,h)   0
set vTcl(w,wm,dflt,origin)    0
#set vTcl(w,wm,prop,geom)       1
set vTcl(w,wm,set,origin)    0
set vTcl(w,wm,set,size)      1
set vTcl(w,wm,runvisible)    1
set vTcl(skip_AE_update)     0

set vTcl(head,proj) [string trim {
#############################################################################
# Generated by PAGE version $vTcl(version)
#  in conjunction with Tcl version $vTcl(tcl_version)
#  $vTcl(timestamp)  platform: $tcl_platform(os)
set vTcl(timestamp) ""
if {!\[info exists vTcl(borrow)\]} {
    ::vTcl::MessageBox -title Error -message \
        "You must open project files from within PAGE."
    exit}
}]

set vTcl(head,projfile) [string trim {
#############################################################################
# Visual Tcl v$vTcl(version) Window, part of a multiple files project
#
}]

set vTcl(head,compounds) [string trim {
#############################################################################
#  Compound Library
#
}]


set vTcl(head,exports) [string trim {
#################################
#LIBRARY PROCEDURES
#
}]

set vTcl(head,procs) [string trim {
#################################
# USER DEFINED PROCEDURES
#
}]

set vTcl(head,gui) [string trim {
#################################
# GENERATED GUI PROCEDURES
#
}]

set vTcl(head,proc,widgets) "$vTcl(tab)###################
$vTcl(tab)# CREATING WIDGETS
$vTcl(tab)###################
"

set vTcl(head,proc,geometry) "$vTcl(tab)###################
$vTcl(tab)# SETTING GEOMETRY
$vTcl(tab)###################
"


# @@change by Christian Gavin 3/19/2000
# patterns and colors for syntax colouring
# @@end_change

# set vTcl(syntax,tags) "vTcl:dollar vTcl:command vTcl:option vTcl:parenthesis vTcl:bracket vTcl:window vTcl:string vTcl:comment"

# set vTcl(syntax,vTcl:parenthesis)            {\([^ ]+\)}
# set vTcl(syntax,vTcl:parenthesis,configure)  {-foreground #00A000}

# set vTcl(syntax,vTcl:dollar)            {\$[a-zA-Z0-9_]+}
# set vTcl(syntax,vTcl:dollar,configure)  {-foreground #00A000}

# set vTcl(syntax,vTcl:bracket)           {\[|\]|\{|\}|\(|\)}
# set vTcl(syntax,vTcl:bracket,configure) {-foreground #FF0000}

# set vTcl(syntax,vTcl:command)           {[a-zA-Z0-9_\-:]+}
# set vTcl(syntax,vTcl:command,configure) {-foreground #B000B0}
# set vTcl(syntax,vTcl:command,validate)  vTcl:syntax:iscommand

# set vTcl(syntax,vTcl:option)            {\-[a-zA-Z0-9]+}
# set vTcl(syntax,vTcl:option,configure)  {-foreground #0000FF}

# set vTcl(syntax,vTcl:comment)       {# [,\. a-zA-Z0-9:=_?()@'/-<>"  ]+}
# set vTcl(syntax,vTcl:comment,configure) {-foreground #B0B0B0}

# set vTcl(syntax,vTcl:string)        {\"[^\"]*\"}
# set vTcl(syntax,vTcl:string,configure)  {-foreground #00A0A0}

# set vTcl(syntax,vTcl:window)            {\.[a-zA-Z0-9_\.]+}
# set vTcl(syntax,vTcl:window,configure)  {-foreground #800060}


# Rozen: Modified the following code to get better Python colorization.

# @@change by Christian Gavin 3/19/2000
# patterns and colors for syntax colouring
# @@end_change

#set vTcl(syntax,tags) "vTcl:dollar vTcl:bracket vTcl:command vTcl:option vTcl:parenthesis vTcl:window vTcl:string vTcl:comment"

#set vTcl(syntax,vTcl:parenthesis)            {\(.+\)}
#set vTcl(syntax,vTcl:parenthesis,configure)  {-foreground #00A000}

#set vTcl(syntax,vTcl:dollar)            {\$[a-zA-Z0-9_]+}
#set vTcl(syntax,vTcl:dollar,configure)  {-foreground #00A000}

#set vTcl(syntax,vTcl:bracket)           {\[|\]|\{|\}}
#set vTcl(syntax,vTcl:bracket,configure) {-foreground #FF0000}

#set vTcl(syntax,vTcl:command)           {[a-zA-Z0-9_:]+}
#set vTcl(syntax,vTcl:command,configure) {-foreground #B000B0}
#set vTcl(syntax,vTcl:command,validate)  vTcl:syntax:iscommand

set vTcl(syntax,vTcl:command)           {[a-z]+_?}
set vTcl(syntax,vTcl:command,configure) {-foreground Red}
set vTcl(syntax,vTcl:command,validate)  vTcl:syntax:iskeyword

#set vTcl(syntax,vTcl:option)            {\-[a-zA-Z0-9]+}
#set vTcl(syntax,vTcl:option,configure)  {-foreground #0000FF}

#set vTcl(syntax,vTcl:comment)       {# [,\. a-zA-Z0-9:=_?()@'/-<>"  ]+}
#set vTcl(syntax,vTcl:comment,configure) {-foreground #B0B0B0}
set vTcl(syntax,vTcl:comment)       {#.*$}
set vTcl(syntax,vTcl:comment,configure) {-foreground Blue}

set vTcl(syntax,vTcl:string)        {\"[^\"]*\"}
#set vTcl(syntax,vTcl:string,configure)  {-foreground #00A0A0}
set vTcl(syntax,vTcl:string,configure)  {-foreground DarkGreen}

set vTcl(syntax,vTcl:string1)        {\'[^\']*\'}
set vTcl(syntax,vTcl:string1,configure)  {-foreground DarkGreen}

#set vTcl(syntax,vTcl:window)            {\.[a-zA-Z0-9_\.]+}
#set vTcl(syntax,vTcl:window,configure)  {-foreground #800060}

set vTcl(syntax,vTcl:proc)               {def *([a-zA-Z0-9_]+)\(}
set vTcl(syntax,vTcl:proc,configure)     {-foreground Firebrick}

set vTcl(syntax,vTcl:class)               {class *([a-zA-Z0-9_]+)\:}
set vTcl(syntax,vTcl:class,configure)     {-foreground Firebrick}

set vTcl(syntax,tags) "vTcl:command vTcl:string vTcl:string1 vTcl:comment vTcl:proc vTcl:class"

# Rozen: end of my colorization changes.

# Rozen: Python colorization code follows:
# Also see colorization procs in misc.tcl.
set vTcl(python_keyword_list) "
     and
     assert
     break
     class
     continue
     def
     del
     elif
     else
     except
     exec
     finally
     for
     from
     global
     if
     import
     in
     is
     lambda
     not
     or
     pass
     print
     raise
     return
     try
     while
     yield
"
# Rozen - a proc for verifying that a string is a keyword.
proc vTcl:syntax:iskeyword {candidate} {
    global vTcl
    if {[lsearch -exact $vTcl(python_keyword_list) $candidate] > -1} {
        return 1
    }
    return 0
}

# Rozen - end of Python colorization changes.



proc vTcl:syntax:iscommand {command} {
    return [ expr { [info command $command] == $command } ]
}

# special case for -in option
set vTcl(option,noencase,-in) 1


# Rozen,  Global variables that I added for page.

# Used in setting action for <control-button-1> see
# vTcl:bind_button_top in dragsize.tcl. This needs to be augmented
# each time we add such a widget.  I am starting with this two since I
# have already added them.  Probably should be done in the wgt file.

# Multiple selection 11/2/19 Next two lines.
set vTcl(multi_select) 0
set vTcl(multi_select_list) [list]
set vTcl(remove_all_multi) 0
set vTcl(tree,green_tags) [list]
set vTcl(w,didmove) 0

# Relative placement additions
set vTcl(relative_exemtpions) [list Button TButton Entry TEntry]

# For recognizing widgets with textvariable option.
set vTcl(widgets_with_textvarable) [list "Button" "TButton" "Label" "TLabel" \
                                   "Message" "Checkbutton" "TCheckbutton"    \
                                        "Radiobutton" "TRadiobutton"]
# ["Spinbox" "TSpinbox"]
