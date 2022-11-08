##############################################################################
# $Id: tree.tcl,v 1.28 2005/12/02 21:28:45 kenparkerjr Exp $
#
# tree.tcl - widget tree browser and associated procedures
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

# vTclWindow.vTcl.tree
# vTcl:init_wtree
# vTcl:clear_wtree
# vTcl:left_click_tree
# vTcl:shift_button2_tree
# vTcl:search_wtree
# vTvTcl:double_B1_click_tree
# vTcl:double_B1_click_tree

set vTcl(tree,last_selected) ""
set vTcl(tree,last_yview) 0.0

proc vTcl:show_selection_in_tree {widget_path} {
    global vTcl
    foreach w $vTcl(multi_select_list) {
        vTcl:show_selection .vTcl.tree.cpd21.03.[vTcl:rename $w] $w
    }
    vTcl:show_selection .vTcl.tree.cpd21.03.[vTcl:rename $widget_path] \
        $widget_path
}

# proc vTcl:get_fill_colors {} {
#     global vTcl
#     if {![info exists vTcl(get_fill_colors_called)]} {
#         set vTcl(get_fill_colors_called) 0
#     }
#     if {$vTcl(get_fill_colors_called)} { return }
#     set vTcl(get_fill_colors_called) 1
#     set base .vTcl.tree.cpd21.03
#     # set vTcl(fill_color) $vTcl(actual_fg)
#     set vTcl(fill_color) #000000           ;# NEEDS WORK dark
#     if {$vTcl(dark)} {
#             set vTcl(green_fill) "green2"
#             set vTcl(blue_fill) "cyan"
#             set vTcl(red_fill) "red"
#         } else {
#             set vTcl(green_fill) "green"
#             set vTcl(blue_fill) "blue"
#             set vTcl(red_fill) "firebrick"
#         }
#      if {$vTcl(dark)} {
#         set mg_file [file join $vTcl(VTCL_HOME) "images" "mg1_light.png"]
#         set up_file [file join $vTcl(VTCL_HOME) "images" "big_up_light.gif"]
#         set down_file [file join $vTcl(VTCL_HOME) "images" "big_down_light.gif"]
#     } else {
#         set mg_file [file join $vTcl(VTCL_HOME) "images" "mg1_dark.png"]
#         set up_file [file join $vTcl(VTCL_HOME) "images" "big_up_dark.gif"]
#         set down_file [file join $vTcl(VTCL_HOME) "images" "big_down_dark.gif"]
#     }
#     set base .vTcl.tree
#     set mg_png [vTcl:image:create_new_image $mg_file]
#     $base.frame_bottom.button_search configure -image $mg_png
#     set up_gif [vTcl:image:create_new_image $up_file]
#     $base.frame_bottom.button_next configure -image $up_gif
#     set down_gif [vTcl:image:create_new_image $down_file]
#     $base.frame_bottom.button_previous configure -image $down_gif

# }

proc vTcl:get_fill_colors {} {
    global vTcl
    if {![info exists vTcl(get_fill_colors_called)]} {
        set vTcl(get_fill_colors_called) 0
    }
    if {$vTcl(get_fill_colors_called)} { return }
    set vTcl(get_fill_colors_called) 1
    set base .vTcl.tree.cpd21.03
    # set vTcl(fill_color) $vTcl(actual_fg)
    set vTcl(fill_color) #000000           ;# NEEDS WORK dark
    # if {$vTcl(dark)} {
    #         set vTcl(green_fill) "green2"
    #         set vTcl(blue_fill) "cyan"
    #         set vTcl(red_fill) "red"
    #     } else {
             set vTcl(green_fill) "green"
             set vTcl(blue_fill) "blue"

    set vTcl(red_fill) "firebrick"
    #     }
     if {$vTcl(dark)} {
        set mg_file [file join $vTcl(VTCL_HOME) "images" "mg1_light.png"]
        set up_file [file join $vTcl(VTCL_HOME) "images" "big_up_light.gif"]
        set down_file [file join $vTcl(VTCL_HOME) "images" "big_down_light.gif"]
    } else {
        set mg_file [file join $vTcl(VTCL_HOME) "images" "mg1_dark.png"]
        set up_file [file join $vTcl(VTCL_HOME) "images" "big_up_dark.gif"]
        set down_file [file join $vTcl(VTCL_HOME) "images" "big_down_dark.gif"]
    }
    set base .vTcl.tree
    set mg_png [vTcl:image:create_new_image $mg_file]
    $base.frame_bottom.button_search configure -image $mg_png
    set up_gif [vTcl:image:create_new_image $up_file]
    $base.frame_bottom.button_next configure -image $up_gif
    set down_gif [vTcl:image:create_new_image $down_file]
    $base.frame_bottom.button_previous configure -image $down_gif

}

