##############################################################################
# $Id: color.tcl,v 1.8 2001/11/30 04:22:49 cgavin Exp $
#
# color.tcl - color browser
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

proc vTcl:get_color {color w {t {Choose a color}}} {
    # Rozen.  Changed this routine to use the colorDlg color picker
    # written by Alain (he gives no last name.) Mainly I added the
    # third parameter and changed the call below to colorDlg.

    # apparently Iwidgets 3.0 returns screwed up colors
    #
    # tk_chooseColor accepts the following:
    # #RGB           (4 chars)
    # #RRGGBB        (7 chars)
    # #RRRGGGBBB     (10 chars)
    # #RRRRGGGGBBBB  (13 chars)
    if {[string first "#" $color] > -1} {
        if {[string length $color] == 11} {
            set extend [string range $color 10 10]
            set color $color$extend$extend
            vTcl:log "Fixed color: $color"
        } else {
            if {[string length $color] == 9} {
                set extend [string range $color 8 8]
                set color $color$extend$extend$extend$extend
                vTcl:log "Fixed color: $color"
            }
        }
    }
    global vTcl tk_version tcl_platform
    set oldcolor $color
    if {$color == "" || $color == "#000000"} {
        set color white
    }
    # I tried several color choosers; the list is follows. I decided
    # to use this form of a color chooser, where I can enter X11 color
    # names.

    #set newcolor \
     [SelectColor::menu [winfo toplevel $w].color [list below $w] -color $color]
    # colorDlg is the one I have been using most recently.
    #set newcolor [::colorDlg::colorDlg -initialcolor $color -title $t]
    # set newcolor [tk_chooseColor -initialcolor $color -title $t]
    #set newcolor [tk_chooseColor  -title $t]
    #set newcolor [colorDlg -initialcolor $color -title $t]

    # On the recommended version of Tcl for Windows, colorDlg
    # doesn't work, so I fall back to tk_chooseColor.
    if {$tcl_platform(platform) == "windows" } {
        # set newcolor [tk_chooseColor -initialcolor $color -title $t]
        set newcolor [tk_chooseColor -title $t]
    } else {
        # Everywhere else.
        set newcolor [::colorDlg::colorDlg -initialcolor $color -title $t]
        #set newcolor [::colorDlg::colorDlg -title $t]
    }
    if {$newcolor != ""} {
        return $newcolor
    } else {
        return $oldcolor
    }
}

proc vTcl:show_color {widget option variable w} {
    # This may only be used in propmgr.tcl to get the right color for
    # the ellipses in the Attribute Editor.
    global vTcl
    set vTcl(color,widget)   $widget
    set vTcl(color,option)   $option
    set vTcl(color,variable) $variable
    set color [vTcl:at $variable]
    # The if-elseif block of code blow is no longer needed for the
    # color chooser being used.
    # if {$color == ""} {
    #     set color "#000000"
    # } elseif {[string range $color 0 0] != "#" } {
    #     set clist [winfo rgb . $color]
    #     set r [lindex $clist 0]
    #     set g [lindex $clist 1]
    #     set b [lindex $clist 2]
    #     set color "#[vTcl:hex $r][vTcl:hex $g][vTcl:hex $b]"
    # }
    set vTcl(color) [vTcl:get_color $color $w]
    if {[::colorDlg::dark_color $vTcl(color)]} {
        set ell_image ellipseslight
    } else {
        set ell_image ellipsesdark
    }
    set $vTcl(color,variable) $vTcl(color)
    $vTcl(color,widget) configure -bg $vTcl(color) -image $ell_image
    $vTcl(w,widget) configure $vTcl(color,option) $vTcl(color)
}

