##############################################################################
# callback.tcl - procedures for displaying callbacks tied to a particular widget.
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

# vTcl:show_callbacks
# vTcl:update_callback_list
# vTcl:callback:show
# vTcl:show_function
# vTclWindow.vTcl.callback
# vTcl:show_all_callbacks
# vTcl:search_callback

proc vTcl:show_all_callbacks {} {
    # Called from main memu -> Window. It opens a window and displays
    # all of the callback functions that have been specified.
    global vTcl
    vTclWindow.vTcl.callback
    Window show $vTcl(gui,callback)
    set vTcl(callback_search_pattern) ""
    set tree [vTcl:complete_widget_tree]
    foreach ii $tree {
        set ii   [split $ii \#]
        set i    [lindex $ii 0]
        set class [winfo class $i]
        if {$i == "."} {
            continue
        }
        if {[string first "vTH_" $i] > -1} {
            continue
        } ;# end if

        if {$class == "Scrollbar"} {
            continue
        }
        if {$class == "Menu"} {
            # It's a menu
            set wrote_label 0
            set ll [split $ii "."]
            set pop [string first ".pop" $i]
            # the first clause below is for regular menus; the second, popups.
            if {([llength $ll] == 3 && $pop == -1)
                || ($pop > -1 && [llength $ll] == 2)} {
                set t [vTcl:widget:get_tree_label $i]
            }
            if {([llength $ll] > 2 && $pop > -1 ) || \
                    ([llength $ll] == 3 && $pop == -1)} {
                set vTcl(toplevel_menu) ""
                set vTcl(support_function_list) [list]
                vTcl:python_inspect_menu_config $i
                if {[llength $vTcl(support_function_list)]} {
                    if {!$wrote_label} {
                        lappend  o_str  "$t"
                        set wrote_label 1
                    }
                    foreach b $vTcl(support_function_list) {
                        lappend o_str "   command: $b"
                    }
                }
                continue
            }
        }
        set ind [vTcl:indent $ii]
        set t [vTcl:widget:get_tree_label $i]
        set cmd ""
        catch {set cmd [$i cget -command]}
        if {$cmd != ""} {
            lappend  o_str  "$t"
            lappend o_str "   command: $cmd"
        }
        set bind [bind $i]
        if {[llength $bind] > 0} {
            lappend  o_str  "$t"
        }
        foreach b $bind {
            lappend o_str \
                "   bind:  $b  to \{ [string trim [bind $i $b]] \}"
        }
        set bind [bind $class]
        foreach b $bind {
            set binding [string trim [bind $i $b]]
            if {$binding != "" && [string first $b $o_str] == -1 } {
                lAppend o_str "   bind: $b  \{ $binding \} \n"
            } ;# end if
        }
    }
    if {[info exists o_str]} {
        vTcl:callback:show 2 $o_str
    }
    raise $::vTcl(gui,callback)
}

proc vTcl:show_callbacks {} {
    # Called from the Right Click Menu on selecting a widget. It sees
    # if a command attribute is present and records it. It then finds
    # all bindings for the widget and records them. It finally opens a
    # window to display the bindings.
    vTcl:callback:show 1
}

proc vTcl:update_callback_list {} {
    # Generates the callback list for a single widget.
    global vTcl
    if {![winfo exists $vTcl(gui,callback)]} { return }
    if {$vTcl(w,widget) != ""} {
        set i $vTcl(w,widget)
        set class [winfo class $i]
        set callbacks [list]
        set t [vTcl:widget:get_tree_label $i]
        lappend callbacks "$t"
        set cmd ""
        # Add command if one exists.
        catch {set cmd [$i cget -command]}
        if {$cmd != ""} {
            lappend callbacks "   command: $cmd"
        }
        # Add any callbacks
        set bind [bind $i]
        foreach b $bind {
            lappend callbacks \
                "   bind:  $b  to \{ [string trim [bind $i $b]] \}"
        }
        set bind [bind $class]
        foreach b $bind {
            set binding [string trim [bind $i $b]]
            if {$binding != "" && [string first $b $o_str] == -1 } {
                lappend callbacks \
                    [concat bind: " "  $b " \{" $binding "\}"]
            } ;# end if
        }
    } else {
        ::vTcl::MessageBox -icon error -message "No widget selected!" \
            -title "Error!" -type ok
    }
    # $vTcl(gui,callback).f2.list delete 0 end
    $vTcl(gui,callback).cpd21.03 delete 1.0 end
    if {[llength $callbacks] == 0} {
        # $vTcl(gui,callback)f2.list insert end "No Callback for Widget"
        $vTcl(gui,callback).cpd21.03 insert end "No Callback for Widget"
    } else {
        foreach c $callbacks {
            # $vTcl(gui,callback).cpd21.03 insert end $c
            $vTcl(gui,callback).cpd21.03 insert end "${c}\n"
        }
    }
}
proc vTcl:callback:show {{on 1} {callbacks ""}} {
    global vTcl
    if {$on == 1} {
        Window show $vTcl(gui,callback)
        vTcl:update_callback_list                ;# NEEDS WORK
    } elseif {$on == 2} {
        Window show $vTcl(gui,callback)
        # $vTcl(gui,callback).f2.list delete 1 end
        $vTcl(gui,callback).cpd21.03 delete 1.0 end
        if {[llength $callbacks] == 0} {
            # $vTcl(gui,callback).f2.list insert end "No Callback for Widget"
            $vTcl(gui,callback).cpd21.03 insert end "No Callback for Widget"
        } else {
            foreach c $callbacks {
                # $vTcl(gui,callback).f2.list insert end $c
                $vTcl(gui,callback).cpd21.03 insert end "${c}\n"
            }
        }
    } else {
        Window hide $vTcl(gui,callback)
    }
}

proc vTcl:show_function {line} {
    # If there is an existing source console, usually containing the
    # support module it is searched. It is the users responsibility to
    # make sure it is current; the "save warning" should be used as a
    # guide. If a source console does not exist, one is loaded from disk.

    # 'line' is the selection from the callback window. It is assumed
    # to be the function name to be searched for.

    global vTcl
    set name [string trim $line]
#     set name ""
#     # Line will not have both command and bind.
#     if {![regexp {command:\s+(\w+)} $line l name]} {
#         regexp {bind:.* (\w*)\(\w*\)} $line l name
#     }
#     if {$name == "lambda"} {
#         # Take lambda expression apart to find function name.
#         #regexp ?switches? exp string ?matchVar? ?subMatchVar subMatchVar ...?
#         regexp {lambda[\s]*.*:[\s]*(.*)[\s]*\(.*\)} $line l name
#     } ;# end if

    # Determine if one should search the GUI console or the support
    # console. Everything is in the support console except any popup
    # menu which will be a callback.
    if {$name != ""} {
        if { [string first "pop" $name] == -1} {
            # look in support module
            set prefix "supp"
            set fs "[file rootname $vTcl(project,file)]_support.py"
            set m_name "support"
        } else {
            # look in GUI module
            set prefix "gui"
            set fs "[file rootname $vTcl(project,file)].py"
            set m_name "GUI"
        } ;# end if

        if {[winfo exists $vTcl(gui,${prefix}_console)]} {
            Window show $vTcl(gui,${prefix}_console)
            update
        } else {
            set fs_exists [file exists $fs]
            if {!$fs_exists} {
                ::vTcl::MessageBox -title Error -message \
                    "No $m_name module available."
            return
        }
        # See if <<Modified>> 1 or 0. If the console is modified then

        # we want to do our search in existing console.
        # if {[info exists vTcl(${prefix}_source_window)]} {
        #     set modified [$vTcl(${prefix}_source_window) edit modified]
        # } else {
        #     set modified 0
        # }
        # if {!$modified } {
        #     vTcl:load_console $prefix $fs
        #     update
        #     set vTcl(${prefix}_save_warning) ""
        # }
            vTcl:load_console $prefix $fs
            update
            set vTcl(${prefix}_save_warning) ""
        }
        set vTcl(${prefix}_search_pattern) "def\\s+$name"
        vTcl:search_text $prefix
    }
}
proc vTcl:save_callbacks {} {
    # Saves the callback window to a file in the PWD with the default
    # file extension '.cbl'.
    global vTcl
    set file [vTcl:get_file callback]
    set output [$vTcl(gui,callback).cpd21.03 get 1.0 end]
    set callback_file [open $file w]
    puts $callback_file $output
    close $callback_file
}

proc vTcl:copy_callbacks {} {
    # Copies callback window to clipboard.
    global vTcl
    set output [$vTcl(gui,callback).f2.list get 0 end]
    clipboard clear
    foreach o $output {
        clipboard append $o\n
    }
}

proc vTcl:search_callback {} {
    global vTcl
    set source_window $::vTcl(gui,callback).cpd21.03
    set patt $vTcl(callback_search_pattern)
    if {$patt == ""} {
        # No pattern given.
        return
    } ;# end if
    $source_window tag remove highlight 1.0 end ;# Remove existing highlight.
    # The "-count cnt" below is the number of characters matched.
    set index [$source_window search -regexp -count cnt $patt insert]
    if {$index != ""} {
        $source_window mark set insert "$index+${cnt}c"
        $source_window see $index
        $source_window tag add highlight $index insert
        $source_window tag configure highlight -background plum
    } ;# end if
}

proc vTcl:display_selection {} {
    # Determines the selection string and calls vTcl:show_function to
    # display the function alluded to in the selection.
    global vTcl
    set vTcl(range) [.vTcl.callback.cpd21.03 tag ranges sel]
    set  start [lrange $vTcl(range) 0 0]
    set finish [lrange $vTcl(range) 1 1]
    if {$vTcl(range) != ""} {
        vTcl:show_function [.vTcl.callback.cpd21.03 get $start $finish]
    }
}

proc vTclWindow.vTcl.callback {args} {
    # Borrowed from tree.tcl to test window
    global vTcl
    set base .vTcl.callback
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    toplevel $base -class vTcl
    wm transient $base .vTcl
    wm withdraw $base
    wm focusmodel $base passive
    wm geometry $base 400x250+75+142
    #wm maxsize $base 1137 870
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm title $base "Callback List"
#    catch {wm geometry $base $vTcl(geometry,$base)}
    frame $base.frameTop ;#-relief raised  -borderwidth 4
    # vTcl:toolbar_button $base.frameTop.buttonRefresh \
    #     -image [vTcl:image:get_image "refresh.gif"]
    #        -command vTcl:init_wtree
    button $base.frameTop.b1 \
        -text Search \
        -command "vTcl:search_text callback" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)

    entry $base.frameTop.ent14 \
        -textvariable vTcl(callback_search_pattern)

    button $base.frameTop.b2 \
        -text Top \
        -command "vTcl:text_top callback" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)

        button $base.frameTop.save \
        -text Save \
        -command "vTcl:save_callbacks" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)

    button $base.frameTop.b3 \
        -text "Look up" \
        -command "vTcl:display_selection" \
        -background $vTcl(actual_bg) -foreground $vTcl(actual_fg)

    #::vTcl::OkButton $base.frameTop.buttonClose -command "Window hide $base"
    ::vTcl::CancelButton $base.frameTop.buttonClose\
        -command "
           set ::vTcl(geometry,.vTcl.callback) [wm geometry .vTcl.callback]
           wm withdraw $base"
    vTcl:set_balloon $base.frameTop.b2 "Move to top."
    vTcl:set_balloon $base.frameTop.b3 "Find selection in Python console."
    vTcl:set_balloon $base.frameTop.buttonClose "Close window."

    # One needs lib_bwidget to get the scrolled window below. Rozen

    ScrolledWindow $base.cpd21
    text $base.cpd21.03 -highlightthickness 0 \
        -background $vTcl(actual_bg) \
        -background $vTcl(area_bg) -foreground black \
        -borderwidth 0 -wrap none
       # -closeenough 1.0 -relief flat
      #-background #ffffff -borderwidth 0 -closeenough 1.0 -relief flat
    $base.cpd21 setwidget $base.cpd21.03

    bind $base.cpd21.03 <Button-3> {
        vTcl:display_selection
#         # set vTcl(x) [.vTcl.callback.cpd21.03 curselection]
#         set vTcl(range) [.vTcl.callback.cpd21.03 tag ranges sel]
# dmsg ranges: [.vTcl.callback.cpd21.03 tag ranges sel]

# dpr vTcl(range)
#         set  start [lrange $vTcl(range) 0 0]
#         set finish [lrange $vTcl(range) 1 1]
# dpr start finish
#         if {$vTcl(range) != ""} {
#             vTcl:show_function [.vTcl.callback.cpd21.03 get $start $finish]
#         }
    }

    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.frameTop \
        -in $base -anchor center -expand 0 -fill x -side top
    pack $base.frameTop.b1 \
         -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.ent14 \
          -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.b2 \
         -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.b3 \
         -in $base.frameTop -anchor center -expand 0 -fill none -side left
    pack $base.frameTop.save \
         -in $base.frameTop -anchor center -expand 0 -fill none -side left

    pack $base.frameTop.buttonClose \
        -in $base.frameTop -anchor center -expand 0 -fill none -side right
    pack $base.cpd21 \
        -in $base -anchor center -expand 1 -fill both -side top
    #pack $base.cpd21.03  ;# Rozen  BWidget
    ttk::style configure PyConsole.TSizegrip \
        -background $vTcl(actual_bg) ;# 11/22/12
    #grid [ttk::sizegrip $base.cpd21.sz -style "PyConsole.TSizegrip"] \
        -column 999 -row 999 -sticky se
    #pack [ttk::sizegrip $base.cpd21.sz -style "PyConsole.TSizegrip"] \
        -side right -anchor se
    #place [ttk::sizegrip $base.sz -style PyConsole.TSizegrip] \
        -in $base -relx 1.0 -rely 1.0 -anchor se

#    vTcl:set_balloon $base.frameTop.buttonRefresh "Refresh the widget tree"
#    vTcl:set_balloon $base.frameTop.buttonClose   "Close"
    bind $base.frameTop.ent14 <Return> "vTcl:search_text callback"
    catch {wm geometry .vTcl.callback $vTcl(geometry,.vTcl.callback)}
    vTcl:setup_vTcl:bind $base
    vTcl:BindHelp $base WidgetTree

    bind $::vTcl(gui,callback).cpd21.03 <Enter> \
        {vTcl:bind_mousewheel  $::vTcl(gui,callback).cpd21.03}
    bind $::vTcl(gui,callback).cpd21.03 <Leave> \
        {vTcl:unbind_mousewheel $::vTcl(gui,callback).cpd21.03}
    wm deiconify $base
}

proc vTcl:show_callback {} {
    global vTcl
    Window show .vTcl.callback
    wm geometry .vTcl.callback $vTcl(geometry,.vTcl.callback)
}