proc vTcl:show_selection {button_path target} {
    global vTcl
    # do not refresh the widget tree if it does not exist
    if {![winfo exists .vTcl.tree]} {
        return }
    if {[vTcl:streq $target "."]} {
        return }
    vTcl:get_fill_colors
    # set fill $vTcl(actual_fg)
    set fill #000000              ;# NEEDS WORK dark Sun

    vTcl:log "widget tree select: $button_path"
    set b .vTcl.tree.cpd21.03
    if {$target ni $vTcl(multi_select_list)} {
        # This is to remove last selected coloring.
        if {$vTcl(tree,last_selected)!=""} {
            $b itemconfigure "TEXT$vTcl(tree,last_selected)" \
                -fill $fill -font $vTcl(pr,font_dft)
                # -fill $vTcl(pr,fgcolor)
            update
        }
    }
    if {![lempty $vTcl(pr,treehighlight)]} {
        set fill $vTcl(pr,treehighlight)
    }
    if {$target in $vTcl(multi_select_list)} {
        set fill $vTcl(green_fill)
        lappend vTcl(tree,green_tags) $button_path
    } else {
        set fill $vTcl(red_fill) ;# Normal selection.
    }
    # if {$vTcl(remove_all_multi)} { ;# New  Remove all the multi select coloring.
    #     foreach t $vTcl(tree,green_tags) {
    #         $b itemconfigure "TEXT$t" -fill $vTcl(pr,fgcolor)
    #     }
    #     set vTcl(tree,green_tags) [list]
    # }
    # $b itemconfigure "TEXT$button_path" -fill $fill
    $b itemconfigure "TEXT$button_path" -fill $fill \
        -font $vTcl(pr,font_dft)     ;# NEEDS WORK dark
    if {$target ni $vTcl(multi_select_list)} {  ;# new
        # This test is here so that only the regular selected widget
        # is remembered and not any multi selected widgets.
        set vTcl(tree,last_selected) $button_path
    }
    update
    # let's see if we can bring the thing into view
    # lassign [$b cget -scrollregion] foo foo cx cy
    # lassign [$b bbox $button_path] x1 y1 x2 y2

    # if {$cy <= 0} {return}

    # set yf0 [expr $y1.0 / $cy]
    # set yf1 [expr $y2.0 / $cy]
    # lassign [$b yview] yv0 yv1

    # if {$yf0 < $yv0 || $yf1 > $yv1} {
    #     set ynew [expr $yf0 - ($yf1 - $yf0) / 2.0]
    #     if {$ynew < 0.0} {
    #         set ynew $yf0
    #     }
    #     $b yview moveto $ynew
    # }
    vTcl:adjust_scrolling $button_path
}

proc vTcl:show_wtree {} {
    global vTcl
    Window show .vTcl.tree
    wm geometry .vTcl.tree $vTcl(geometry,.vTcl.tree)
    vTcl:init_wtree
}

proc vTcl:clear_wtree {} {
    # Do not refresh the widget tree if it does not exist.
    if {![winfo exists .vTcl.tree]} { return }
    set b .vTcl.tree.cpd21.03
    foreach i [winfo children $b] {
        destroy $i
    }
    # $b delete TEXT LINE RECT
    $b delete all                          ;# NEEDS WORK
    set vTcl(tree,green_tags) [list]     ;# New
    $b configure -scrollregion "0 0 0 0"
}

proc vTcl:clear_search {} {
    global vTcl
    set vTcl(wt,found) [list]
    set vTcl(wt,shown) -1
    set vTcl(searchReport) ""
}

proc vTcl:search_wtree {search_string} {
    global vTcl
    if {$search_string eq ""} {
        set vTcl(searchReport) "No search string."
        return
    }
    vTcl:clear_search
    set search_string [string tolower $search_string]
    set b .vTcl.tree.cpd21.03
    set t_items [$b find all]
    set found 0
    foreach t $t_items {
        set type [$b type $t]
        if {$type eq "text"} {
            set iconf [$b itemconfigure $t]
            set txt_option [$b itemconfigure $t -text]
            lassign $txt_option x x x x txt
            if {[regexp $search_string [string tolower $txt]]} {
                $b itemconfigure $t -fill $vTcl(blue_fill)
                #if {$found ==  0} {
                    set found_text $t
                    lappend vTcl(wt,found) $t
                    incr found
                #}
            }
        }
    }
    if {$found >= 1} {
        #vTcl:adjust_scrolling $found_text
        vTcl:display_next next
        set vTcl(searchReport) "$found matches found."
    } else {
        set vTcl(searchReport) "\"$search_string\" not found."
    }
}

