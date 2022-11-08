##############################################################################
#
# undo.tcl - procedures to handle the undo functions I created.
#
# Copyright (C) 2020 Donald Rozenberg
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


proc vTcl:prepare_undo_geom {list {m ""}} {
    # Save the geometry information necessary for undo and note the
    # type of the undo as "geom".
    global vTcl
    global rel
    set list [lsort -unique $list]
    foreach w $list {
        lappend class_list [vTcl:get_class $w]
    }
    set i [lsearch $class_list "Toplevel"]
    if {$i > -1} {
        set list [lreplace $list $i $i]
    }
    if {[llength $list] == 0} { return }
    incr vTcl(undo_level)
    set vTcl(undo,$vTcl(undo_level),type) "geom"
    set vTcl(undo,$vTcl(undo_level),list) $list
    foreach w $list {
        vTcl:calc_relative_geometry $w
        set vTcl(undo,$vTcl(undo_level),${w},relx) $rel(relx)
        set vTcl(undo,$vTcl(undo_level),${w},rely) $rel(rely)
        set vTcl(undo,$vTcl(undo_level),${w},x) $rel(x)
        set vTcl(undo,$vTcl(undo_level),${w},y) $rel(y)
        set vTcl(undo,$vTcl(undo_level),${w},relwidth) $rel(relw)
        set vTcl(undo,$vTcl(undo_level),${w},relheight) $rel(relh)
        set vTcl(undo,$vTcl(undo_level),${w},width) $rel(w)
        set vTcl(undo,$vTcl(undo_level),${w},height) $rel(h)
    }

    if {$m ne ""} {
        set vTcl(undo,$vTcl(undo_level),motion) $w
    } else {
        set vTcl(undo,$vTcl(undo_level),motion) ""
    }
}

proc vTcl:prepare_undo_sash {widget handle} {
    # Determine the sash to be restored from the widget which is a
    # pane in an TPanedwindow and the handle. Then save the info in
    # the stack.
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
    if {$sash_top_left} { set sash [expr {$pane_index - 1}] }
    if {$sash_bottom_right} { set sash $pane_index }
    set value [$parent sashpos $sash]
    incr vTcl(undo_level)
    set vTcl(undo,$vTcl(undo_level),type) "sash"
    set vTcl(undo,$vTcl(undo_level),widget) $widget
    set vTcl(undo,$vTcl(undo_level),handle) $handle
    set vTcl(undo,$vTcl(undo_level),sash) $sash
    set vTcl(undo,$vTcl(undo_level),sash_value) $value
    return $sash
}

proc vTcl:prepare_undo_remove {list} {
    global vTcl
    incr vTcl(undo_level)
    set vTcl(undo,$vTcl(undo_level),type) "rm"
    set vTcl(undo,$vTcl(undo_level),list) $list
}

proc vTcl:undo_multi {} {
    # Come here from Control-Z or Button-3 menu -> Undo.
    # Decides which particular undo routine to invoke.

    # The sub array vTcl(undo,*) contains the data used by undo and
    # vTcl(undo_level) is the spot in the stack.

    # So far I have implemented two variations of undo a) undo removal
    # of items from set of multiple selections, and b) certain
    # geometric changes in the geometry of the multi selected
    # widgets. They are the commands accessed from the pop up menu.

    # An info message is generated if there is no undo information in
    # the "undo stack".

    # The variables used for undo include:
    # vTcl(undo,$vTcl(undo_level),type)      Type of redo geom, rm_all, rm_one
    # vTcl(undo,$vTcl(undo_level),${w},relx)
    # vTcl(undo,$vTcl(undo_level),${w},rely)
    # vTcl(undo,$vTcl(undo_level),${w},x)
    # vTcl(undo,$vTcl(undo_level),${w},y)
    # vTcl(undo,$vTcl(undo_level),list)     List of widgets to be undone
    global vTcl
    if {[info exists vTcl(undo_level)]} {
        if {$vTcl(undo_level) < 1} {
            ::vTcl::MessageBox -icon error -parent .vTcl -title "No undo!" \
                -message "Nothing to undo!" -type ok
            return
        }
    } else {
        ::vTcl::MessageBox -icon info -parent .vTcl -title "No undo!" \
            -message "Nothing to undo!" -type ok
        return
    }
    switch $vTcl(undo,$vTcl(undo_level),type) {
        geom { vTcl:undo_geom }
        rm { vTcl:undo_remove }
        sash { vTcl:undo_sash }
    }
}

