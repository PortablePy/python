##############################################################################
# $Id: dragsize.tcl,v 1.17 2001/12/08 05:53:44 cgavin Exp $
#
# dragsize.tcl - procedures to handle widget sizing and movement
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

# vTcl:bind_button_1
# vTcl:bind_button_multi
# vTcl:bind_motion
# vTcl:grab
# vTcl:grab_motion
# vTcl:grab_motion_multi
# vTcl:grab_resize         Where place is invoked to place widget with new size.
# vTcl:adjust_widget_size
# vTcl:resize_tseparator
# vTcl:bind_release
# vTcl:bind_release_multi
# vTcl:bind_motion_ctrl
# vTcl:bind_motion_ctrl_B2
# vTcl:widget_delta

set vTcl(cursor,w) ""

proc vTcl:store_cursor {target} {
    global vTcl
    ## only store cursor once
    if {$vTcl(cursor,w) == ""} {
        set vTcl(cursor,last) ""
        set vTcl(cursor,w) $target
        catch {set vTcl(cursor,last) [$target cget -cursor]}
    }
}

proc vTcl:restore_cursor {target} {
    global vTcl
    ## only restore cursor once
    if {$vTcl(cursor,w) != "" && [winfo exists $vTcl(cursor,w)]} {
        catch {$vTcl(cursor,w) configure -cursor $vTcl(cursor,last)}
    }
    set vTcl(cursor,w) ""
}

# Rozen Many of these bindings are specified in ../page.tcl
proc vTcl:bind_button_1 {target X Y x y} {
    global vTcl
    update

    if {[info exists vTcl(multi_select_widget)] \
            && $target in $vTcl(multi_select_widget)} {
        set vTcl(multi_select_widget) ""
    }
    vTcl:set_mouse_coords $X $Y $x $y
    set parent [winfo parent $target]
    set parent_class [winfo class $parent]
    if {[string first  "Scroll" $parent_class] > -1} { ;# Rozen 9/2/16
        vTcl:bind_button_top $target $X $Y $x $y
        return
    }
    set parent $target

    # Megawidget ?
    if {[vTcl:WidgetVar $target parent tmp]} { set parent $tmp }

    if {[lindex [split %W .] 1] == "vTcl"} { return }

    set vTcl(cursor,inside_button_1) 1
    #lappend  vTcl(multi_select_list) $parent ;# Multiple selection 11/2/19

    # vTcl:active_widget calls select_widget which calls
    # vTcl:update_widget_info
    vTcl:active_widget $parent
    set vTcl(remove_all_multi) 0 ;# new ;# Remove from Widget Tree.
    if {$parent != "." && [winfo class $parent] != "Toplevel"} {
        vTcl:grab $target $X $Y
        vTcl:store_cursor $target
        catch {$target configure -cursor fleur}
    } else {
        vTcl:store_cursor $target
    }
    set vTcl(cursor,inside_button_1) 0
    #set vTcl(multi_select_list) [list]  ;# moved from top if because
                                         # always want it erased AFTER
                                         # updating widget tree.
    set vTcl(first_time) 1
    update
}

proc vTcl:bind_button_2 {target X Y x y} {
    # Rozen. Think that I no longer am using this function.
    # global vTcl[lindex [split %W .] 1]
    global vTcl
    vTcl:set_mouse_coords $X $Y $x $y
    set parent $target
    set parent_class [winfo class $parent]
    if {$parent_class == "Scrollbar"} {  ;# Rozen 9/2/16
        vTcl:grab $target $X $Y
        vTcl:store_cursor $parent
        catch {$parent configure -cursor fleur}
        return
    }
    # Megawidget ?
    if {[vTcl:WidgetVar $target parent tmp]} { set parent $tmp }
    vTcl:active_widget $parent
    if {$vTcl(w,widget) != "." && \
        [winfo class $vTcl(w,widget)] != "Toplevel" && \
        $vTcl(w,widget) != ""} {
        vTcl:grab $target $X $Y
        vTcl:store_cursor $target
        catch {$target configure -cursor fleur}
    }
}

proc  vTcl:bind_motion_ctrl {W x y} {
    # Added to try and find out if the event included the control
    # button in the case where the widget was a component of a paned
    # window or a notebook.
    global vTcl
    set ctrl 1
    set widget $vTcl(w,widget) ;# The whole widget even if you select a tab
    set parent [winfo parent $widget]
    set parent_class [winfo class $parent]
    if {$parent_class == "TPanedwindow"} { return}
    vTcl:bind_motion $widget $x $y $ctrl ;# Pass the top level of the widget.
}

proc  vTcl:bind_motion_ctrl_B2 {W x y} {
    # Added to try and find out if the event included the control
    # button in the case where the widget was a component of a paned
    # window or a notebook.
    global vTcl
    set ctrl 1
    # set widget $vTcl(w,widget) ;# The whole widget even if you select a tab
    # set parent [winfo parent $widget]
    set parent [winfo parent $W]
    set parent_class [winfo class $parent]
    if {$parent_class == "TPanedwindow"} { return}
    vTcl:bind_motion $W $x $y $ctrl
}

