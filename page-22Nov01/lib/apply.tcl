##############################################################################
# apply.tcl - procedures for displaying callbacks tied to a particular widget.
#
# Copyright (C) 2018 Donald Rozenberg
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

# vTclWindow.vTcl.apply
# Scrolled_EntrySet

# This module implements the stash and apply function.
proc vTcl:stash_config {} {
    # Arrived here from the widget context menu.
    # We read, store, and display the configuration of the selected
    # widget.
    global vTcl
    vTclWindow.vTcl.apply
    update
    #raise $::vTcl(gui,apply)
}

proc vTcl:apply_config {widget} {
    # Called to apply selected defaults to current widget.
    global vTcl
    if {![info exist vTcl(canvas,entries)]} {return}
    if {[string first ".bor" $widget] > -1} {
        # since current widget is in borrowee.
        return
    }
    # Get list of option that apply to this widget.
    set options_short_list [list]
    set options_list [$widget configure]
    foreach op $options_list {
        lappend options_short_list [lindex $op 0]
    }
    lappend options_short_list -x -y -width -height
    # Make sure apply widget differs from stash widget.
    if {$widget == $vTcl(stash_widget)} {
        return ;# Just return, don't bother with a warning message.
        ::vTcl::MessageBox -icon warning -type ok -title "Warning"  \
            -message "Applying options to same widget stash was from."
       #tk_dialog .foo "Warning" "Cannot apply to same widget stash was from." \
            warning 0 "OK"
        return
    }
    vTcl:destroy_handles
    set canvas_frame $vTcl(gui,apply).cpd21.03.f
    set limit  $vTcl(canvas,entries)   ;# [expr $vTcl(canvas,entries) - 1]
    for {set i 0} {$i < $limit} {incr i} {
        if {$vTcl(ck,ck$i)} {
            set option [$canvas_frame.option$i cget -text]
            # See if option applies to this widget.
            if {$option ni $options_short_list} {
                continue }
            set value [$canvas_frame.value$i cget -text]
            set target $widget
            # Switch borrowed from vTcl:prop:geom_config_mgr in propmgr.tcl
            vTcl:convert_for_geom_option $widget $option
            switch -exact $option {
                -relx {
                    place configure $target $option $value -x 0
                    #set $variable $value
                }
                -rely {
                    place configure $target $option $value -y 0
                }
                -relwidth {
                    place configure $target $option $value -width 0
                }
                -relheight {
                    place configure $target $option $value -height 0
                }
                -width {
                    place configure $target $option $value -relwidth 0
                }
                -height {
                    place configure $target $option $value -relheight 0
                }
                -x {
                    place configure $target $option $value -relx 0
                }
                -y {
                    place configure $target $option $value -rely 0
                }
                default {
                    # For non geometric options.
                    $widget configure $option $value
                }
            }
            #$widget configure $option $value
        }
    } ;# end for loop
    update
    #vTcl:select_widget $widget
    #vTcl:prop:update_attr
    vTcl:create_handles $widget
    set w_mode [vTcl:get_mode $widget]
    if {$w_mode ne $vTcl(mode)} {
        vTcl:convert_widget $widget
    }
};# end vTcl:apply_config

proc vTcl:apply_default {widget} {
    # from menu to here to set defaults of current widget.
    global vTcl
    if {![info exist vTcl(canvas,entries)]} {return}
    if {[string first ".bor" $widget] > -1} {
        # This test because we may have selected a widget in borrowee.
        return
    }
    vTcl:destroy_handles
    set canvas_frame $vTcl(gui,apply).cpd21.03.f
    set limit  $vTcl(canvas,entries)      ;# [expr $vTcl(canvas,entries) - 1]
    for {set i 0} {$i < $limit} {incr i} {
        if {$vTcl(ck,ck$i)} {
            set option [$canvas_frame.option$i cget -text]
            #set value [$canvas_frame.value$i cget -text]
            #$widget configure $option $value
            #  w opt varName {user_param {}}
            vTcl:prop:default_opt $widget $option  vTcl(w,opt,$option)
        }
    } ;# end for loop
    vTcl:select_widget $widget
    vTcl:prop:update_attr
    vTcl:create_handles $widget
    update
} ;# end vTcl:apply_default