proc vTcl:undo_sash {} {
    # Revert back to spot where sash was. This cannot occur with multi
    # selections.
    global vTcl
    set widget $vTcl(undo,$vTcl(undo_level),widget)
    set handle $vTcl(undo,$vTcl(undo_level),handle)
    set sash $vTcl(undo,$vTcl(undo_level),sash)
    set value $vTcl(undo,$vTcl(undo_level),sash_value)
    set parent [winfo parent $widget]
    $parent sashpos $sash $value
    vTcl:destroy_handles
    vTcl:place_handles $widget
    vTcl:replace_all_multi_handles
    vTcl:pop_undo
return
    set panes [$parent panes]
    set o [$parent cget -orient]
    set pane_index [lsearch $panes $widget]
       if {$o eq "horizontal"} {
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
    if {$sash_top_left} {
        $parent sashpos [expr $pane_index - 1] \
            $vTcl(undo,$vTcl(undo_level),sash_value)
    }
    if {$sash_bottom_right} {
        $parent sashpos $pane_index \
            $vTcl(undo,$vTcl(undo_level),sash_value)
    }
    vTcl:destroy_handles
    vTcl:place_handles $widget
    vTcl:replace_all_multi_handles
    vTcl:pop_undo
}

proc vTcl:undo_remove {} {
    # Revert back to multi selection that existed before the remove
    # command.
    global vTcl
    # set vTcl(multi_select_list) $vTcl(undo,$vTcl(undo_level),list)
    foreach w $vTcl(undo,$vTcl(undo_level),list) {
        lappend vTcl(multi_select_list) $w
    }
    vTcl:replace_all_multi_handles
    foreach w $vTcl(multi_select_list) {
        vTcl:show_selection_in_tree $w
    }
    vTcl:pop_undo
    vTcl:destroy_handles
}

proc vTcl:undo_geom {} {
    # Operates on all widgets in the undo list. The undo list is the
    # list of all widgets that were affected is the last
    # operation. That list was created when the key was pressed.
    global vTcl
    if {![info exists vTcl(undo,$vTcl(undo_level),list)] } { return }
    set align_list $vTcl(undo,$vTcl(undo_level),list)
    foreach t $align_list {
        set t_class [vTcl:get_class $t]
        if {$t_class eq "TSizegrip"} { continue }
        if {$t_class eq "Toplevel"} { continue }
        if {$vTcl(mode) eq "Relative"} {
            place configure $t  -relx $vTcl(undo,$vTcl(undo_level),${t},relx) \
                -rely $vTcl(undo,$vTcl(undo_level),${t},rely) -x 0 -y 0
            if {$t_class ne {Button TButton Entry Tentry}} {
                # do nothing
            } elseif {$vTcl(undo,$vTcl(undo_level),${t},relwidth) != ""} {
                place configure $t \
                    -relwidth $vTcl(undo,$vTcl(undo_level),${t},relwidth) \
                    -relheight $vTcl(undo,$vTcl(undo_level),${t},relheight) \
                    -width 0 -height 0
            }
        } else {
            place configure $t -relx 0.0 -rely 0.0 \
                -x $vTcl(undo,$vTcl(undo_level),${t},x) \
                -y $vTcl(undo,$vTcl(undo_level),${t},y)
        }
    }
    #if {$vTcl(undo,$vTcl(undo_level),motion) ne ""} {   
        vTcl:destroy_handles ;# $vTcl(undo,$vTcl(undo_level),motion)
    vTcl:place_handles $t ;#$vTcl(undo,$vTcl(undo_level),motion)
        vTcl:update_widget_info $t
    #}
    vTcl:init_wtree
    vTcl:replace_all_multi_handles
    vTcl:pop_undo
}

proc vTcl:pop_undo {} {
    global vTcl
    array unset vTcl undo,$vTcl(undo_level),*
    incr vTcl(undo_level) -1
}

proc vTcl:destroy_undo {} {
    global vTcl
    array unset vTcl undo*
}