proc vTcl:bind_motion {W x y {ctrl 0} {multi ""}} {
    # This function is a callback from <B1-Motion> or <B2-Motion>
    # bound in page.tcl. Basically functions determines if the
    # selected widget can be moved.
    global vTcl
    set widget $W
    set w_c [winfo class $widget]
    if {$w_c eq "Toplevel"} { return }
    if {$w_c eq "TSizegrip"} { return }
    if {[info exists ::widgets::${widget}::locked] &&
        [set ::widgets::${widget}::locked]} {
        return
    }
    set parent [winfo parent $widget]
    set parent_class [winfo class $parent]
    if {![vTcl:is_geom_fluid $widget]} {return}
    if {$vTcl(w,class) == "Frame" && $parent_class == "TNotebook"} {return}
    if {$vTcl(w,class) == "Frame" && $parent_class == "PNotebook"} {return}
    if {$widget != "." && $vTcl(w,class) != "Toplevel"} {
        if {$ctrl == 0} {
            #set widget $vTcl(w,widget)
            set parent [winfo parent $widget]
            if {$parent_class == "TPanedwindow"} { return}
        }

        # Now for actual moving of the widget.
        if {[info exists vTcl(multi_select_widget)] && \
                $W ni $vTcl(multi_select_widget)} {
            vTcl:grab_motion $vTcl(w,widget) $W $x $y
            return
        }
        if { ![info exists vTcl(multi_select_widget)] ||
               $vTcl(multi_select_widget) eq ""} {    ;# test added 3/6/20
            if {$vTcl(first_time) == 1} {
                vTcl:prepare_undo_geom [list $W] "geom_s"
                set vTcl(first_time) 0
            }
            vTcl:grab_motion $vTcl(w,widget) $W $x $y
        } else {
            vTcl:grab_motion_multi  $W $x $y
        }
    }
}

proc vTcl:bind_motion_multi {W x y} {
    # Result of <B2-Motion> event. Set in page.tcl
    global vTcl
    set widget $W
    set w_c [winfo class $widget]
    if {$w_c eq "TSizegrip"} { return }
    if {$w_c eq "toplevel"} { return }
    if {$vTcl(multi_select_widget) eq ""} {
        vTcl:bind_button_multi $W 0 0 0 0
    }
    if {$vTcl(multi_select_widget) eq ""} { return }
    if {$vTcl(first_time) == 1} {
        set vTcl(widget_list) [vTcl:find_common_parent]
        vTcl:prepare_undo_geom $vTcl(widget_list)
        set vTcl(first_time) 0
    }
    vTcl:grab_motion_multi  $W $x $y
}

proc vTcl:bind_button_top {target X Y x y} {
    # What I want to do here is to bind <Control-Button-1> to the top
    # widget of a complex widget like a notebook not one of the inside
    # widgets. The problem is to recognize the right widget. Rozen
    global vTcl
    vTcl:set_mouse_coords $X $Y $x $y
    # See if parent is child of complex_class.
    set parent [winfo parent $target]
    if {$target != "" &&
        [lsearch $vTcl(complex_class) [winfo class $parent]] > -1} {
        set w $parent
    } else {
        set w $target
    }
    set vTcl(cursor,inside_button_1) 1
    vTcl:active_widget $w
    if {$w != "." && [winfo class $w] != "Toplevel"} {
        vTcl:active_widget $w
        vTcl:grab $w $X $Y
        #set vTcl(cursor,last) [$w cget -cursor]
        vTcl:store_cursor $w
        catch {$w configure -cursor fleur}
    } else {
        vTcl:store_cursor $w
    }
    set vTcl(cursor,inside_button_1) 0
}

proc vTcl:bind_button_container {target X Y x y} {
    # Bind <Shift-Button-1> to the containing widget. Particularly
    # useful when a widget has been expanded to fill the contain and
    # otherwise it is impossible to grab the container and move or
    # resize it. Just run back up the hierarchy 'till we find a
    # container widget.
    global vTcl
    vTcl:set_mouse_coords $X $Y $x $y
    set parent [winfo parent $target]
    set class [vTcl:get_class $parent]
    set container "Frame Labelframe TFrame TLabelFrame Toplevel"
    while {[string first $class $container] == -1} {
        set parent [winfo parent $parent]
        set class [vTcl:get_class $parent]
    }
    vTcl:active_widget $parent
}

proc vTcl:bind_release {W X Y x y} {
    # We come here upon the event <ButtonRelease-1>
    global vTcl
    if {[info exist vTcl(cursor,inside_button_1)] &&
        $vTcl(cursor,inside_button_1)} {
        after 500 "vTcl:bind_release $W $X $Y $x $y"
        return
    }
    vTcl:set_mouse_coords $X $Y $x $y
    if {$vTcl(w,widget) == ""} {return}
    vTcl:restore_cursor $W
    # Use vTcl(w,widget) below instead of W because cursor may be inside
    # complex widget.
    vTcl:place_handles $vTcl(w,widget)
    vTcl:grab_release $W
    vTcl:update_widget_info $vTcl(w,widget)
}

proc vTcl:bind_motion_multi {W x y} {
    # Result of <B2-Motion> event. Set in page.tcl
    global vTcl
    set widget $W
    set w_c [winfo class $widget]
    if {$w_c eq "TSizegrip"} { return }
    if {$w_c eq "toplevel"} { return }
    if {$vTcl(multi_select_widget) eq ""} {
        vTcl:bind_button_multi $W 0 0 0 0
    }
    if {$vTcl(multi_select_widget) eq ""} { return }
    if {$vTcl(first_time) == 1} {
        set vTcl(widget_list) [vTcl:find_common_parent]
        vTcl:prepare_undo_geom $vTcl(widget_list)
        set vTcl(first_time) 0
    }
    vTcl:grab_motion_multi  $W $x $y
}

proc vTcl:bind_button_top {target X Y x y} {
    # What I want to do here is to bind <Control-Button-1> to the top
    # widget of a complex widget like a notebook not one of the inside
    # widgets. The problem is to recognize the right widget. Rozen
    global vTcl
    vTcl:set_mouse_coords $X $Y $x $y
    # See if parent is child of complex_class.
    set parent [winfo parent $target]
    if {$target != "" &&
        [lsearch $vTcl(complex_class) [winfo class $parent]] > -1} {
        set w $parent
    } else {
        set w $target
    }
    set vTcl(cursor,inside_button_1) 1
    vTcl:active_widget $w
    if {$w != "." && [winfo class $w] != "Toplevel"} {
        vTcl:active_widget $w
        vTcl:grab $w $X $Y
        #set vTcl(cursor,last) [$w cget -cursor]
        vTcl:store_cursor $w
        catch {$w configure -cursor fleur}
    } else {
        vTcl:store_cursor $w
    }
    set vTcl(cursor,inside_button_1) 0
}