proc vTcl:display_next {direction} {
    global vTcl
    if {![info exists vTcl(wt,found)]} {
        set vTcl(searchReport) "No search active."
        return
    }
    set len [llength $vTcl(wt,found)]
    if {$direction eq "next"} {
        set index [incr vTcl(wt,shown)]
        if {$index == $len} { set index 0 }
    } else {
        set index [incr vTcl(wt,shown) -1]
        if {$index < 0} { set index [expr {$len - 1}] }
    }
    set display_t [lrange $vTcl(wt,found) $index $index]
    vTcl:adjust_scrolling $display_t
    set vTcl(wt,shown) $index
}

proc vTcl:adjust_scrolling {button_path} {
    # move line to viewable area of canvas.
    set b .vTcl.tree.cpd21.03
    # let's see if we can bring the thing into view
    lassign [$b cget -scrollregion] foo foo cx cy
    lassign [$b bbox $button_path] x1 y1 x2 y2

    if {$cy <= 0} {return}

    set yf0 [expr $y1.0 / $cy]
    set yf1 [expr $y2.0 / $cy]
    lassign [$b yview] yv0 yv1

    if {$yf0 < $yv0 || $yf1 > $yv1} {
        set ynew [expr $yf0 - ($yf1 - $yf0) / 2.0]
        if {$ynew < 0.0} {
            set ynew $yf0
        }
        $b yview moveto $ynew
    }
}

proc vTcl:list_tree {} {
    set b .vTcl.tree.cpd21.03
}

proc vTcl:clear_multi_select_color {} {
    # Remove all multi selection coloring from Widget Tree.
    global vTcl
    if {![winfo exists .vTcl.tree]} { return }
    set b .vTcl.tree.cpd21.03
    set tree [vTcl:complete_widget_tree]
    foreach ii $tree {
        set j [vTcl:rename $ii]
        if {[winfo exists $b.$j]} {
            # $b itemconfigure "TEXT$b.$j" -fill $vTcl(pr,fgcolor)
            $b itemconfigure "TEXT$b.$j" -fill $vTcl(pr,fgcolor) \
                -font $vTcl(pr,font_dft)   ;# NEEDS WORK dark
        }
    }
}

proc vTcl:left_click_tree {cmd i b j} {
    # Come here when one clicks B1 on a widget in the tree.
    global vTcl
    if {$::classes([vTcl:get_class $i],ignoreLeftClk)} return
    #IF THE WIDGET DOES NOT EXIST REGISTER IT
    if {![catch {namespace children ::widgets} namespaces]} {
        if { [lsearch $namespaces ::widgets::${i}] <= -1 } {
            vTcl:widget:register_widget $i
        }
    }
    #$cmd $i
    catch {$cmd $i}        ;# Rozen
    # if {!$vTcl(multi_select)} { # Remove all Multi Select handles.
    #     if {[llength $vTcl(multi_select_list)]} {
    #         vTcl:multi_destroy_handles
    #         set vTcl(multi_select_list) [list]
    #     }
    # }
    set pieces [split $i "."]
    set ll [llength $pieces]
    if {$ll < 3} { vTcl:active_widget $i }
    for {set i 3} {$i <= $ll} {incr i} {
        set ansester [join [lrange $pieces 0 $i] "."]
        vTcl:active_widget $ansester
    }
    vTcl:show_selection $b.$j $i
}

proc vTcl:double_B1_click_tree {i X Y x y} {
    # Come here when one double clicks B on a widget in the tree.
    vTcl:widget_dblclick $i $X $Y $x $y
}

