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
# vTcl:left_click_tree
# vTcl:shift_button2_tree

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

proc vTcl:show_selection {button_path target} {
    global vTcl
    # do not refresh the widget tree if it does not exist
    if {![winfo exists .vTcl.tree]} {
        return }

    if {[vTcl:streq $target "."]} {
        return }

    vTcl:log "widget tree select: $button_path"
    set b .vTcl.tree.cpd21.03
    if {$target ni $vTcl(multi_select_list)} {
        # This is to remove last selected coloring.
        if {$vTcl(tree,last_selected)!=""} {
            $b itemconfigure "TEXT$vTcl(tree,last_selected)" \
                -fill $vTcl(pr,fgcolor)
            update
        }
    }
    set fill $vTcl(pr,fgcolor)
    if {![lempty $vTcl(pr,treehighlight)]} {
        set fill $vTcl(pr,treehighlight)
    }

    if {$target in $vTcl(multi_select_list)} {
        set fill "green"
        lappend vTcl(tree,green_tags) $button_path
    }
    # if {$vTcl(remove_all_multi)} { ;# New  Remove all the multi select coloring.
    #     foreach t $vTcl(tree,green_tags) {
    #         $b itemconfigure "TEXT$t" -fill $vTcl(pr,fgcolor)
    #     }
    #     set vTcl(tree,green_tags) [list]
    # }
    $b itemconfigure "TEXT$button_path" -fill $fill
    if {$target ni $vTcl(multi_select_list)} {  ;# new
        # This test is here so that only the regular selected widget
        # is remembered and not any multi selected widgets.
        set vTcl(tree,last_selected) $button_path
    }
    update
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
    $b delete TEXT LINE
    set vTcl(tree,green_tags) [list]     ;# New
    $b configure -scrollregion "0 0 0 0"
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
            $b itemconfigure "TEXT$b.$j" -fill $vTcl(pr,fgcolor)
        }
    }
}

proc vTcl:left_click_tree {cmd i b j} {
    # Come here when one clicks B1 on a widget in the tree.
    global vTcl
    if {$::classes([vTcl:get_class $i],ignoreLeftClk)} return
    if {$vTcl(mode) == "TEST"} return

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
    vTcl:active_widget $i
    vTcl:show_selection $b.$j $i
}

proc vTcl:right_click_tree {i X Y x y} {
    global vTcl
    if {$::classes([vTcl:get_class $i],ignoreRightClk)} {
        return
    }
    if {$vTcl(mode) == "TEST"} return
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

proc vTcl:button2_click_tree {cmd i b j} {
    # Come here when a widget is selected upon <ButtonRelease-2> and
    # add to vTcl(multi_select_list) which colors it in the widget tree.
    global vTcl
    set i_class [vTcl:get_class $i]
    if {$i_class eq "Toplevel"} { return }
    vTcl:bind_button_multi $i 0 0 0 0  ;# Adds to MS list
    vTcl:replace_all_multi_handles
    vTcl:bind_release_multi $i 0 0 0 0
}

proc vTcl:shift_button2_tree {cmd i b j} {
    # Come here when a widget is selected with Button2. Remove it from
    # vTcl(multi_select_list) which also un-colors it in widget tree.
    global vTcl
    vTcl:drop_multi_target $i
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

    vTcl:destroy_handles

    vTcl:clear_wtree
    set y 10
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
        set Button2_click_cmd "vTcl:button2_click_tree $cmd $i $b $j"
        set Shift_Button2_click_cmd "vTcl:shift_button2_tree $cmd $i $b $j"
        button $b.$j -image [vTcl:widget:get_image $i] -command $left_click_cmd
        bind $b.$j <ButtonRelease-3>  $right_click_cmd
        # If the two below are ButtonRelease events, then two events occur.
        bind $b.$j <ButtonRelease-2> $Button2_click_cmd
        bind $b.$j <Shift-ButtonRelease-2> $Shift_Button2_click_cmd
        vTcl:set_balloon $b.$j $i
        $b create window $x $y -window $b.$j -anchor nw -tags $b.$j
        # vTcl:widget:get_tree_label returns the label.
        if {[lempty $t]} { set t [vTcl:widget:get_tree_label $i] }
        set t \
            [$b create text $x2 $y2 -text $t -anchor w -font $vTcl(pr,font_dft) \
                 -tags "TEXT TEXT$b.$j" \
                 -fill $vTcl(pr,fgcolor)]
        $b bind TEXT$b.$j <ButtonPress-1> $left_click_cmd
        $b bind TEXT$b.$j <ButtonRelease-3> $right_click_cmd
        $b bind TEXT$b.$j <ButtonRelease-2> $Button2_click_cmd
        $b bind TEXT$b.$j <Shift-ButtonRelease-2> $Shift_Button2_click_cmd
        set size [lindex [$b bbox $t] 2]
        if {$size > $vTcl(tree,width)} { set vTcl(tree,width) $size }

        set d2 $depth_minus_one
        set fill $vTcl(pr,fgcolor)
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
}

proc vTcl:canvas_top {canvas} {
    # Move to top left of the canvas.
    $canvas yview moveto  0
    $canvas xview moveto  0
}

proc vTclWindow.vTcl.tree {args} {
    global vTcl
    set base .vTcl.tree
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    toplevel $base -class vTcl
    #wm transient $base .vTcl
    wm withdraw $base
    wm focusmodel $base passive
    wm geometry $base 296x243+75+142
    #wm maxsize $base 1137 870
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm title $base "Widget Tree"
    wm protocol $base WM_DELETE_WINDOW "wm withdraw $base"

    frame $base.frameTop
    vTcl:toolbar_button $base.frameTop.buttonRefresh \
        -image [vTcl:image:get_image "refresh.gif"] \
        -command vTcl:init_wtree
    button $base.frameTop.buttonSave \
        -text Save -relief flat \
        -command "vTcl:save_wtree" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)
    button $base.frameTop.buttonTop \
        -text Top -relief flat \
        -command "vTcl:canvas_top $base.cpd21.03" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)
    button $base.frameTop.buttonRemoveMulti \
        -text "Unselect MS" -relief flat \
        -command "vTcl:remove_multi_selections" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)
    ::vTcl::CancelButton $base.frameTop.buttonClose \
        -command "Window hide $base"
        # -command "wm withdraw $base"
    vTcl:set_balloon $base.frameTop.buttonClose "Close window."

    # One needs lib_bwidget to get the scrolled window below. Rozen
    ScrolledWindow $base.cpd21
    canvas $base.cpd21.03 -highlightthickness 0 \
        -background $vTcl(actual_bg) \
        -borderwidth 0 \
        -closeenough 1.0 -relief flat
      #-background #ffffff -borderwidth 0 -closeenough 1.0 -relief flat
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
    pack $base.frameTop.buttonClose \
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

    vTcl:set_balloon  $base.frameTop.buttonRefresh "Refresh the widget tree"
    vTcl:set_balloon $base.frameTop.buttonTop   "Move to top"
    vTcl:set_balloon $base.frameTop.buttonRemoveMulti \
        "Unselect all Multiple Selections"
    vTcl:set_balloon $base.frameTop.buttonClose   "Close"

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