proc vTcl:bind_button_container {target X Y x y} {
    # Bind <Shift-Button-1> to the containing widget. Particularly
    # useful when a widget has been expanded to fill the contain and
    # otherwise it is impossible to grab the container and move or
    # resize it. Just run back up the hierarchy 'till we find a
    # container widget.
    global vTcl
    vTcl:set_mouse_coords $X $Y $x $y
    set parent [winfo parent $target]
    set class [vTcl:get_class $parent]
    set container "Frame Labelframe TFrame TLabelFrame Toplevel"
    while {[string first $class $container] == -1} {
        set parent [winfo parent $parent]
        set class [vTcl:get_class $parent]
    }
    vTcl:active_widget $parent
}

proc vTcl:bind_release {W X Y x y} {
    # We come here upon the event <ButtonRelease-1>
    global vTcl
    if {[info exist vTcl(cursor,inside_button_1)] &&
        $vTcl(cursor,inside_button_1)} {
        after 500 "vTcl:bind_release $W $X $Y $x $y"
        return
    }
    vTcl:set_mouse_coords $X $Y $x $y
    if {$vTcl(w,widget) == ""} {return}
    vTcl:restore_cursor $W
    # Use vTcl(w,widget) below instead of W because cursor may be inside
    # complex widget.
    vTcl:place_handles $vTcl(w,widget)
    vTcl:grab_release $W
    vTcl:update_widget_info $vTcl(w,widget)
    set vTcl(first_time) 1     ;# 4/2/20
}

proc vTcl:bind_release_multi {W X Y x y} {
    # We come here upon the event <ButtonRelease-2>
    global vTcl
    if {[info exist vTcl(cursor,inside_button_1)] &&
        $vTcl(cursor,inside_button_1)} {
        after 500 "vTcl:bind_release_multi $W $X $Y $x $y"
        return
    }
    set parent [winfo parent $W]
    set parent_class [vTcl:get_class $parent]
    if {$parent_class in $vTcl(complex_class)} {
        set W $parent
    }
    vTcl:set_mouse_coords $X $Y $x $y
    #if {$vTcl(w,widget) == ""} {return}
    #vTcl:restore_cursor $W   ;# NEEDS WORK  to use special cursor.
    # vTcl:place_handles $vTcl(w,widget)
    #vTcl:place_handles $W
    #vTcl:multi_place_handles $W
    vTcl:replace_all_multi_handles
    vTcl:grab_release $W
    # vTcl:update_widget_info $vTcl(w,widget)
    vTcl:update_widget_info $W
    #set vTcl(multi_select_widget) "" ;# 3/27/20
    set vTcl(first_time) 1     ;# 4/2/20
}

proc vTcl:bind_release_multi {W X Y x y} {
    # We come here upon the event <ButtonRelease-2>
    global vTcl
    if {[info exist vTcl(cursor,inside_button_1)] &&
        $vTcl(cursor,inside_button_1)} {
        after 500 "vTcl:bind_release_multi $W $X $Y $x $y"
        return
    }
    set parent [winfo parent $W]
    set parent_class [vTcl:get_class $parent]
    if {$parent_class in $vTcl(complex_class)} {
        set W $parent
    }
    vTcl:set_mouse_coords $X $Y $x $y
    #if {$vTcl(w,widget) == ""} {return}
    #vTcl:restore_cursor $W   ;# NEEDS WORK  to use special cursor.
    # vTcl:place_handles $vTcl(w,widget)
    #vTcl:place_handles $W
    #vTcl:multi_place_handles $W
    vTcl:replace_all_multi_handles
    vTcl:grab_release $W
    # vTcl:update_widget_info $vTcl(w,widget)
    vTcl:update_widget_info $W
    set vTcl(multi_select_widget) "" ;# 3/27/20
    set vTcl(first_time) 1
}

proc vTcl:grab {widget absX absY} {
    global vTcl
    grab $widget
    set vTcl(w,didmove) 0
    set vTcl(w,grabbed) 1
    set vTcl(grab,startX) [vTcl:grid_snap x $absX]
    set vTcl(grab,startY) [vTcl:grid_snap y $absY]
}

proc vTcl:moving_pane {parent widget x y} {
    # Rozen. Written to facilitate pane specification when a pane is moved.
    global vTcl
    set panes [$parent panes]
    set pane_index [lsearch $panes $widget]
    set o [$parent cget -orient]
    set no_panes [llength $panes]
    set no_sashes [expr $no_panes -1]
    # Determine if pane is an interior pane.
    if {$pane_index > 0 && $pane_index < [expr $no_panes - 1]} {
        update idletasks
        if {$o == "horizontal"} {
            set old_pos1 [$parent sashpos [expr $pane_index - 1]]
            $parent sashpos [expr $pane_index - 1] $x
            set diff [expr $x - $old_pos1]
            $parent sashpos $pane_index [expr $x  + $vTcl(w,width)]

        } else {
            # vertical paned window.
            set old_pos1 [$parent sashpos [expr $pane_index - 1]]
            set diff [expr $y - $old_pos1]
            $parent sashpos [expr $pane_index - 1] $y
            $parent sashpos $pane_index [expr $y  + $vTcl(w,height)]
        }
        vTcl::widgets::ttk::panedwindow::resizeAdjacentPanes \
            $parent $widget $pane_index $o $diff
    }
    update idletasks
}

