##############################################################################
# $Id: toolbar.tcl,v 1.17 2005/12/05 06:53:15 kenparkerjr Exp $
#
# toolbar.tcl - widget toolbar
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

# This module creates the toolbar and fills it in. The toolbar is
# created with three sections - one each for tk widgets, ttk widgets,
# and the enhanced widgets. The sections are filled in by
# vTcl:toolbar_add which is called ultimate in vTcl:setup_gui located
# in page.tcl.

# When a selection is made in the Widget Toolbar, vTcl:new_widget is
# called with the class as the important parameter.

proc vTcl:show_toolbar {} {
    global vTcl
    vTclWindow.vTcl.toolbar
    wm geometry .vTcl.toolbar $vTcl(default,.vTcl.toolbar)
}

proc vTcl:toolbar_create {args} {
    global vTcl
    set base .vTcl.toolbar
    set top $base
    if {[winfo exists $base]} {return}
    vTcl:toplevel $base -width 237 -height 110 -class vTcl
    #wm transient $base .vTcl
    wm withdraw $base
    wm title $base "Widget Toolbar"
    wm geometry $base 400x500+110+110
    # wm minsize $base 237 40
    wm minsize $base 250 40
    wm overrideredirect $base 0
    catch {wm geometry .vTcl.toolbar $vTcl(geometry,.vTcl.toolbar)}
    wm deiconify $base
    update
    wm protocol .vTcl.toolbar WM_DELETE_WINDOW {
        vTcl:error "You cannot remove the toolbar"
    }

    #set sbands [kpwidgets::SBands .vTcl.toolbar.sbands]

    # This stuff is for putting the pointer button in toolbar. Never
    # figured out what it is good for; so out. 11/14/17
        # frame $base.tframe -relief raise -bd 1

        # image create photo pointer \
        #     -file [file join $vTcl(VTCL_HOME) images icon_pointer.gif]
        # button $base.tframe.b -bd 1 -image pointer -relief sunken -command "
        # $base.tframe.b configure -relief sunken
        # vTcl:raise_last_button $base.tframe.b
        # vTcl:rebind_button_1
        # vTcl:status Status
        # set vTcl(x,lastButton) $base.tframe.b
        # " -padx 0 -pady 0 -highlightthickness 0 \
        #     -text {suspend multiplacement} -compound left

        # pack $base.tframe -side top -fill x
        # pack $base.tframe.b -side left
    ScrolledWindow $base.cpd21
    canvas $base.cpd21.03 -highlightthickness 0 \
       -background $vTcl(pr,bgcolor) \
       -borderwidth 0 \
       -closeenough 1.0 -relief flat
    $base.cpd21 setwidget $base.cpd21.03

    pack $base.cpd21 \
        -in $base -anchor center -expand 1 -fill both -side top

    # I am setting this up to show ONLY three groups of widgets -
    # core, tk, and scrolled.
    set c $base.cpd21.03
    set vTcl(gui,toolbar,canvas) $c

    set f1 $c.f1; frame $f1 -bg $vTcl(pr,bgcolor)   ; # tk widgets
    $c create window 0 0 -window $f1 -anchor nw -tag tk


    #ttk::style configure PyConsole.TSizegrip \
        -background $vTcl(actual_gui_bg) ;# 11/22/12
    #pack [ttk::sizegrip $sbands.sz -style "PyConsole.TSizegrip"] \
        -side right -anchor se
    #place [ttk::sizegrip $base.sz -style PyConsole.TSizegrip] \
        -in $base -relx 1.0 -rely 1.0 -anchor se

    catch {wm geometry $base $vTcl(geometry,$base)}
    vTcl:tool:recalc_canvas

    bind $base.cpd21.03 <Enter> \
        {vTcl:bind_mousewheel  $::vTcl(gui,tool).cpd21.03}
    bind $base.cpd21.03 <Leave> \
        {vTcl:unbind_mousewheel $::vTcl(gui,tool).cpd21.03}

    # When you enter the console window raise it to the top.
    bind $base <Enter> "raise $base"
    wm deiconify $base
}