proc vTcl:right_click_tree {i X Y x y} {
    # Come here when one clicks B2 on a widget in the tree.
   global vTcl
    if {$::classes([vTcl:get_class $i],ignoreRightClk)} {
        return
    }
    vTcl:set_mouse_coords $X $Y $x $y
    if {[info exists vTcl(multi_select_list)] \
            && $i in $vTcl(multi_select_list)} {
        $vTcl(gui,rc_multi_menu) post $X $Y
        set vTcl(multi_select_widget) $i
        grab $vTcl(gui,rc_multi_menu)
        bind $vTcl(gui,rc_multi_menu) <ButtonRelease> {
            grab release $vTcl(gui,rc_multi_menu)
            $vTcl(gui,rc_multi_menu) unpost
        }
        return
    }
    vTcl:active_widget $i
    $vTcl(gui,rc_menu) post $X $Y
    grab $vTcl(gui,rc_menu)
    bind $vTcl(gui,rc_menu) <ButtonRelease> {
        grab release $vTcl(gui,rc_menu)
        $vTcl(gui,rc_menu) unpost
    }
}

proc vTcl:button2_click_tree {w i b j x} {
    # Come here when a widget is selected upon <ButtonRelease-2> and
    # add to vTcl(multi_select_list) which colors it in the widget tree.
    global vTcl
    set class [vTcl:get_class $w]
    if {$class eq "Toplevel"} { return }
    vTcl:bind_button_multi $w 0 0 0 0  ;# Adds to MS list
    vTcl:replace_all_multi_handles
    vTcl:bind_release_multi $w 0 0 0 0
}

proc vTcl:shift_button2_tree {i w b j} {
    # Come here when a widget is selected with Shift-Button2. Remove
    # it from vTcl(multi_select_list) which also un-colors it in
    # widget tree.
    global vTcl
    vTcl:drop_multi_target $w
}

# returns the number of levels to offset for a megawidget
#
# the parameter is prearranged as a list whose first
# parameter is the widget and the remainder is a list
# of offsets
#
# (for example "{.top35 .tab36} -4" will return -4
#  but         "{.top35 .tab36 ... .tab35} -4 -4" returns -8

proc vTcl:get_tree_diff {path} {
    if {[llength $path] == 1} {return ""}

    set size [llength $path]
    set diff 0
    for {set i 1} {$i < $size} {incr i} {
        set diff [incr diff [lindex $path $i]]
    }

    return $diff
}