proc vTcl:grab_motion {parent widget absX absY} {
    # parent designates a megawidget, widget is the
    # child (if any) being dragged
    global vTcl
    set vTcl(w,didmove) 1
    # workaround for Tix
    if { $vTcl(w,grabbed) == 0 } {
        vTcl:grab $widget $absX $absY
    }
    if {[regexp {\.[pt][0-9]+$} $widget]} {
        return
    }
    # if {![vTcl:is_geom_fluid $vTcl(w,widget)]} {return}
    if {![vTcl:is_geom_fluid $widget]} {return}
    set pparent [winfo parent $widget] ;# Don't know what the arg parent is???
    set parent_class [winfo class $pparent]
    #if {$parent_class == "TNotebook" && $w_c == "Frame"} { return }
    #if {$parent_class == "TPanedwindow"} { return }
    # Detect that this is a window pane using parent_class above.
    # Then don't place it just adjust the appropiate sashes.  Rozen
    # if {$parent_class == "TPanedwindow"} {
    #     # Do the pane thing
    #     set newX [vTcl:grid_snap x \
    #             [expr {$absX-$vTcl(grab,startX)+$vTcl(w,x)}]]
    #     set newY [vTcl:grid_snap y \
    #             [expr {$absY-$vTcl(grab,startY)+$vTcl(w,y)}]]
    #     vTcl:moving_pane $pparent $widget $newX $newY
    #     vTcl:place_handles $parent
    #     return
    # }
    if { $vTcl(w,manager) == "place" } {
        place $parent \
            -x [vTcl:grid_snap x \
                    [expr {$absX-$vTcl(grab,startX)+$vTcl(w,x)}]] -relx 0 \
            -y [vTcl:grid_snap y \
                    [expr {$absY-$vTcl(grab,startY)+$vTcl(w,y)}]] -rely 0
        update
        vTcl:relative_place $parent
    }
    vTcl:place_handles $parent
}  ;#  vTcl:grab_motion

proc vTcl:grab_motion_multi {widget absX absY} {
    # parent designates a megawidget, widget is the
    # child (if any) being dragged
    global vTcl
    set vTcl(w,didmove) 1
    # workaround for Tix
    if { $vTcl(w,grabbed) == 0 } {
        vTcl:grab $widget $absX $absY
    }
    # What we want to do first is see if target is actually a multi
    # select widget. if it is not see if the parent is a multi select
    # widget; if so set widget to parent.
    set vTcl(widget_list) [vTcl:find_common_parent]
    if {$widget ni $vTcl(widget_list)} {
        set parent [winfo parent $widget]
        if {$parent in $vTcl(widget_list)} {
            set widget $parent
        } else {
            return
        }
    }
    set x_delta [expr {$absX-$vTcl(grab,startX)}]
    set y_delta [expr {$absY-$vTcl(grab,startY)}]
    vTcl:destroy_handles
    vTcl:multi_destroy_handles
    if {![info exists vTcl(multi,$widget,x)]} {
        # Guessing that we got here without having gone thru
        # vTcl:bind_button_multi. This is meant to address a rare bug
        # where we get here at all.
        vTcl:bind_button_multi $widget 0 0 0 0
    }
    foreach widget $vTcl(widget_list) {
        set w_class [vTcl:get_class $widget]
        if {$w_class eq "TSizegrip"} { continue }
        set wx $vTcl(multi,$widget,x)
        set wy $vTcl(multi,$widget,y)
            place $widget \
                -x [vTcl:grid_snap x \
                        [expr {$x_delta+$wx}]] -relx 0 \
                -y [vTcl:grid_snap y \
                        [expr {$y_delta+$wy}]] -rely 0
        update
        vTcl:relative_place $widget
    }
    vTcl:replace_all_multi_handles
}

proc vTcl:grab_release {widget} {
    global vTcl
    grab release $widget
    set class [vTcl:get_class $widget]
    if {$class eq "Toplevel"} { return }
    set vTcl(w,grabbed) 0
    if { $vTcl(w,didmove) == 1 } {
        set vTcl(undo) [vTcl:dump_widget_quick $vTcl(w,widget)]
        vTcl:passive_push_action $vTcl(undo) $vTcl(redo)
    }
}

proc vTcl:grab_resize_ctrl {absX absY handle} {
    # We get her in response to <Control-B1-Motion>
    global vTcl classes
    set widget $vTcl(w,widget)
    set parent [winfo parent $widget]
    set parent_class [winfo class $parent]
    set ctrl 1
    vTcl:grab_resize $absX $absY $handle $ctrl

}

proc vTcl:resize_tseparator {widget absX absY handle} {
    # Handle the can of worms related to TSeparator.
    global vTcl classes
    global rel
    if {[info exists ::widgets::${widget}::locked] &&
        [set ::widgets::${widget}::locked]} {
        return
    }
    set parent_geometry [vTcl:parent_geometry $widget]
    set vTcl(w,didmove) 1
    set X [vTcl:grid_snap x $absX]
    set Y [vTcl:grid_snap y $absY]
    set deltaX [expr {$X - $vTcl(grab,startX)}]
    set deltaY [expr {$Y - $vTcl(grab,startY)}]
    set newX $vTcl(w,x)
    set newY $vTcl(w,y)
    set newW $vTcl(w,width)
    set newH $vTcl(w,height)
    set orientation [$widget cget -orient]
    switch $orientation {
        horizontal {
            switch $handle {
                e {
                    set newW [expr {$vTcl(w,width) + $deltaX}]
                }
                w {
                    set newW [expr {$vTcl(w,width) - $deltaX}]
                    set newX [expr {$vTcl(w,x) + $deltaX}]
                }
                s {
                    set newX [expr {$vTcl(w,x) + $deltaX}]
                    set newY [expr {$vTcl(w,y) + $deltaY}]
                }
            }
            if {$vTcl(actual_relative_placement)} {
                foreach {W H X Y} [split $parent_geometry "x+"] {}
                set relx [expr $newX / $W.0]
                set relx [expr {round($relx*1000)/1000.0}]
                set rely [expr $newY / $H.0]
                set rely [expr {round($rely*1000)/1000.0}]
                set relw [expr $newW / $W.0]
                set relw [expr {round($relw*1000)/1000.0}]
                place $widget -x 0 -y 0 -width 0 \
                         -relx $relx -rely $rely -relwidth $relw \
                         -bordermode ignore
            } else {
            place $widget -x $newX -y $newY -width $newW \
                -relx 0.0 -rely 0.0 -relwidth 0.0 -bordermode ignore
            }
        }
        vertical {
           switch $handle {
                n {
                    set newH [expr {$vTcl(w,height) - $deltaY}]
                    set newY [expr {$vTcl(w,y) + $deltaY}]
                }
                w {
                    set newX [expr {$vTcl(w,x) + $deltaX}]
                    set newY [expr {$vTcl(w,y) + $deltaY}]
                }
                s {
                    set newH [expr {$vTcl(w,height) + $deltaY}]
                }
           }
            if {$vTcl(actual_relative_placement)} {
                foreach {W H X Y} [split $parent_geometry "x+"] {}
                set relx [expr $newX / $W.0]
                set relx [expr {round($relx*1000)/1000.0}]
                set rely [expr $newY / $H.0]
                set rely [expr {round($rely*1000)/1000.0}]
                set relh [expr $newH / $H.0]
                set relh [expr {round($relh*1000)/1000.0}]
                place $widget -x 0 -y 0 -height 0 \
                    -relx $relx -rely $rely -relheight $relh \
                    -bordermode ignore
            } else {
            place $widget -x $newX -y $newY -height $newH \
               -relx 0.0 -rely 0.0 -relheight 0.0 -bordermode ignore
            }
        }
    }
    set vTcl($widget,x) $newX
    set vTcl($widget,y) $newY
    set vTcl($widget,height) $newH
    set vTcl($widget,width) $newW
    update
    vTcl:place_handles $widget
}

