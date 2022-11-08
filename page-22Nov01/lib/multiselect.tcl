##############################################################################
#
# multiselect.tcl - procedures to handle multiple widget selection.
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

# vTcl:bind_button_multi
# vTcl:drop_multi_target
# vTcl:spread_vertical
# vTcl:bind_button_multi
# vTcl:align_vertical
# vTcl:undo_multi
# vTcl:prepare_undo_geom
# vTcl:undo_geom
# vTcl:undo_remove

proc vTcl:remove_multi_selections {} {
    global vTcl
    if {[llength $vTcl(multi_select_list)]} {
        vTcl:multi_destroy_handles
        vTcl:clear_multi_select_color
        vTcl:prepare_undo_remove $vTcl(multi_select_list)
        set vTcl(multi_select_list) [list]
        #set vTcl(remove_all_multi) 1  ;# new ;# Remove from Widget Tree.
        #vTcl:show_selection_in_tree $vTcl(w,widget)
        vTcl:init_wtree 0
    }
}

# proc vTcl:remove_single_multi_selection {target} {
#     global vTcl
# dmsg
# dmsg vTcl(multi_select_list exist? [info exists  vTcl(multi_select_list)]
# dpr vTcl(multi_select_list)
#     if {$target in $vTcl(multi_select_list)} {
#         vTcl:multi_destroy_handles $target
#         vTcl:clear_multi_select_color ;# Remove all multi coloring from tree.
#         set index [lsearch -exact $vTcl(multi_select_list) $target]
#         if {$index > -1} {
#             set vTcl(multi_select_list) \
#                 [lreplace $vTcl(multi_select_list) $index $index]
#         }
#     }
# dmsg exiting
# dpr vTcl(multi_select_list)
# }

proc vTcl:bind_top_multi {target X Y x y} {
    # This is analogous to vTcl:bind_button_top. Again, I want to bind
    # <Control-Button-2> to the top widget of a complex widget like a
    # notebook not one of the inside widgets.
    global vTcl
    # See if parent is child of complex_class.
    set parent [winfo parent $target]
    set class [vTcl:get_class $target]
    if {$class eq "Toplevel"} { return }
    if {$target != "" &&
        [lsearch $vTcl(complex_class) [winfo class $parent]] > -1} {
        set w $parent
    } else {
        set w $target
    }
    vTcl:bind_button_multi $w $X $Y $x $y
}

proc vTcl:bind_button_multi {target X Y x y} {
    # I think all that I want to do put handles around the widget and
    # add that target to vTcl(multi_select_list). I also want to
    # select any complex widget instead of a component widget. In
    # doing so I negate need for <Control-Button-2> events.
    global vTcl
    # if {$target in $vTcl(multi_select_list)} { return }
    if {[vTcl:get_class $target] eq "Toplevel"} {
        # The toplevel widget cannot be the multi_select_widget!
        set vTcl(multi_select_widget) ""
        return
    }
    set parent [winfo parent $target]
    set parent_class [winfo class $parent]
    if {$parent_class in $vTcl(complex_class)} {
        set target $parent
    }
    if {$target ni $vTcl(multi_select_list)} {
        lappend vTcl(multi_select_list) $target
        vTcl:destroy_handles  ;# Do this before setting multi_select flag.
        set vTcl(w,widget) {} ;# want to have no selected widget.
        set vTcl(multi_select_widget) $target
        vTcl:store_cursor $target
        catch {$target configure -cursor fleur}
        set vTcl(multi_select) 1
        vTcl:multi_create_handles $target
        vTcl:show_selection_in_tree $target
        #vTcl:grab $target $X $Y
        foreach w $vTcl(multi_select_list) {
            set vTcl(multi,$w,x) [winfo x $w]
            set vTcl(multi,$w,y) [winfo y $w]
        }
        set vTcl(multi_select) 0
        set vTcl(first_time) 1
    } else { vTcl:drop_multi_target $target }
}

proc vTcl:drop_multi_target {W} {
    # Removes the widget W from the list of multiple selections and
    # removes the multi handles as well. Finally, reset color in
    # widget tree.
    global vTcl
    if {[vTcl:get_class $W] eq "Toplevel"} { return }
    if {[llength $vTcl(multi_select_list)] == 0} { return }
    vTcl:multi_destroy_handles $W
    vTcl:prepare_undo_remove [list $W]
    set i [lsearch $vTcl(multi_select_list) $W]
    set vTcl(multi_select_list) [lreplace $vTcl(multi_select_list) $i $i]
    # Remove special colorization from the widget tree.
    set fill $vTcl(pr,fgcolor)
    set b .vTcl.tree.cpd21.03
    set j [vTcl:rename $W]
    $b itemconfigure "TEXT$b.$j" -fill $fill
}