proc vTcl:tool:recalc_canvas {} {
    global vTcl
    update
    set toolbar .vTcl.toolbar
    set c  $vTcl(gui,toolbar,canvas)
    if {![winfo exists $toolbar]} { return }
    set f1 $c.f1                              ; # Tk Widget Frame
    set f2 $c.f2                              ; # Ttk Widget Frame
    set f3 $c.f3                              ; # Enhanced Widget Frame

    set w [winfo width $f1]
    set h [winfo height $f1]
    $c configure -scrollregion "0 0 $w $h"
    #$c configure -yscrollincrement 20

    set geom [wm geometry .vTcl.toolbar]
    set g_split [split $geom x]
    set new_geom ${w}x[lrange $g_split 1 1]
    catch {wm geometry .vTcl.toolbar $new_geom}

    #wm minsize .vTcl.ae $w 200

}

proc vTcl:toolbar_header {band label} {
    # We call this function three times once each from lib_core.tcl,
    # lib_ttk.tcl, and lib_custom.tcl.  The first time it's called it
    # creates the toolbar.
    # Put in a label which contain the header label.
    global vTcl
    if {![winfo exists $.vTcl.toolbar]} { vTcl:toolbar_create }
    set c  $vTcl(gui,toolbar,canvas)

    set frame $c.f1
    set base $frame

    set ll [vTcl:new_widget_name l $base]
    # label $ll -text $label -background #aaaaaa
    label $ll -text $label -background #aaaaaa -foreground $vTcl(active_fg)
    set vTcl(activebacground_color) [$ll cget -activebackground]
    pack $ll -fill x
}

proc vTcl:toolbar_add {band_name class name image cmd_add } {
    # Rozen, I decided to have the button include the descriptive text
    # rather than put it into an adjacent label.  This makes the
    # button a bigger target for the mouse and was really very easy
    # to do; just add three options to the button statement and remove
    # the label stuff.  Really got tired of the previous behavior.

    # This routine fills in one entry in the toolbar. It is called
    # from vTcl:lib:add_widgets_to_toolbar located in misc.tcl. In
    # turn that function is called from lib_core.tcl,
    # lib_ttk.tcl. lib_scrolled, etc.. In lib_core.tcl it is called
    # from vTcl:widget:lib:lib_core which has a list of widgets for
    # the core band of the toolbar.

    global vTcl
    if {![winfo exists .vTcl.toolbar]} { vTcl:toolbar_create }
    set c  $vTcl(gui,toolbar,canvas)

    set frame $c.f1
    $frame configure -bg $vTcl(pr,bgcolor)
    set base $frame   ;# base is the frame containing all the buttons.
    set f [vTcl:new_widget_name tb $base]
    ensureImage $image
    frame $f
    pack $f -side top -fill x
    append tpart "  " $class "  "
    button $f.b -bd 1 -image $image -padx 0 -pady 0 -highlightthickness 0 \
        -text $tpart  -compound left  -relief flat
    bind $f.b <ButtonRelease-1> \
        "vTcl:new_widget \$vTcl(pr,autoplace) $class $f.b \"$cmd_add\""
    #bind $f.b <Shift-ButtonRelease-1> \
    #"vTcl:new_widget 1 $class $f.b \"$cmd_add\""
    #vTcl:set_balloon $f.b $name   Don't want these tooltips
    lappend vTcl(tool,list) $f.b
    pack $f.b -side left
}

namespace eval ::vTcl {
    proc toolbar_header { band_name title } {
        if {![winfo exists $.vTcl.toolbar]} { vTcl:toolbar_create }
        set base .vTcl.toolbar.sbands
        $base new_frame $band_name $title
    }
}

proc vTclWindow.vTcl.toolbar {args} {
    vTcl:toolbar_reflow
}

proc vTcl:toolbar_reflow {{base .vTcl.toolbar}} {
    # This is where the toolbar is created. It is called from page.tcl.
    # page.tcl also has the deiconify statement which makes the
    # toolbar visible.
    global vTcl
    set existed [winfo exists $base]
    if {!$existed} { vTcl:toolbar_create }
    wm resizable $base 1 1
    update

    vTcl:setup_vTcl:bind $base
}

proc vTcl:config_toolbar_canvas {} {
return
    set canvas .vTcl.toolbar.c.canvas
    set h [winfo height $canvas]
    set w [winfo width $canvas]
    set width [winfo reqwidth $canvas]
    set height [winfo reqheight $canvas]
    $canvas configure -scrollregion "0 0 $w $h"
}