proc vTcl:resize_scale {widget absX absY handle} {
    # Handle the can of worms related to TSeparator.
    global vTcl classes
    if {[info exists ::widgets::${widget}::locked] &&
        [set ::widgets::${widget}::locked]} {
        return
    }
    set vTcl(w,didmove) 1
    set X [vTcl:grid_snap x $absX]
    set Y [vTcl:grid_snap y $absY]
    set deltaX [expr {$X - $vTcl(grab,startX)}]
    set deltaY [expr {$Y - $vTcl(grab,startY)}]
    set newX $vTcl(w,x)
    set newY $vTcl(w,y)
    set newW $vTcl(w,width)
    set newH $vTcl(w,height)
    set orientation [$widget cget -orient]
    switch $orientation {
        horizontal {
            switch $handle {
                ne -
                se -
                e {
                    set newW [expr {$vTcl(w,width) + $deltaX}]
                }
                nw -
                sw -
                w {
                    set newW [expr {$vTcl(w,width) - $deltaX}]
                    set newX [expr {$vTcl(w,x) + $deltaX}]
                }
            }
            place $widget -x $newX -y $newY -width $newW \
                -relx 0.0 -rely 0.0 -relwidth 0.0
        }
        vertical {
            switch $handle {
                ne -
                nw -
                n {
                    set newH [expr {$vTcl(w,height) - $deltaY}]
                    set newY [expr {$vTcl(w,y) + $deltaY}]
                }
               se -
               sw -
                s {
                    set newH [expr {$vTcl(w,height) + $deltaY}]
                }
            }
            place $widget -x $newX -y $newY -height $newH \
               -relx 0.0 -rely 0.0 -relheight 0.0 ;# -x 0 -y 0
        }
    }
    set vTcl($widget,x) $newX
    set vTcl($widget,y) $newY
    set vTcl($widget,height) $newH
    set vTcl($widget,width) $newW
    update
    vTcl:place_handles $widget
}

proc vTcl:grab_resize {absX absY handle {ctrl 0}} {
    # We get here in response to <B1-Motion> or from
    # vTcl:grab_resize_ctrl with ctrl = 1. <B1-Motion> is bound when
    # handles are created in handle.tcl.
    global vTcl classes
    if {![vTcl:is_geom_fluid $vTcl(w,widget)]} {return}
    set widget $vTcl(w,widget)
    if {[info exists ::widgets::${widget}::locked] &&
        [set ::widgets::${widget}::locked]} {
        return
    }
    set vTcl(w,didmove) 1
    set class [vTcl:get_class $widget]
    set parent_class  [vTcl:get_class [winfo parent $vTcl(w,widget)]]
    set skip 0
    if {$class eq "TSeparator"} {
        # So many special cases I will do it completely separately.
        vTcl:resize_tseparator $widget $absX $absY $handle
        return
    }
    # if {$class in {Scale TScale}} {
    #     vTcl:resize_scale $widget $absX $absY $handle
    #     return
    # }
    if {$vTcl(w,class) == "Frame" && $parent_class == "TNotebook"} {
        return
    }
    if {$vTcl(w,class) == "Frame" && $parent_class == "PNotebook"} {
        return
    }
    if {$vTcl(first_time) == 1} {
        if {$vTcl(w,class) == "TLabelframe" && $parent_class == "TPanedwindow"} {
            #set vTcl(undo_level) 0 ;# Kill all undo setup.
            #vTcl:destroy_undo
            set handle $vTcl(h,entered)
            vTcl:prepare_undo_sash $widget $handle
        } else {
            vTcl:prepare_undo_geom [list $widget] "geom_s"
        }
        set vTcl(first_time) 0
    }
    set X [vTcl:grid_snap x $absX]
    set Y [vTcl:grid_snap y $absY]
    set deltaX [expr {$X - $vTcl(grab,startX)}]
    set deltaY [expr {$Y - $vTcl(grab,startY)}]
    ## Can we resize this widget with this handle?
    set can [vTcl:can_resize $handle]
    if {$can == 0} { return }     ; ## We definitely can't resize.
    set newX $vTcl(w,x)
    set newY $vTcl(w,y)
    set newW $vTcl(w,width)
    set newH $vTcl(w,height)
    switch $handle {
        n {
            if {$can == 4} { return }
            set newY [expr {$vTcl(w,y) + $deltaY}]
            set newH [expr {$vTcl(w,height) - $deltaY}]
        }
        e {
            if {$can == 3} { return }
            set newW [expr {$vTcl(w,width) + $deltaX}]
        }
        s {
            if {$can == 4} { return }
            set newH [expr {$vTcl(w,height) + $deltaY}]
        }
        w {
            if {$can == 3} { return }
            set newX [expr {$vTcl(w,x) + $deltaX}]
            set newW [expr {$vTcl(w,width) - $deltaX}]
        }
        nw {
            if {$can == 1 || $can == 2} {
                set newX [expr {$vTcl(w,x) + $deltaX}]
                set newW [expr {$vTcl(w,width) - $deltaX}]
            }

            if {$can == 1 || $can == 3} {
                set newY [expr {$vTcl(w,y) + $deltaY}]
                set newH [expr {$vTcl(w,height) - $deltaY}]
            }
        }
        ne {
            if {$can == 1 || $can == 2} {
                set newW [expr {$vTcl(w,width) + $deltaX}]
            }

            if {$can == 1 || $can == 3} {
                set newY [expr {$vTcl(w,y) + $deltaY}]
                set newH [expr {$vTcl(w,height) - $deltaY}]
            }
        }
        se {
            if {$can == 1 || $can == 2} {
                set newW [expr {$vTcl(w,width) + $deltaX}]
            }

            if {$can == 1 || $can == 3} {
                set newH [expr {$vTcl(w,height) + $deltaY}]
            }
        }
        sw {
            if {$can == 1 || $can == 2} {
                set newX [expr {$vTcl(w,x) + $deltaX}]
                set newW [expr {$vTcl(w,width) - $deltaX}]
            }

            if {$can == 1 || $can == 3} {
                set newH [expr {$vTcl(w,height) + $deltaY}]
            }
        }
    }

    vTcl:actual_resize $widget $newX $newY $newW $newH $handle
    set vTcl($widget,x) $newX
    set vTcl($widget,y) $newY
    $classes($vTcl(w,class),resizeCmd) $widget $newW $newH $handle
    vTcl:place_handles $widget
    vTcl:replace_all_multi_handles
} ;# End of vTcl:grab_resize