proc vTcl:align_horizontal {} {
    global vTcl
    # Find multi selection in same parent with vTcl(multi_select_widget)
    set align_list [vTcl:find_common_parent]
    set w $vTcl(multi_select_widget)
    set conf [place configure $w]
    foreach item $conf {
        foreach {o a b d v} $item {}
        switch $o {
            -relx { set rx $v }
            -rely { set ry $v }
            -x    { set x $v }
            -y    { set y $v }
        }
    }
    vTcl:prepare_undo_geom $align_list
    foreach t $align_list {
        if {$vTcl(mode) eq "Relative"} {
            place configure $t  -rely $ry -x 0 -y 0
        } else {
            place configure $t -relx 0.0 -rely 0.0 -y $y
        }
    }
   vTcl:destroy_handles
    vTcl:replace_all_multi_handles
}
proc vTcl:align_vertical {} {
    global vTcl
    # Find multi selection in same parent with vTcl(multi_select_widget)
    set align_list [vTcl:find_common_parent]
    set w $vTcl(multi_select_widget)
    set conf [place configure $w]
    foreach item $conf {
        foreach {o a b d v} $item {}
        switch $o {
            -relx { set rx $v }
            -rely { set ry $v }
            -x    { set x $v }
            -y    { set y $v }
        }
    }
    vTcl:prepare_undo_geom $align_list
    foreach t $align_list {
        if {$vTcl(mode) eq "Relative"} {
            place configure $t  -relx $rx -x 0 -y 0
        } else {
            place configure $t -relx 0.0 -rely 0.0 -x $x
        }
    }
    vTcl:destroy_handles
    vTcl:replace_all_multi_handles
}



# proc vTcl:copy_multi {} {
#     return ;# Stuff currently does not allow copy function.
#     global vTcl
#     set vTcl(copy) 1
#     # vTcl::compounds::createCompound in lib/compound.tcl
#     foreach w $vTcl(multi_select_list) {
#         eval [vTcl::compounds::createCompound  $w clipboard scrap]
#     }
#     set vTcl(copy) 0
# }

proc vTcl:find_common_parent {} {
    # Return list of multi selected widgets which have the same parent
    # as vTcl(multi_select_widget).
    global vTcl
    set widget $vTcl(multi_select_widget)
    set parent [winfo parent $widget]
    set ret [list]
    foreach w $vTcl(multi_select_list) {
        set p_w [winfo parent $w]
        if {$p_w eq $parent} {
            lappend ret $w
        }
    }
    return $ret
}

proc vTcl:spread_horizontal {} {
    # Find multi selections in same parent with vTcl(multi_select_widget)
    global vTcl
    set spread_list [vTcl:find_common_parent]
    set spread_list [vTcl:sort_by_x $spread_list]
    set widget $vTcl(multi_select_widget)
    set parent [winfo parent $widget]
    set p_width [winfo width $parent]
    set w_width 0
    vTcl:multi_destroy_handles
    foreach w $spread_list {
        set w_width [expr {$w_width + [winfo width $w]}]
    }
    set space [expr {$p_width - $w_width}]
    set space_no [expr {[llength $spread_list] + 1}]
    set space_width [expr {$space / $space_no}]
    set spot 0
    vTcl:prepare_undo_geom $spread_list
    foreach w $spread_list {
        if {$vTcl(mode) eq "Relative"} {
            set rly [place configure $w -rely]
            foreach {x x x x rely} $rly {}
            set spot [expr {double($spot) + $space_width}]
            place configure $w  -relx [expr {double($spot) / $p_width}] \
                                -rely $rely -x 0 -y 0
            # set spot [expr {$spot + double([winfo width $w]) / $p_width}]
            set spot [expr {$spot + double([winfo width $w])}]
        } else {
            set ly [place configure $w -y]
            foreach {x x x x y} $ly {}
            set spot [expr {$spot + $space_width}]
            place configure $w -relx 0.0 -rely 0.0 -x $spot -y $y
            set spot [expr {$spot + [winfo width $w]}]
        }
    }
    vTcl:replace_all_multi_handles
}