proc vTcl:set_actuals { } {
    # These setting are done after the preferences (.pagerc) are read
    # which might change the following preference variable. Called in
    # page.tcl. These may be overwritten when a project file (a .tcl
    # file) is opened. Called from vTcl:setup in page.tcl.
    global vTcl
    set vTcl(actual_bg) $vTcl(pr,bgcolor)                   ;# 11/6/18
    set vTcl(actual_fg) $vTcl(pr,fgcolor)                   ;# 11/6/18
    set vTcl(actual_gui_bg) $vTcl(pr,guibgcolor)
    set vTcl(actual_gui_fg) $vTcl(pr,guifgcolor)
    set vTcl(actual_gui_analog) $vTcl(pr,guianalogcolor)    ;# 11/6/18
    set vTcl(actual_gui_menu_bg) $vTcl(pr,menubgcolor)
    set vTcl(actual_gui_menu_fg) $vTcl(pr,menufgcolor)
    set vTcl(actual_gui_menu_analog) $vTcl(pr,menuanalogcolor)  ;# 11/6/18
    set vTcl(complement_color) $vTcl(pr,guicomplement_color)
    set vTcl(analog_color_p) $vTcl(pr,guianalog_color_p)
    set vTcl(analog_color_m) $vTcl(pr,guianalog_color_m)
    set vTcl(actual_bg_analog) $vTcl(pr,bganalogcolor)        ;# 11/6/18
    #set vTcl(actual_treehighlight) $vTcl(pr,treehighlight)
    set ac [::colorDlg::analogous_colors $vTcl(actual_bg)]
    set vTcl(analog_color_p) [lindex $ac 0]
    set vTcl(analog_color_m) [lindex $ac 1]
    set vTcl(complement_color) [::colorDlg::complement $vTcl(actual_bg)]

    # The tabfg1 and tabfg2 colors are the foreground colors of
    # unselected tabs of notebook widgets. I toyed with making those
    # colors variations of the preferred GUI foreground color but ran
    # into too many problems. I have decided to use beige. that then
    # allows me to set both tabfg1 and tabfg2 to black since beige is
    # light.


#    set vTcl(analog_color_m) beige
    if {$vTcl(actual_gui_bg) eq "f5f5dc" || $vTcl(actual_gui_bg) eq "beige"} {
        set vTcl(analog_color_m) pink
    } else {
        set vTcl(analog_color_m) beige
    }
    
    
    set vTcl(tabfg1) "black"
    set vTcl(tabfg2) "black"
    set vTcl(tabbg1) "grey75"
    set vTcl(tabbg2) "grey89"
    # Removed the following 4/28/22 because I think it is a mistake to
    # use any color for the foreground other than the preferred color!!!
    # I do the following because I end up using complentary colors of
    # gui bacground for the active background color and so if that
    # color is dark then I set the active foreground color white;
    # otherwise black.                 ;# NEEDS WORK dark
    # if {[::colorDlg::dark_color $vTcl(analog_color_m)]} {
    #     set fg_color  white       ;# Dealing with a dark background.
    # } else {
    #     set fg_color  black       ;# Dealing with a light background.
    # }

    if {[::colorDlg::dark_color $vTcl(actual_bg)]} {
        set vTcl(bg_mode) dark
    } else {
        set vTcl(bg_mode) light
    }
    # vTcl(analog_color_m) is the activeforground color. Note above
    # that I've taken the coward's way out and ALWAYS use beige. Thus,
    # one should not use beige as the primary color.
    if {[::colorDlg::dark_color $vTcl(analog_color_m)]} {
        set vTcl(fg_mode) dark
    } else {
        set vTcl(fg_mode) light
    }
    if {$vTcl(fg_mode) eq "light"} {
        set vTcl(active_fg) black
    } else {
        set vTcl(active_fg) white
    }

    #set vTcl(active_fg) $vTcl(actual_fg)
    set vTcl(actual_gui_font_dft) $vTcl(font,gui_font_dft)
    set vTcl(actual_gui_font_fixed) $vTcl(font,gui_font_fixed)
    set vTcl(actual_gui_font_text) $vTcl(font,gui_font_text)
    set vTcl(actual_gui_font_menu) $vTcl(font,gui_font_menu)

    set vTcl(actual_gui_menu_active_bg) $vTcl(actual_gui_menu_analog)
    if {[::colorDlg::dark_color $vTcl(actual_gui_menu_analog)]} {
        set menu_fg_color  #111111
    } else {
        set menu_fg_color  #000000
    }
    set vTcl(actual_gui_menu_active_fg) $menu_fg_color
    set vTcl(actual_autoalias) $vTcl(pr,autoalias)
    set vTcl(actual_relative_placement) $vTcl(pr,relative_placement)
}

proc vTcl:set_GUI_color_defaults { fileID } {
    # Rozen. This writes out code to set default upon loading the
    # generated GUI tcl file.
    global vTcl
    puts $fileID "########################################### "
    puts $fileID "set vTcl(actual_gui_bg) $vTcl(actual_gui_bg)"
    puts $fileID "set vTcl(actual_gui_fg) $vTcl(actual_gui_fg)"
    puts $fileID "set vTcl(actual_gui_analog) $vTcl(pr,guianalogcolor)"
    puts $fileID "set vTcl(actual_gui_menu_analog) $vTcl(pr,menuanalogcolor)"
    puts $fileID "set vTcl(actual_gui_menu_bg) $vTcl(actual_gui_menu_bg)"
    puts $fileID "set vTcl(actual_gui_menu_fg) $vTcl(actual_gui_menu_fg)"

    puts $fileID "set vTcl(complement_color) $vTcl(complement_color)"
    puts $fileID "set vTcl(analog_color_p) $vTcl(analog_color_p)"
    puts $fileID "set vTcl(analog_color_m) $vTcl(analog_color_m)"
    puts $fileID "set vTcl(tabfg1) $vTcl(tabfg1)"
    puts $fileID "set vTcl(tabfg2) $vTcl(tabfg2)"
    puts $fileID "set vTcl(actual_gui_menu_active_bg) \
                   $vTcl(actual_gui_menu_active_bg)"
    puts $fileID "set vTcl(actual_gui_menu_active_fg) \
                   $vTcl(actual_gui_menu_active_fg)"
    puts $fileID "########################################### "
}