## Default routine to adjust the size of a widget after it's been resized.
## This routine can be overridden in the widget definition.
proc vTcl:adjust_widget_size {widget w h {handle {}}} {
    # @@change by Christian Gavin 3/19/2000
    # added catch in case some widgets don't have a -width
    # or a -height option (for example Iwidgets toolbar)
    if {![winfo exists $widget]} { return }
    set class [winfo class $widget]
    #catch {
        switch $class {
            Label -
            Entry -
            Message -
            Spinbox -
            Scrollbar {
                $widget configure -width $w
            }
            TLabelframe {
                set parent_window [winfo parent $widget]
                set parent_class [winfo class $parent_window]
                    if {$parent_class == "TPanedwindow"} {
                        #vTcl::widgets::ttk::panedwindow::resizePane \
                        #       $parent_window $widget $w $h $handle
                        return
                    } else {
                        $widget configure -width $w
                        $widget configure -height $h
                    }
            }
            Scale -
            TScale {
                set orient [$widget cget -orient]
                if {$orient == "vertical"} {
                    $widget configure -length $h
                } else {
                    $widget configure -length $w
                }
            }
            TSeparator {
                set orient [$widget cget -orient]
                if {$orient == "vertical"} {
                    place configure $widget -height $h
                } else {
                    place configure $widget -width $w
                }
            }
            TPanedwindow {
                # Don't do anything.
            }
            TCheckbutton -
            TRadiobutton -
            TButton -
            TLabel -
            TEntry {
                $widget configure -width $w
            }
            TProgressbar {
                $widget configure -length $w
            }
            Treeview {
                $widget configure -height $h
            }
            TSpinbox {
                place configure $widget -height $h
                place configure $widget -width $w
            }
            default {
                $widget configure -height $h
                $widget configure -width $w
            }
        }
        #}  ;# End of catch
    update
    # @@end_change
}

## Can we resize this widget?
## 0 = no
## 1 = yes
## 2 = only horizontally
## 3 = only vertically

## classes($class,resizable)
## 0 = none
## 1 = both
## 2 = horizontal
## 3 = vertical

proc vTcl:can_resize {dir} {
    # determines whether a widget can be resized or not.
    global vTcl classes
    set c [vTcl:get_class $vTcl(w,widget)]
    set p_class  [vTcl:get_class [winfo parent $vTcl(w,widget)]]
    # Added the orientation stuff because the Scale and TScale can be
    # resized only along the 'long' dimension; i. e., it is dependent
    # on orientation.
    # if {$c == "Scale" || $c == "TScale" || $c == "TSeparator"} { ;#} 2021
    if {$c == "TScale" || $c == "TSeparator"} {
        set orient [$vTcl(w,widget) cget -orient]
        if {$orient == "vertical"} {
            return 3
        } else {
            return 4
        }
    }
    # Resizable is set in the wgt file.
    set resizable $classes($c,resizable)
    ## We can't resize at all.
    if {$resizable == 0} { return 0 }

    ## We can resize both.
    if {$resizable == 1} { return 1 }
    switch -- $dir {
        e  -
        w  {
            return [expr $resizable == 2]
        }

        n  -
        s  {
            return [expr $resizable == 3]
        }

        ne -
        se -
        sw -
        nw {
            if {$resizable == 2} { return 2 }
            if {$resizable == 3} { return 3 }
        }
    }
}

proc vTcl:lock_widget {} {
    # Entered when a user locks a widget using the context widget.
    # The entries in the context widget are set in page.tcl/
    global vTcl
    set target $vTcl(w,widget)
    namespace eval ::widget::${target} {
        variable locked
    }
    set ::widgets::${target}::locked  1
    set vTcl(w,place,locked) 1
    vTcl:init_wtree
    vTcl:prop:update_attr
}