proc vTcl:spread_vertical {} {
    # Find multi selections in same parent with vTcl(multi_select_widget)
    global vTcl
    set spread_list [vTcl:find_common_parent]
    set spread_list [vTcl:sort_by_y $spread_list]
    set widget $vTcl(multi_select_widget)
    set parent [winfo parent $widget]
    set p_height [winfo height $parent]
    set w_height 0
    vTcl:multi_destroy_handles
    vTcl:prepare_undo_geom $spread_list
    foreach w $spread_list {
        set w_height [expr {$w_height + [winfo height $w]}]
    }
    set space [expr {$p_height - $w_height}]
    set space_no [expr {[llength $spread_list] + 1}]
    set space_height [expr {$space / $space_no}]
    # set spot $space_height
    set spot 0
    foreach w $spread_list {
        if {$vTcl(mode) eq "Relative"} {
        set rlx [place configure $w -relx]
        foreach {x x x x relx} $rlx {}
            set spot [expr {double($spot) + $space_height}]
            place configure $w  -relx $relx \
                       -rely [expr {double($spot) / $p_height}]  -x 0 -y 0
            set spot [expr {$spot + double([winfo height $w])}]
        } else {
            set lx [place configure $w -x]
            foreach {x x x x x} $lx {}
            set spot [expr {$spot + $space_height}]
            place configure $w -relx 0.0 -rely 0.0 -x $x -y $spot
            set spot [expr {$spot + [winfo height $w]}]
        }
    }
    vTcl:replace_all_multi_handles
}

proc vTcl:compare_x_pos {a b} {
    set xa [winfo x $a]
    set xb [winfo x $b]
    if {[expr {$xa <= $xb}]} {
        return -1
    } else {
        return 1
    }
}

proc vTcl:sort_by_x {w_list} {
    # Sort the widget list "w_list" by the x value in ascending order.
    global vTcl
    set new_list [lsort -command vTcl:compare_x_pos $w_list]
    return $new_list
}

proc vTcl:compare_y_pos {a b} {
    set ya [winfo y $a]
    set yb [winfo y $b]
    if {[expr {$ya <= $yb}]} {
        return -1
    } else {
        return 1
    }
}

proc vTcl:sort_by_y {w_list} {
    # Sort the widget list "w_list" by the y value in ascending order.
    global vTcl
    set new_list [lsort -command vTcl:compare_y_pos $w_list]
    return $new_list
}

proc vTcl:center_horizontal {} {
    global vTcl
    set spread_list [vTcl:find_common_parent]
    set spread_list [vTcl:sort_by_x $spread_list]
    set widget $vTcl(multi_select_widget)
    set parent [winfo parent $widget]
    set p_width [winfo width $parent]
    set w_width 0
    vTcl:multi_destroy_handles
    vTcl:prepare_undo_geom $spread_list
    foreach w $spread_list {
        set w_width [winfo width $w]
        set space [expr {$p_width - $w_width}]
        set space_width [expr {$space / 2}]
        set spot $space_width
        if {$vTcl(mode) eq "Relative"} {
            set rly [place configure $w -rely]
            foreach {x x x x rely} $rly {}
            place configure $w  -relx [expr {double($spot) / $p_width}] \
                -rely $rely -x 0 -y 0
        } else {
            set ly [place configure $w -y]
            foreach {x x x x y} $ly {}
            place configure $w -relx 0.0 -rely 0.0 -x $spot \
                -y $y
        }
    }
    vTcl:replace_all_multi_handles
}

proc vTcl:center_vertical {} {
    global vTcl
    set spread_list [vTcl:find_common_parent]
    set spread_list [vTcl:sort_by_y $spread_list]
    set widget $vTcl(multi_select_widget)
    set parent [winfo parent $widget]
    set p_height [winfo height $parent]
    set w_height 0
    vTcl:multi_destroy_handles
    vTcl:prepare_undo_geom $spread_list
    foreach w $spread_list {
        set w_height [winfo height $w]
        set space [expr {$p_height - $w_height}]
        set space_height [expr {$space / 2}]
        set spot $space_height
        if {$vTcl(mode) eq "Relative"} {
            set rlx [place configure $w -relx]
            foreach {x x x x relx} $rlx {}
            place configure $w  -relx $relx \
                -rely [expr {double($spot) / $p_height}] -x 0 -y 0
        } else {
            set lx [place configure $w -x]
            foreach {x x x x x} $lx {}
            place configure $w -relx 0.0 -rely 0.0 -x $x \
                -y $spot
        }
    }
    vTcl:replace_all_multi_handles
}