# counts the number of children without menu items
proc vTcl:count_children {w} {
    set children [vTcl:get_children $w]

    # special menu items have .# in their path
    if {[string first .\# $children] == -1} {
        return [llength $children]
    }

    # so let's count 'em
    set count 0
    foreach child $children {
        if {![string match *.\#* $child]} {incr count}
    }

    return $count
}

proc vTcl:indent {widget} {
    global vTcl
    set pieces [split $widget "."]
    set count [llength $pieces]
    return [string repeat $vTcl(tab) [expr $count - 1]]
} ;# End indent


proc vTcl:save_wtree {} {
    # Saves the Widget Tree to a file in the PWD with a default file
    # type '.tre' because of the the 3 char limit to MS file
    # extensions. Each Widget Tree entry is augmented to include
    # callbacks from bindings and commands.  Rozen May 2018.
    global vTcl
    # if {$vTcl(project,file) == ""} {
    #     set file [vTcl:get_file save "Save Tree"]
    # } else {
    #     vTcl:save2 $vTcl(project,file)
    # }
    set file [vTcl:get_file print]
    if {$file == ""} {
        return
    }
    set tree [vTcl:complete_widget_tree]
    foreach ii $tree {
        set ii   [split $ii \#]
        set i    [lindex $ii 0]
        set class [winfo class $i]
        if {$i == "."} {
            append output "PAGE" "\n"
            continue
        }
        if {$class == "Scrollbar"} {
            continue
        }
        if {$class == "Menu"} {
            # It's a menu
            set ll [split $ii "."]
            set pop [string first ".pop" $i]
            if {([llength $ll] > 2 && $pop > -1 ) || \
                    ([llength $ll] > 3 && $pop == -1)} {
                continue
            }
        }
        if {[string first "vTH_" $ii] > -1} continue ;# skip over handles
        set ind [vTcl:indent $ii]
        set t [vTcl:widget:get_tree_label $i]
        set o_str ""
        append  o_str  $ind $t
        set len_o_str [string length $o_str]
        set cmd ""
        catch {set cmd [$i cget -command]}
        if {$cmd != ""} {
            append o_str " " command: " " $cmd
        }
        set bind [bind $i]
        foreach b $bind {
            append o_str \
                " " bind: " "  $b " to \{" [string trim [bind $i $b]] "\}"
        }
        set bind [bind $class]
        foreach b $bind {
            set binding [string trim [bind $i $b]]
            if {$binding != "" && [string first $b $o_str] == -1 } {

                append o_str " " bind: " "  $b " \{" $binding "\}"
            } ;# end if
        }
        append output $o_str "\n"
    }
    set tree_file [open $file w]
    puts $tree_file $output
    close $tree_file
}

proc vTcl:init_wtree {{wants_destroy_handles 1}} {
    # Function to fill in the widget tree.
    global vTcl widgets classes
    # do not refresh the widget tree if it does not exist
    if {![winfo exists .vTcl.tree]} return
    if {![info exists vTcl(tree,width)]} { set vTcl(tree,width) 0 }
    set b .vTcl.tree.cpd21.03

    # save scrolling position first
    set vTcl(tree,last_yview) [lindex [$b yview] 0]

    #vTcl:destroy_handles

    vTcl:clear_wtree
    vTcl:clear_search
    vTcl:get_fill_colors
    # set fill $vTcl(actual_fg)
    set fill #000000                  ;# NEEDS WORK dark Sun
    set y 10
    set vTcl(from_init_tree) 1        ;# Zeroed at the bottom of this function.
    set tree [vTcl:complete_widget_tree]
    foreach ii $tree {
        set ii   [split $ii \#]
        set i    [lindex $ii 0]
        set class [winfo class $i]
        if {[string first "vTH" $ii] > -1} { continue }
        if {$i != "."} {
            set parent [winfo parent $i]
            set parent_class [winfo class $parent]
        }
        if {$class == "Menu"} {
            # It's a menu
            set ll [split $ii "."]
            set pop [string first ".pop" $i]
            if {([llength $ll] > 2 && $pop > -1 ) || \
                    ([llength $ll] > 3 && $pop == -1)} {
                continue
            }
        }
        # if {$i != "." && [string first "Scroll" $parent_class] == 0} {
        #     continue
        # }
        if {$class == "Scrollbar"} {
            continue
        }
        set diff [vTcl:get_tree_diff $ii]
        if {$i == "."} {
            set depth 1
        } else {
            set depth [llength [split $i "."]]
        }
        if {$diff!=""} {set depth [expr $depth + $diff]}
        set depth_minus_one [expr $depth - 1]
        set x [expr $depth * 30 - 15]
        set x2 [expr $x + 40]
        set y2 [expr $y + 15]
        set j [vTcl:rename $i]
        if {$i == "."} {
            set c vTclRoot
            set t "PAGE"  ;# Rozen
        } else {
            set c [vTcl:get_class $i]
            set t {}
        }
        if {[winfo exists $b.$j]} {
            $b coords $b.$j $x $y
            incr y 30
            continue
        }

        if {$i != "." && $classes(${c},megaWidget)} {
            set childSites [lindex $classes($c,treeChildrenCmd) 1]
            if {$childSites != ""} {
                set l($depth) [llength [$childSites $i]]
            } else {
                set l($depth) 0
            }
        } else {
            set l($depth) [vTcl:count_children $i]
        }
        if {$i == "."} {
            incr l($depth) -1
        }
        switch $class {
            Scrolledentry -
            Scrolledtext -
            Scrolledlistbox -
            Scrolledspinbox -
            Scrolledcanvas -
            Scrolledwindow -
            Scrolledtreeview {
                incr  l($depth) -1
            }
        }
        if {$depth > 1} {
            if {[info exists l($depth_minus_one)]} {
                incr l($depth_minus_one) -1
            } else {
                set l($depth_minus_one) 1
            }
        }
        set cmd vTcl:show
        if {$c == "Toplevel" || $c == "vTclRoot"} { set cmd vTcl:show_top }
        set left_click_cmd  "vTcl:left_click_tree $cmd $i $b $j"
        set right_click_cmd "vTcl:right_click_tree $i %X %Y %x %y"
        set Button2_click_cmd "vTcl:button2_click_tree $i %X %Y %x %y"
        set Shift_Button2_click_cmd "vTcl:shift_button2_tree $cmd $i $b $j"
        set double_B1_click_cmd "vTcl:double_B1_click_tree $i %X %Y %x %y"
        set Shift_Button1_click_cmd "vTcl:expand_contract_tree $i"
        button $b.$j -image [vTcl:widget:get_image $i] -command $left_click_cmd
        $b.$j configure -background $vTcl(actual_bg) ;# NEEDS WORK theme
        bind $b.$j <ButtonRelease-3>  $right_click_cmd
        # If the two below are ButtonRelease events, then two events occur.
        bind $b.$j <ButtonRelease-2> $Button2_click_cmd
        bind $b.$j <Shift-ButtonRelease-2> $Shift_Button2_click_cmd
        # if {$class in $vTcl(tree_containers)} {
        #     bind $b.$j <Shift-ButtonRelease-1> $Shift_Button1_click_cmd
        # }
        vTcl:set_balloon $b.$j $i
        $b create window $x $y -window $b.$j -anchor nw -tags $b.$j
        # vTcl:widget:get_tree_label returns the label.
        if {[lempty $t]} {
            set t [vTcl:widget:get_tree_label $i]
            # if {[info exists vTcl(contract,$i)] && $vTcl(contract,$i)} {
            #     set t [concat  $t "(shell)"]
            # }
        }
        set t [string trim $t]
        if {[regexp {^\.bor} $i]} {
            set t_len [font measure $vTcl(pr,font_dft) $t]
            set t_ascent [font metrics $vTcl(pr,font_dft) -ascent]
            set xx1 [expr {$x2 - 5}]
            set yy1 [expr {$y2 - ($t_ascent / 2) - 5}]
            set xx2  [expr {$x2 + $t_len + 5}]
            set yy2 [expr {$y2 + ($t_ascent / 2) + 5}]
            # $b create rectangle $xx1 $yy1  $xx2 $yy2  -fill plum
            $b create rectangle $xx1 $yy1  $xx2 $yy2  -fill plum -tags RECT
        }

        set t_len [font measure $vTcl(pr,font_dft) $t]
        # create returns the id of the new item
        if {$i in $vTcl(multi_select_list)} {
            set t_fill $vTcl(green_fill)
        } elseif {$i eq $vTcl(w,widget)} {
            set t_fill $vTcl(red_fill)
        } else {
            set t_fill $fill
        }
        set t \
            [$b create text $x2 $y2 -text $t -anchor w  \
                 -tags "TEXT TEXT$b.$j" \
                 -fill $t_fill -font $vTcl(pr,font_dft)] ;# NEEDS WORK dark
        # -
            if {[info exists vTcl(contract,$i)] && $vTcl(contract,$i)} {
                #     set t [concat  $t "(shell)"]
        set xx [expr $x2 + $t_len]
                $b create text $xx $y2 -text " (shell)" -anchor w  \
                 -fill red -font $vTcl(pr,font_dft) ;# NEEDS WORK dark
                 #-tags "TEXT TEXT$b.$j"
            }
        $b bind TEXT$b.$j <ButtonPress-1> $left_click_cmd
        $b bind TEXT$b.$j <Double-Button-1> $double_B1_click_cmd
        $b bind TEXT$b.$j <ButtonRelease-3> $right_click_cmd
        $b bind TEXT$b.$j <ButtonRelease-2> $Button2_click_cmd
        $b bind TEXT$b.$j <Shift-ButtonRelease-2> $Shift_Button2_click_cmd
        if {$class in $vTcl(tree_containers)} {
            $b bind TEXT$b.$j <Shift-ButtonRelease-1> $Shift_Button1_click_cmd
        }
        set size [lindex [$b bbox $t] 2]
        if {$size > $vTcl(tree,width)} { set vTcl(tree,width) $size }

        set d2 $depth_minus_one
#        set fill $vTcl(pr,fgcolor)
        for {set k 1} {$k <= $d2} {incr k} {
            if {![info exists l($k)]} {set l($k) 1}
            if {$depth > 1} {
                set xx2 [expr $k * 30 + 15]
                set xx1 [expr $k * 30]
                set yy1 [expr $y + 30]
                set yy2 [expr $y + 30 - 15]
                if {$k == $d2} {
                    if {$l($k) > 0} {
                        $b create line $xx1 $y $xx1 $yy1 -tags LINE \
                            -fill $fill
                        $b create line $xx1 $yy2 $xx2 $yy2  -tags LINE \
                            -fill $fill
                    } else {
                        $b create line $xx1 $y $xx1 $yy2 -tags LINE \
                            -fill $fill
                        $b create line $xx1 $yy2 $xx2 $yy2 -tags LINE \
                            -fill $fill
                    }
                } elseif {$l($k) > 0} {
                    $b create line $xx1 $y $xx1 $yy1 -tags LINE \
                        -fill $fill
                }
            }
        }

        incr y 30
    }
    $b configure -scrollregion "0 0 [expr $vTcl(tree,width) + 30] $y"
    if {!$wants_destroy_handles} {
        vTcl:create_handles $vTcl(w,widget)
        vTcl:place_handles $vTcl(w,widget)
        vTcl:show_selection_in_tree $vTcl(w,widget)
    }
    # Restore scrolling position
    $b yview moveto $vTcl(tree,last_yview)
    set vTcl(from_init_tree) 0

}

proc vTcl:expand_contract_tree {i} {
    global vTcl
    if {[info exists vTcl(contract,$i)]} {
        if {$vTcl(contract,$i)} {
            set vTcl(contract,$i) 0
        } else {
            set vTcl(contract,$i) 1
        }
    } else {
        set vTcl(contract,$i) 1
    }
    vTcl:init_wtree
}
proc vTcl:canvas_top {canvas} {
    # Move to top left of the canvas.
    $canvas yview moveto  0
    $canvas xview moveto  0
}

proc vTclWindow.vTcl.tree {args} {
    # Since I don't allow the user to close the Widget Tree, I
    # commented out all references to the buttonClose.
    global vTcl
    set base .vTcl.tree
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    toplevel $base -class vTcl
    #wm transient $base .vTcl
    wm withdraw $base
    wm focusmodel $base passive
    wm geometry $base 380x375+75+142
    #wm maxsize $base 1137 870
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm title $base "Widget Tree"
    # wm protocol $base WM_DELETE_WINDOW "wm withdraw $base"
    wm protocol $base WM_DELETE_WINDOW {
        vTcl:error "You cannot remove the Widget Tree"
    }

    frame $base.frameTop
    # Size of buttons in characters
    set height 3
    set width 8
    button $base.frameTop.buttonRefresh \
        -command "vTcl:init_wtree" -relief raised \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -image [vTcl:image:get_image "basic_reload_white.gif"]
        # -image [vTcl:image:get_image "view_refresh_white.gif"]
    button $base.frameTop.buttonSave \
        -command "vTcl:save_wtree" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -image [vTcl:image:get_image "floppy_white.gif"]
        #-image [vTcl:image:get_image "document_save_as_white.gif"]
    button $base.frameTop.buttonTop \
        -command "vTcl:canvas_top $base.cpd21.03" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -image [vTcl:image:get_image "go_top.gif"]
        # -image [vTcl:image:get_image "arrow_top.gif"]
    button $base.frameTop.buttonRemoveMulti \
        -command "vTcl:remove_multi_selections" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -image [vTcl:image:get_image "sort_ascending_white.gif"]
# New
    button $base.frameTop.buttonCloseBorrowed \
        -command "vTcl:close_borrowed_project" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -image [vTcl:image:get_image "exit.gif"]
        # -image [vTcl:image:get_image "delete_32_white.gif"]
    button $base.frameTop.buttonExpandShells \
        -text "Expand\nAll\nShells" -relief raised \
        -command "vTcl:expand_all_shells" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -image [vTcl:image:get_image "expand.gif"]
        # -image [vTcl:image:get_image "ash_cloud_32_white.gif"]
# New
    # ::vTcl::CancelButton $base.frameTop.buttonClose \
    #     -command "Window hide $base"
    #     # -command "wm withdraw $base"
    # vTcl:set_balloon $base.frameTop.buttonClose "Close window."
# For debugging search
    #  ::vTcl::CancelButton $base.frameTop.buttonClose \
    #    -command "vTcl:search_wtree"
    #     # -command "wm withdraw $base"
    # vTcl:set_balloon $base.frameTop.buttonClose "Close window."


    # One needs lib_bwidget to get the scrolled window below. Rozen
    ScrolledWindow $base.cpd21
    canvas $base.cpd21.03 -highlightthickness 0 \
        -borderwidth 0 \
        -background #d9d9d9 -borderwidth 0 -closeenough 1.0 -relief flat
        #-closeenough 1.0 -relief flat
        #-background $vTcl(actual_bg)
    $base.cpd21 setwidget $base.cpd21.03

    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.frameTop \
        -in $base -anchor center -expand 0 -fill x -side top
    pack $base.frameTop.buttonRefresh \
        -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.buttonSave \
        -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.buttonTop \
        -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.buttonRemoveMulti \
        -in $base.frameTop -anchor center -expand 0 -fill none -side left
# New
    pack $base.frameTop.buttonCloseBorrowed \
        -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.buttonExpandShells \
        -in $base.frameTop -anchor center -expand 0 -fill none -side left
# New
    #pack $base.frameTop.buttonClose \
        -in $base.frameTop -anchor center -expand 0 -fill none -side right
    pack $base.cpd21 \
        -in $base -anchor center -expand 1 -fill both -side top
    #pack $base.cpd21.03  ;# Rozen  BWidget

    #ttk::style configure PyConsole.TSizegrip \
        -background $vTcl(actual_bg) ;# 11/22/12
    #grid [ttk::sizegrip $base.cpd21.sz -style "PyConsole.TSizegrip"] \
        -column 999 -row 999 -sticky se
    #pack [ttk::sizegrip $base.cpd21.sz -style "PyConsole.TSizegrip"] \
        -side right -anchor se
    #place [ttk::sizegrip $base.sz -style PyConsole.TSizegrip] \
        -in $base -relx 1.0 -rely 1.0 -anchor se

    # New stuff for searching

    frame $base.frame_bottom
    label $base.frame_bottom.labelReport \
        -text "" -relief flat \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg) \
        -width 25 \
        -textvariable vTcl(searchReport)

    button $base.frame_bottom.button_search \
        -text "S" -relief flat \
        -command "vTcl:search_wtree  \[$base.frame_bottom.entrySearch get\]"
    entry $base.frame_bottom.entrySearch \
        -width 16 \
        -foreground #000000

    button $base.frame_bottom.button_next \
        -text "P" \
        -relief flat -command "vTcl:display_next previous"

    button $base.frame_bottom.button_previous \
        -relief flat -command "vTcl:display_next next" \
        -text "P"
    pack $base.frame_bottom \
        -in $base -anchor center -expand 0 -fill x -side top
    pack $base.frame_bottom.button_search \
        -in $base.frame_bottom -anchor center -expand 0 -fill none -side right
    pack $base.frame_bottom.button_next \
        -in $base.frame_bottom -anchor center -expand 0 -fill none -side right
    pack $base.frame_bottom.button_previous \
        -in $base.frame_bottom -anchor center -expand 0 -fill none -side right
    pack $base.frame_bottom.entrySearch \
        -in $base.frame_bottom -anchor center -expand 0 -fill none -side right
    pack $base.frame_bottom.labelReport \
        -in $base.frame_bottom -anchor center -expand 0 -fill none -side right
    set vTcl(search_string) ""
    bind $base.frame_bottom.entrySearch <KeyRelease-Return> "
        vTcl:search_wtree \[$base.frame_bottom.entrySearch get\] "

    # End of searching widgets

    vTcl:set_balloon  $base.frameTop.buttonRefresh "Refresh the Widget Tree"
    vTcl:set_balloon  $base.frameTop.buttonSave "Save the Widget Tree"
    vTcl:set_balloon $base.frameTop.buttonTop   "Move to top of Widget Tree"
    vTcl:set_balloon $base.frameTop.buttonRemoveMulti \
        "Unselect all Multiple Selections"
# New
    vTcl:set_balloon $base.frameTop.buttonCloseBorrowed \
        "Close Borrowed Project"
    vTcl:set_balloon $base.frameTop.buttonExpandShells \
        "Expand All Shells"
# New
    catch {wm geometry .vTcl.tree $vTcl(geometry,.vTcl.tree)}
    vTcl:init_wtree
    vTcl:setup_vTcl:bind $base
    vTcl:BindHelp $base WidgetTree
    bind $::vTcl(gui,tree).cpd21.03 <Enter> \
        {vTcl:bind_mousewheel  $::vTcl(gui,tree).cpd21.03}
    bind $::vTcl(gui,tree).cpd21.03 <Leave> \
        {vTcl:unbind_mousewheel $::vTcl(gui,tree).cpd21.03}

    # When you enter the console window raise it to the top.
    bind $base <Enter> "raise $base"
    wm deiconify $base
}

# New
proc vTcl:close_borrowed_project {} {
    # Recursive procedure
    set tree [vTcl:complete_widget_tree]
    foreach ii $tree {
        set ii   [split $ii \#]
        set i    [lindex $ii 0]
        set class [winfo class $i]
        if {[string first "vTH" $ii] > -1} { continue }
        # if {$i != "."} {
        #     set parent [winfo parent $i]
        #     set parent_class [winfo class $parent]
        # }
        if {$class eq "Toplevel" && [regexp {^\.bor} $i]} {
            vTcl:delete "" $i
            vTcl:close_borrowed_project
            return
        }
    }
}

proc vTcl:expand_all_shells { } {
    global vTcl
    array unset  vTcl contract,*
    vTcl:init_wtree
}