proc vTcl:unlock_widget {} {
    # Entered when user unlocks a widget using the context widget.
    global vTcl
    set target $vTcl(w,widget)
    set ::widgets::${target}::locked 0
    set vTcl(w,place,locked) 0
    vTcl:init_wtree
    vTcl:prop:update_attr
}

proc vTcl:copy_lock {target} {
    # Called when opening a project that contains locked widgets.
    namespace eval ::widgets::${target} {
        variable locked
    }
    set ::widgets::${target}::locked  1
}

proc vTcl:relative_place {target} {
    # Execute place command which changes absolute to relative placement.
    global vTcl rel
    if {$vTcl(mode) eq "Absolute"} { return }
    set class [vTcl:get_class $target]
    if {$class eq "Toplevel"} { return }
    # if {[info exists ::widgets::${target}::mode]} {
    #     if {$::widgets::${target}::mode eq "Relative"} { return }
    # }fg
    vTcl:calc_relative_geometry $target
    switch $class {
        Button -
        TButton -
        Entry -
        TEntry {
            # Do not want these stretchable.
            place configure $target \
                -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
        }
        TScale -
        Scale {
            set orient [$target cget -orient]
            if {$orient eq "vertical"} {
                place configure $target -relheight $rel(relh) -height 0 \
                    -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
            } else {
                place configure $target -relwidth $rel(relw) -width 0 \
                    -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
            }
        }
        TSeparator {
            set orient [$target cget -orient]
            if {$orient eq "vertical"} {
                place configure $target -relheight $rel(relh) -height 0 \
                    -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
            } else {
                place configure $target -relwidth $rel(relw) -width 0 \
                    -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
            }
        }
        TProgressbar {
            # Only stretch the width not the height.
            place configure $target -relwidth $rel(relw) -width 0 \
                -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
        }
        TSizegrip {
            # Keep it in the lower right corner.
            place configure $target -x -0 -y -0
        }
        default {
            # usual case
            place configure $target -relwidth $rel(relw) -relheight \
                $rel(relh) -height 0 -width 0 -relx $rel(relx) \
                -rely $rel(rely) -x 0 -y 0
        }
    }
    namespace eval ::widgets::${target} {
        # Create the variable so that I can store the widget mode there.
        variable mode
    }
    set ::widgets::${target}::mode "Relative"
}


proc vTcl:widget_delta {widget x y w h} {
    # Function to nudge the widget using the arrow keys.
    global vTcl
    if {$widget in $vTcl(multi_select_list)} {
        set parent [winfo parent $widget]
        set parent_class [vTcl:get_class $parent]
        if {$parent_class in $vTcl(complex_class)} {
            set vTcl(multi_select_widget) $parent
        } else {
            set vTcl(multi_select_widget) $widget
        }
        # set nudge_list $vTcl(multi_select_list)
        set nudge_list [vTcl:find_common_parent]
    } else {
        # I have gone back and forth on this pair of statements. The
        # empty list seems necessary for implementng the shift-arrow
        # operation.
        #set nudge_list [list $widget]
        set nudge_list [list]
    }
    set class [winfo class $widget]
    if {$class == "Toplevel"} { return }
    set parent [winfo parent $widget]
    set parent_class [winfo class $parent]
    set vTcl(skip) 0
    if {$class == "Frame" && $parent_class == "TNotebook"} {
        return
    }
    if {$class == "Frame" && $parent_class == "PNotebook"} {
        return
    }
    set handle ""
    if {$vTcl(w,class) == "TLabelframe" && $parent_class == "TPanedwindow"} {
        # x != 0 signifies <Left> or <Right> key was pushed.
        # y != 0 signifies <Up> or <Down> key was pushed.
        set handle $vTcl(h,entered)
        set panes [$parent panes]
        set parent [winfo parent $widget]
        set o [$parent cget -orient]
        set pane_index [lsearch $panes $widget]

        if {$o eq "horizontal"} {
            # Sash is vertical.
            if {$y != 0} { return }
            if {$handle in {nw w sw}} {
                set sash_top_left 1
                set sash_bottom_right 0
            } elseif {$handle in {ne e se}} {
                set sash_top_left 0
                set sash_bottom_right 1
            } else {
                ::vTcl::MessageBox -icon info -parent .vTcl \
                    -title "Sash Movement" \
                    -message "Cannot select North or South handle." -type ok
                return
            }
        }
        if {$o eq "vertical"} {
            # Sash is horizontal.
            if {$x != 0} { return }
            if {$handle in {nw n ne}} {
                set sash_top_left 1
                set sash_bottom_right 0
            } elseif {$handle in {sw s se}} {
                set sash_top_left 0
                set sash_bottom_right 1
            } else {
                ::vTcl::MessageBox -icon info -parent .vTcl \
                    -title "Sash Movement" \
                    -message "Cannot select East or West handle." -type ok
                return
            }
        }
        if {$sash_top_left} {
            set sash [expr {$pane_index - 1}]
            if {$sash < 0} { return }
        }
        if {$sash_bottom_right} {
            set sash $pane_index
            set no_panes [llength $panes]
            if {$sash == [expr {$no_panes -1}]} { return }
        }
        set value [$parent sashpos $sash]
        #set vTcl(undo_level) 0 ;# Kill all undo setup.


        if {$vTcl(first_time) == 1} {
            vTcl:prepare_undo_sash $widget $handle
            set vTcl(first_time) 0
        }
        #vTcl:sash_info $widget $handle
        #set sash $vTcl(sash)
        set value [$parent sashpos $sash]
        $parent sashpos $sash [expr {$value + $x + $y}]
        vTcl:place_handles $widget
        return
    } ;# End of paned window block.
    if {$vTcl(first_time) == 1} {
        if {$widget in $nudge_list} {
            vTcl:prepare_undo_geom $nudge_list
        } else {
            vTcl:prepare_undo_geom $widget
        }
        set vTcl(first_time) 0
    }
    if {$widget in $nudge_list} {
        # Branch for nudging multiple selections. Will not be case with a
        # panedwindow pane.  Don't think group stretch makes much
        # sense, hence no newW, or newH.
        foreach n $nudge_list {
            set newX [expr [winfo x $n] + $x]
            set newY [expr [winfo y $n] + $y]
            set newW [expr [winfo width $n] + $w]
            set newH [expr [winfo height $n] + $h]
            place configure $n -x $newX -y $newY \
                -relx 0.0 -rely 0.0
            update
            vTcl:destroy_handles
            vTcl:replace_all_multi_handles
        }
    } else {
        set newX [expr [winfo x $widget] + $x]
        set newY [expr [winfo y $widget] + $y]
        set newW [expr [winfo width $widget] + $w]
        set newH [expr [winfo height $widget] + $h]
        vTcl:actual_resize $widget $newX $newY $newW $newH $handle
    }
    # Code to support relative placement
    vTcl:update_widget_info $widget
    vTcl:destroy_handles
    if {$widget ne $nudge_list} {
        vTcl:place_handles $widget
    }
    vTcl:replace_all_multi_handles
    vTcl:relative_place $widget
    vTcl:change
}