proc vTcl:apply_toplevel {w extent {action {}}} {
    # Applies the selected options to appropriate widgets based on the
    # extent, which can be "toplevel" or "frame". It works by building
    # a call to vTcl:prop:apply_opt located in propmgr.tcl. An example
    # of the argument list follows.

    # Updated to handle extent "multi".

    #args: w opt varName extent action user_param
    # w = .top42.but44
    # opt = -font
    # varName = vTcl(w,opt,-font)
    # extent = toplevel
    # action = vTcl:prop:set_opt
    # user_param = font12
    global vTcl
    # Since the widgets may move get rid of handles for old location.
    vTcl:multi_destroy_handles
    if {![info exist vTcl(canvas,entries)]} {return}
    set canvas_frame $vTcl(gui,apply).cpd21.03.f
    set limit  $vTcl(canvas,entries) ;# [expr $vTcl(canvas,entries) - 1]
    # Loop over all entries in Apply window.
    for {set i 0} {$i < $limit} {incr i} {
        # Act on only those selected.
        if {$vTcl(ck,ck$i)} {
            set option [$canvas_frame.option$i cget -text]
            set value [$canvas_frame.value$i cget -text]
            set varName "vTcl(w,opt,$option)"
            #set action "vTcl:prop:set_opt"
            vTcl:prop:apply_opt $w $option $varName $extent $action $value
        }
    } ;# end for loop
} ;# end vTcl:apply_toplevel


proc vTcl:check_selection {val} {
    # Turns selects either all on or all off, i.e., specifically the
    # checkboxes.
    global vTcl
    if {![info exist vTcl(canvas,entries)]} {return}
    set canvas_frame $vTcl(gui,apply).c.canvas.f
    set limit [expr $vTcl(canvas,entries) - 1]
    set limit $vTcl(canvas,entries) ;# [expr $vTcl(canvas,entries) - 1]
    for {set i 0} {$i < $limit} {incr i} {
        set vTcl(ck,ck$i) $val
    }
} ;# end check_selection