proc vTcl:actual_resize {widget newX newY newW newH handle} {
    global vTcl
    set vTcl(skip) 0
    set class [winfo class $widget]
    set parent [winfo parent $widget]
    set parent_class [winfo class $parent]
    # Detect that this is a window pane using parent_class above.
    # Then don't place it just adjust the appropriate sashes.
    if {$parent_class == "TPanedwindow"} {
        # Handle paned widget
        # With window panes we only adjust the sash and don't do
        # anything with placement. The sash to be adjusted depends on
        # both the pane and the handle

        # Pick up facts about the paned window.
        set panes [$parent panes]
        set pane_index [lsearch $panes $widget]
        set o [$parent cget -orient]
        set no_panes [llength $panes]
        set no_sashes [expr {$no_panes -1}]
        if {$o eq "horizontal"} {
            # Sash is vertical.
            if {$handle in {nw w sw}} {
                set sash_top_left 1
                set sash_bottom_right 0
            } elseif {$handle in {ne e se}} {
                set sash_top_left 0
                set sash_bottom_right 1
            } else { return }
        }

        if {$o eq "vertical"} {
            if {$handle in {nw n ne}} {
                set sash_top_left 1
                set sash_bottom_right 0
            } elseif {$handle in {sw s se}} {
                set sash_top_left 0
                set sash_bottom_right 1
            } else { return }
        }
        if {$sash_top_left && $pane_index > 0} {
            # Adjust sash to left or top of the frame we just moved.
            update idletasks
            if {$o == "horizontal"} {
                $parent sashpos [expr $pane_index - 1] $newX
            } else {
                $parent sashpos [expr $pane_index - 1] $newY
            }
        }
        if {$sash_bottom_right && $pane_index < $no_sashes} {
            # Adjust sash to right or bottom of the frame we just moved.
            if {$o == "horizontal"} {
                $parent sashpos $pane_index [expr $newX + $newW]
            } else {
                $parent sashpos $pane_index [expr $newY + $newH]
            }
        }

        update idletasks
        set vTcl(skip) 1
    } elseif {$class == "Scale" || $class == "TScale"} {   # Rozen
        #set o [$widget cget -orient]
        # if {$o == "horizontal"} {
        #     $widget configure -length $newW
        # } else {
        #     $widget configure -length $newH
        # }
        place $widget -width $newW -relwidth 0 -height $newH -relheight 0
        place $widget -x $newX -y $newY -relx 0 -rely 0 -bordermode ignore
    } elseif {$class eq "TSeparator"} {
        set o [$widget cget -orient]
        if {$o == "horizontal"} {
            place $widget -x $newX -y $newY -relx 0 -rely 0 \
                -width $newW -bordermode ignore -relwidth 0.0 -relheight 0.0
        } else {
            place $widget -x $newX -y $newY -height $newH -bordermode ignore \
                -relx 0.0 -rely 0.0 -relwidth 0.0 -relheight 0.0
        }
    } else {
        # This is the normal action for all widgets except
        # paned windows, scale widgets, or separator widgets.
        place $widget -x $newX -y $newY -width $newW -height $newH \
            -relx 0.0 -rely 0.0 \
            -relwidth 0.0 -relheight 0.0 \
            -bordermode ignore
        # Code to support relative placement
    }
    update
    # Removed temporally put it back and test.
    if {$vTcl(skip) == 0} {
        vTcl:relative_place $widget
    }
    update
}

proc vTcl:sash_info {widget handle} {
    global vTcl
    set parent [winfo parent $widget]
    set panes [$parent panes]
    set parent [winfo parent $widget]
    set o [$parent cget -orient]
    set pane_index [lsearch $panes $widget]
    if {$o eq "horizontal"} {
        # Sash is vertical.
        if {$handle in {nw w sw}} {
            set sash_top_left 1
            set sash_bottom_right 0
        } elseif {$handle in {ne e se}} {
            set sash_top_left 0
            set sash_bottom_right 1}
    }
    if {$o eq "vertical"} {
        if {$handle in {nw n ne}} {
            set sash_top_left 1
            set sash_bottom_right 0
        } elseif {$handle in {sw s se}} {
            set sash_top_left 0
            set sash_bottom_right 1}
    }
    if {$sash_top_left} { set sash [expr {$pane_index - 1}] }
    if {$sash_bottom_right} { set sash $pane_index }
    set vTcl(sash_top_left) $sash_top_left
    set vTcl(sash_bottom_right) $sash_bottom_right
    set vTcl(sash) $sash
} ;# end vTcl:sash_info

        # TSeparator {
        #     set orient [$target cget -orient]
        #     if {$orient eq "vertical"} {
        #         place configure $target -relheight $rel(relh) -height 0 \
        #             -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
        #     } else {
        #         place configure $target -relwidth $rel(relw) -width 0 \
        #             -relx $rel(relx) -rely $rel(rely) -x 0 -y 0
        #     }
        # }