proc vTclWindow.vTcl.apply {args} {
    # Builds the apply window. and call routine to populate it.
    global vTcl
    set base .vTcl.apply
    set top $base
    # if { [winfo exists $base] } {
    #     wm deiconify $base; return }
    if { [winfo exists $base] } {
        set vTcl(canvas,entries) 0
        destroy $base}
    toplevel $base -class Toplevel ;# -menu $base.m22
    wm transient $base .vTcl
    wm withdraw $base
    wm focusmodel $base passive
    wm geometry $base 350x200+100+200
    #wm maxsize $base 1137 870
    wm minsize $base 200 100
    wm resizable $base 1 1
    wm overrideredirect $base 0
    wm title $base "Widget Configuration"
    catch {wm geometry $base $vTcl(geometry,$base)}
    wm protocol $base WM_DELETE_WINDOW {wm withdraw .vTcl.apply}


    # Create a frame for buttons,
    set f [frame $top.buttons -bd 2]
    # button $f.apply -text Apply -command vTcl:apply_config
    menubutton $f.apply -text Apply -bg $vTcl(actual_bg) \
        -fg $vTcl(actual_fg) -menu "$f.apply.menu"

    set apply_m [menu $f.apply.menu -tearoff 0]
    #Apply submenu
    $apply_m add cascade \
        -menu "$apply_m.def" -label "Reset to default"
    $apply_m add cascade \
        -menu "$apply_m.prop" -label "Apply to"

    # Apply default submenu
    set def_m [menu $apply_m.def -tearoff 0]
    $def_m add command \
        -command {vTcl:apply_default $vTcl(w,widget)} \
        -label {Current Widget}
    $def_m add command \
        -command "vTcl:apply_toplevel $vTcl(w,widget) all \
                     vTcl:prop:default_opt" \
        -label {All widgets in Toplevel}
    $def_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) subwidgets \
                      vTcl:prop:default_opt} \
        -label {All subwidgets of current widget}
    $def_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) toplevel \
                      vTcl:prop:default_opt} \
        -label {All same class in Toplevel}
    $def_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) frame \
                      vTcl:prop:default_opt} \
        -label {All same class in same parent}

    # Apply propagate submenu
    set prop_m [menu $apply_m.prop -tearoff 0]
    $prop_m add command \
        -command {vTcl:apply_config $vTcl(w,widget)} \
        -label {Current Widget}
    $prop_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) multi \
                      vTcl:prop:set_opt} \
        -label {All widgets in Multi Selection}
    $prop_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) all vTcl:prop:set_opt} \
        -label {All widgets in Toplevel}
    $prop_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) subwidgets \
                      vTcl:prop:set_opt} \
        -label {All subwidgets of current widget}
    $prop_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) toplevel \
                      vTcl:prop:set_opt} \
       -label {All same class in Toplevel}
    $prop_m add command \
        -command {vTcl:apply_toplevel $vTcl(w,widget) frame \
                      vTcl:prop:set_opt} \
        -label {All same class in same parent}

    # Select menubutton

    menubutton $f.select -text Select -bg $vTcl(actual_bg) \
        -fg $vTcl(actual_fg) -menu "$f.select.menu"

    # Select submenu
    set smenu  [menu $f.select.menu -tearoff 0]
    $smenu add command \
        -command {
            vTcl:check_selection 1} \
        -label {Select All}
    $smenu add command \
        -command {
            vTcl:check_selection 0} \
        -label {Clear All}

    # # Pick Widget menubutton
    # menubutton $f.pick -text "Pick Widgets" -bg $vTcl(actual_bg) \
    #     -fg $vTcl(actual_fg) -menu "$f.pick.menu"

    # # Pick Widget submenu
    # set smenu  [menu $f.pick.menu -tearoff 0]
    # $smenu add command \
    #     -command {
    #         vTcl:multi_selection 1} \
    #     -label {Select Widgets}
    # $smenu add command \
    #     -command {
    #         vTcl:multi_selection 0} \
    #     -label {Clear Picks}

    #::vTcl::OkButton $f.buttonClose -command "Window hide $base"
    ::vTcl::CancelButton $f.buttonClose\
        -command "
           set ::vTcl(geometry,.vTcl.apply) [wm geometry .vTcl.apply]
           wm withdraw $base"
    vTcl:set_balloon $f.buttonClose "Close window."
    pack  $f.apply -side left
    pack  $f.select -side left
    #pack  $f.pick -side left
    pack $f -side top -fill x
    pack $f.buttonClose \
         -expand 0 -fill none -side right

    # Create a scrolling canvas

    ScrolledWindow $base.cpd21
    canvas $base.cpd21.03 -highlightthickness 0 \
       -borderwidth 0 \
        -closeenough 1.0 -relief flat -borderwidth 0
       #-background #d9d9d9
    $base.cpd21 setwidget $base.cpd21.03

    pack $base.cpd21 \
        -in $base -anchor center -expand 1 -fill both -side top

    catch {wm geometry $vTcl(gui,apply) $vTcl(geometry,$vTcl(gui,apply))}

    bind $base.cpd21.03 <Enter> \
        {vTcl:bind_mousewheel  $::vTcl(gui,apply).cpd21.03}
    bind $base.cpd21.03 <Leave> \
        {vTcl:unbind_mousewheel $::vTcl(gui,apply).cpd21.03}

    vTcl:setup_vTcl:bind $base      ;# Allows <Control-Q> to exit PAGE
    update idletasks
    wm deiconify $vTcl(gui,apply)

    Scrolled_EntrySet $base.cpd21.03
}

proc Scrolled_EntrySet { canvas } {
    # Fill in window with the options of the selected widget. Only
    # options with values which differ from the Tk defaults are
    # listed. Note that the Tk defaults may differ from those set by
    # the user using the Preferences Window.
    global vTcl
    # Create one frame to hold everything
    # and position it on the canvas
    set f [frame $canvas.f -bd 0]
    $canvas create window 0 0 -anchor nw -window $f
    # Create and grid the labeled entries
    set widget $vTcl(w,widget)   ;# Determines selected widget.
    set vTcl(stash_widget) $widget
    if {$widget == ""} { return }
    if {$vTcl(w,class) eq "Toplevel"} { return }
    set i 0
    set j 0
    set opt [$widget configure]
    foreach op $opt {
        foreach {o x y d v} $op {}
        set v [string trim $v]
        if {$d == $v && $o ne "-orient"} {
            continue   ;# If value == default value bail.
        }
        incr vTcl(canvas,entries)
        label $f.option$i -text $o -bg #d3d3d3 -fg black
        label $f.value$i -text $v -bg #d3d3d3 -fg black
        checkbutton $f.check$i -pady 0 -variable vTcl(ck,ck$i) -bg #d3d3d3
        grid $f.option$i $f.value$i $f.check$i
        grid $f.option$i -sticky w
        grid $f.value$i -sticky we
        grid $f.check$i -sticky news
        lappend op_list $v
        incr i
    }
    if {[info exists op_list]} {
        foreach op [list -width -height -x -y] {
            set o $op
            set v  $vTcl(w,place,$op)
            if {[lsearch -exact $op_list $v] > -1} {
                continue
            }
            incr vTcl(canvas,entries)
            label $f.option$i -text $o -bg #d3d3d3 -fg black
            label $f.value$i -text $v -bg #d3d3d3 -fg black
            checkbutton $f.check$i -pady 0 -variable vTcl(ck,ck$i) -bg #d3d3d3
            grid $f.option$i $f.value$i $f.check$i
            grid $f.option$i -sticky w
            grid $f.value$i -sticky we
            grid $f.check$i -sticky news
            incr i
        }
    }
    set child $f.value0

    # Wait for the window to become visible and then
    # set up the scroll region based on
    # the requested size of the frame, and set
    # the scroll increment based on the
    # requested height of the widgets
    tkwait visibility $child
    set bbox [grid bbox $f 0 0]
    set incr [lindex $bbox 3]
    set width [winfo reqwidth $f]
    set height [winfo reqheight $f]
    $canvas config -scrollregion "0 0 $width $height"
    $canvas config -yscrollincrement $incr
    set max [llength $opt]
    if {$max > 10} {
        set max 10
    }
    set height [expr $incr * $max]
    $canvas config -width $width -height $height
    $canvas.f config -background #d9d9d9
}

########################################
# Functions need for Mousewheel support.
########################################

proc shiftwheelEvent { x y delta canvas {os ""}} {
    set act 0
    # Make sure we've got a vertical scrollbar for this widget
    if {[catch "$canvas cget -yscrollcommand" cmd]} return
    if {$canvas == ""} return
    if {$os == "MS"} {
        # I am assuming that we are running under MS Windows.
        # if {$cmd != ""} {
        #     # Find out the scrollbar widget we're using
        #     set scroller [lindex $cmd 0]

        #     # Make sure we act
        #     set act 1
        # }

        # Now we know we have to process the wheel mouse event
        set xy [$canvas xview]
        set factor [expr [lindex $xy 1]-[lindex $xy 0]]
        # Make sure we activate the scrollbar's command
        set cmd "$canvas xview scroll [expr -int($delta/(120*$factor))] units"
    } else {
        # we are on Linux
        set cmd "$canvas xview scroll $delta units"

    }
    eval $cmd
}

proc wheelEvent { x y delta canvas {os ""}} {
    set act 0
    # Make sure we've got a vertical scrollbar for this widget
    if {[catch "$canvas cget -yscrollcommand" cmd]} return
    if {$canvas == ""} return
    if {$os == "MS"} {
        # I am assuming that we are running under MS Windows.
        # if {$cmd != ""} {
        #     # Find out the scrollbar widget we're using
        #     set scroller [lindex $cmd 0]

        #     # Make sure we act
        #     set act 1
        # }

        # Now we know we have to process the wheel mouse event
        set xy [$canvas xview]
        set factor [expr [lindex $xy 1]-[lindex $xy 0]]
        # Make sure we activate the scrollbar's command
        set cmd "$canvas yview scroll [expr -int($delta/(120*$factor))] units"
    } else {
        # we are on Linux
        set cmd "$canvas yview scroll $delta units"

    }
    eval $cmd
}

proc vTcl:bind_mousewheel {widget} {
    bind all <MouseWheel> "+wheelEvent %X %Y %D $widget MS"
    bind all <Button-4> "+wheelEvent %X %Y -1 $widget"
    bind all <Button-5> "+wheelEvent %X %Y 1 $widget"

    bind all <Shift-MouseWheel> "+shiftwheelEvent %X %Y %D $widget MS"
    bind all <Shift-Button-4> "+shiftwheelEvent %X %Y -1 $widget"
    bind all <Shift-Button-5> "+shiftwheelEvent %X %Y 1 $widget"
}


proc vTcl:unbind_mousewheel {widget} {
    bind all <MouseWheel> { }
    bind all <Button-4> { }
    bind all <Button-5> { }

    bind all <Shift-MouseWheel> { }
    bind all <Shift-Button-4> { }
    bind all <Shift-Button-5> { }
}

proc vTcl:show_apply {} {
    global vTcl
    Window show .vTcl.apply
    wm geometry .vTcl.apply $vTcl(geometry,.vTcl.apply)
}
