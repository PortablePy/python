##############################################################################
# $Id: dump.tcl,v 1.1 2012/01/22 03:12:23 rozen Exp rozen $
#
# dump.tcl - procedures to export widget information
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

# Rozen. Pick up special procs at the bottom of dump.tcl in earlier
# version of page.

# vTcl:dump:widgets     Main dumping stuff
# vTcl:dump_widget_opt  Where the common widgets are dumped.
# vTcl:get_opts_special where option are put out
# vTcl:dump_widget_geom
# vTcl:dump:save_tops   generates "Window show" lines
# vTcl:dump
#

proc vTcl:dump_namespace {context} {

    set output ""
    set vars  [info vars ${context}::*]
    set procs [info procs ${context}::*]

    append output "namespace eval [list $context] \{\n\n"

    foreach var $vars {
        set name $var
        regsub -all {\:\:} $name @ name
        set name [lindex [split $name @] end]

        append output "set $name [list [vTcl:at $var]]\n\n"
    }

    foreach proc $procs {
        set name $proc
        regsub -all {\:\:} $name @ name
        set name [lindex [split $name @] end]

        set args ""
        foreach j [info args $proc] {
            if {[info default $proc $j value]} {
                lappend args [list $j $value]
            } else {
                lappend args $j
            }
        }

        set body [info body $proc]
        append output "\nproc [list $name] \{$args\} \{$body\}\n\n"
    }

    append output "\}\n"

    return $output
}

proc vTcl:dump_proc {i {type ""}} {
    if {[info procs $i] == ""} {return ""}

    set output ""
    set args ""
    foreach j [info args $i] {
        if {[info default $i $j value]} {
            lappend args [list $j $value]
        } else {
            lappend args $j
        }
    }

    set body [info body $i]

    append output {#############################################################################}
    append output "\n\#\# ${type}Procedure:  $i\n"

    if {[regexp (.*):: $i matchAll context] } {
        append output "\nnamespace eval [list ${context}] \{\n"
        append output "proc [list [lindex [split $i ::] end]] \{$args\} \{$body\}\n"
        append output "\}\n"
    } else {
        append output "\nproc [list ::$i] \{$args\} \{$body\}\n"
    }

    return $output
}

proc vTcl:save_procs {} {
    global vTcl
    set output ""
    set list $vTcl(procs)
    foreach i $list {
        if {[vTcl:ignore_procname_when_saving $i] == 0 && $i != "init"} {
            append output [vTcl:dump_proc $i]
        }
    }
    return $output
}

proc vTcl:export_procs {} {
    global vTcl classes
    # Since I never intend for the saved Tcl file to be executable, I
    # can dispense with these vtcl procedures and just return. Rozen
    # 1/16/13
    return ""
    # --------
    set output ""
    vTcl:dump:not_sourcing_header output
    set children [vTcl:complete_widget_tree . 0]

    set classList [vTcl::widgets::usedClasses .]
    foreach class $classList {
        if {[info exists classes($class,exportCmds)]} {
            eval lappend list $classes($class,exportCmds)
        }
        if {[info exists classes($class,widgetProc)]} {
            eval lappend list $classes($class,widgetProc)
        }
    }

    # support procs for multiple file projects
    if {[vTcl::project::isMultipleFileProject]} {
        lappend list chasehelper info_script
    }

    foreach i [concat Window [vTcl:lrmdups $list]] {
        append output [vTcl:dump_proc $i "Library "]
    }

    vTcl:dump:sourcing_footer output
    return $output
}

proc vTcl:dump:get_multifile_project_dir {project_name} {

    return [file rootname $project_name]_
}

proc vTcl:dump:get_top_filename {target basedir project_name} {

    return [file join $basedir \
                      [vTcl:dump:get_multifile_project_dir $project_name] \
                      f$target.tcl]
}

proc vTcl:dump:get_files_list {basedir project_name} {

    global vTcl

    if {![info exists vTcl(pr,projecttype)]} { return }
    if {$vTcl(pr,projecttype) == "single"}   { return }

    set result ""
    set tops ". $vTcl(tops)"

    foreach i $tops {
        lappend result [vTcl:dump:get_top_filename $i $basedir $project_name]
    }

    return $result
}

proc vTcl:dump_data_tofile {target_file target_data} {
    # @@ Proc added on 20030408 Nelson
    # Tests for backup operations and performs dumps
    # target_file is our output name and target_data is the data to dump.
    if {[file exists $target_file] && (![file exists $target_file.tmp]) } {
        # If we are here then the original file exists and no ${file}.tmp exists
        # We will move the original file to ${target_file}.tmp .
        # If all goes well during the save process then we can move
        # the ${target_file}.tmp to ${target_file}.bak .
        file rename -force ${target_file} ${target_file}.tmp
    } elseif {![file exists $target_file]} {
        # Do nothing here since implies we were called from a save as operation or it is a new addition!
    } else {
        # Give feedback here if things went wrong.
      ::vTcl::MessageBox -icon error -message \
            "$target_file.tmp already exists! This means for some reason a prior save attempt has failed!" \
            -title "Save Error!" -type ok
      ::vTcl::MessageBox -icon info -message \
            "To work around the $target_file.tmp error: Perform a perform a \"Save As\" operation with a different file name.\nThis will protect the data in the $target_file.tmp and save your current work." \
         -title "Save Information!" -type ok
      return 0
    }
    if {[catch {
        set fp [open $target_file w]
        puts $fp $target_data
        close $fp
    } errResult]} {
        # End the catch and give feedback here if things went wrong.
      ::vTcl::MessageBox -icon error -message \
            "An error occured during the dump_data_tofile operation:\n\n$errResult" \
            -title "Save Error!" -type ok

      # Move the original file back and do not mess with the .bak file.
        # First of all, close the messed up and uncompletely saved file.
        if {$fp != ""} {
            close $fp
        }
        if {[file exists ${target_file}.tmp]} {
               file rename -force ${file}.tmp ${file}
        }
    return 0
    } else {
        # All well if we get here and we need to move the ${target_file}.tmp to ${target_file}.bak
    if {[file exists ${target_file}.tmp]} {
            file rename -force ${target_file}.tmp ${target_file}.bak
        }
    return 1
    }

}
proc vTcl:dump_top_tofile {target basedir project_name} {

    global vTcl
    catch {
        file mkdir [file join $basedir \
                        [vTcl:dump:get_multifile_project_dir $project_name] ]
    }

    set filename [vTcl:dump:get_top_filename $target $basedir $project_name]
    ## @@ Modification  20030408 by Nelson
    set output ""
    append output "[subst $vTcl(head,projfile)]\n\n"
    append output [vTcl:dump_top $target]
    ## Make the call to get the data out and with backups.
    if {![vTcl:dump_data_tofile $filename $output]} {
        ## If we are here then something happend during the multifile
        ## project save and we need to make note of it.
        set output "::vTcl::MessageBox -icon error -message \"Error on $filename with multi file save! Project may be corrupted! If so try the Restore operation!\" -title \"Notification!\" -type ok\n\n"
    }
    ## @@ End Modification 20030408 by Nelson

    set output ""
    append output "if \[info exists _freewrap_progsrc\] \{\n"
    append output \
       "    source \"[vTcl:dump:get_top_filename $target $basedir $project_name]\"\n"
    append output "\} else \{\n"
    append output \
       "    source \"\[file join \[file dirname \[info_script\] \] [vTcl:dump:get_multifile_project_dir $project_name] f$target.tcl\]\"\n"
    append output "\}\n"

    return $output
}

proc vTcl:save_tree {target {basedir ""} {project_name ""}} {
    # Saves any popup menus and then saves the tree.
    global vTcl
    if {$vTcl(borrow)} {
        if {! [info exists vTcl(pr,projecttype)]} {
            set vTcl(pr,projecttype) single
        }
    }
    set output ""
    set vTcl(dumptops) ""
    set vTcl(showtops) ""
    set vTcl(var_update) "no"
    set vTcl(num,index) 0
    set tops ". $vTcl(tops)"
    #set tops ". $vTcl(real_top)"
    set vTcl(gen_proc) [list]

    vTcl:status "Saving: collecting data"
    set vTcl(num,total) [llength [vTcl:list_widget_tree $target]]

    # Code for special case of dummping any popup memu.
    append output [vTcl:dump_popup_menu]

    foreach i $tops {
        if {[string first ".bor" $i] > -1} {
            # Don't save borrowed stuff.
            continue
        }
        switch $vTcl(pr,projecttype) {
            single {
                append output [vTcl:dump_top $i]
            }
            multiple {
                append output [vTcl:dump_top_tofile $i $basedir $project_name]
            }
            default {
                append output [vTcl:dump_top $i]
            }
        }
    }
    if {[llength $vTcl(gen_proc)] > 0} {
        append output [vTcl:gen_dummy_procs]
    }
    append output "\n"
    vTcl:status "Saving: collecting options"
    append output [vTcl:dump:dump_user_bind]
    append output [vTcl:dump_validate_functions] "\n\n"
    append output [vTcl:dump:save_tops $i] ;# outputs the Window stuff
                                            # at end. Parameter i
                                            # added 11/20/2017.

    set vTcl(var_update) "yes"
    vTcl:statbar 0
    vTcl:status "Saving: writing data"
    return $output
}

proc vTcl:gen_dummy_procs {} {
    # Gem dummy procs for command options in slider widgets.
    global vTcl
    set output ""
    foreach proc $vTcl(gen_proc) {
        append output "proc $proc {args} { }\n"
    }
    return $output
}

proc vTcl:valid_class {class} {
    global vTcl
    if {[lsearch $vTcl(classes) $class] >= 0} {
        return 1
    } else {
        return 0
    }
}

proc vTcl:get_class {target {lower 0}} {
    if {$target == ""} {return ""}  ;# Rozen. To make popups work.
    set class [winfo class $target]
    ;# NEEDS WORK popup
    if {[regexp {^\.pop[0-9]+$} $target]} {
        set class Popupmenu
    }
    if {![vTcl:valid_class $class]} {
        set class Toplevel
    }
    if {$lower == 1} { set class [vTcl:lower_first $class] }
    return $class
}

# if basename is not empty then the -in option will have the
# value specified by basename
#
# example: -in .top27.fra32
#       => -in $base.fra32

proc vTcl:get_mgropts {opts {basename {}}} {
#    if {[lindex $opts 0] == "-in"} {
#        set opts [lrange $opts 2 end]
#    }
    set nopts ""
    set spot a
    foreach i $opts {
        if {$spot == "a"} {
            set o $i
            set spot b
        } else {
            set v $i
            switch -- $o {
                -ipadx -
                -ipady -
                -padx -
                -pady -
                -relx -
                -rely {
                    if {$v != "" && $v != 0} {
                        lappend nopts $o $v
                    }
                }
                -in {
                    if {$basename != ""} {
                        set v $basename
                    }

                    if {$v != ""} {
                        lappend nopts $o $v
                    }
                }
                default {
                    if {$v != ""} {
                        lappend nopts $o $v
                    }
                }
            }
            set spot a
        }
    }
    return $nopts
}

proc vTcl:get_opts {opts} {
    set ret ""
    foreach i $opts {
        lassign $i opt x x def val
        if {[vTcl:streq $opt "-class"] || [vTcl:streq $val $def]} { continue }
        lappend ret $opt $val
    }
    return $ret
}

## This proc works as get_opts_special but is intended for widget
## subcomponents (pages, columns, childsites) where the user cannot
## save or not save an option.
proc vTcl:get_subopts_special {opts w} {
    global vTcl
    if {[info exists ::widgets::${w}::subOptions::save]} {
        ## if there is a list of options to save, use it, and delegate
        ## to sister function to do so
        return [vTcl:get_subopts_special_save $opts $w]
    }
    set ret ""
    foreach i $opts {
        ## avoid option shortcuts (like -bg)
        if {[llength $i] != 5} {continue}

        lassign $i opt x x def val
        if {[vTcl:streq $opt "-class"] || [vTcl:streq $val $def]} { continue }
        if {[info exists vTcl(option,translate,$opt)]} {
            set val [$vTcl(option,translate,$opt) $val]
        }
        lappend ret $opt $val
    }
    return $ret
}

proc vTcl:get_subopts_special_save {opts w} {
    upvar ::widgets::${w}::subOptions::save subSave
    global vTcl
    set ret ""
    foreach i $opts {
        ## avoid option shortcuts (like -bg)
        if {[llength $i] != 5} {
            continue}
        lassign $i opt x x def val
        if {[vTcl:streq $opt "-class"]} {continue}
        if {![info exists subSave($opt)]} {continue}
        if {!$subSave($opt)} {
            continue
        }
        if {[info exists vTcl(option,translate,$opt)]} {
            set val [$vTcl(option,translate,$opt) $val]
        }
        lappend ret $opt $val
    }
    return $ret
}

## This proc does option translation:
## - converts image names to filenames before saving
## - converts font object names to font keys before saving
## - etc.

proc vTcl:get_opts_special {opts w {save_always ""}} {
    # Rozen. This certainly seems like the wrong way of doing
    # things because it is based on the save variable which is set by
    # seeing if the value of a config variable is different from the
    # default at creation time and does not take into consideration
    # that the value may be later changed via the Attribute Editor.
    #NEEDS WORK to ensure menu bg, fg, font, and tearoff  are saved.
    global vTcl
    vTcl:WidgetVar $w save  ;# Rozen Get the array for the paticular widget.
    set class [winfo class $w]
    set ret {}
    foreach i $opts {
        lassign $i opt x x def val
        #if {$opt == "-background" || $opt == "-foreground"} { }
        if {$opt in {-background -foreground -activeforeground}} {
            # For these opt I always want to save because the colors
            # for the GUI may differ from those of PAGE and I want to
            # be able to open the saved file and see the correct
            # colors.
            set save($opt) 1
        }
        if {$class == "Toplevel"} {
            if {$val != {} && $val != $def} {
                set save($opt) 1
            }
        }
        if {[vTcl:streq $opt "-class"]} {
            continue
        }
        if {![info exists save($opt)]} {
            set save($opt) 0
        }
        # if {$opt == "-text" && $val != $def} {      ;# Rozen 12/10/20
        #     lappend ret $opt $val
        #     continue
        # }
        if {$opt == "-font"} {      ;# Rozen 8/25/13
            lappend ret $opt $val
            continue
        }
        if {$opt eq "-variable" && $val eq "selectedButton"} {
            lappend ret $opt $val
            continue
        }
        if {$opt != "-tearoff"} {
            if {!$save($opt) && [lsearch -exact $save_always $opt] == -1} {
                continue
            }
        }
        switch -exact $opt {
            -label -
            -variable -
            -command {
                if {$val eq ""} {
                    continue
                }
            }
            -style {
                lappend ret $opt \"$val\"
            }
        }
        if {[info exists vTcl(option,translate,$opt)]} {
            set val [$vTcl(option,translate,$opt) $val]
        }
        lappend ret $opt $val
    }
    return $ret
}

proc vTcl:get_opts_to_save {opts} {
    # Rozen. This function is a variation of vTcl:get_opts_special
    # which is inadequate for saving the toplevel widget copy and past
    # of the menu bar occurs and may apply also to other widgets as
    # well. Time will tell. The main difference is that it looks at
    # all the configuration options and keeps the ones which differ
    # from the default and does not look at the save stuff as does the
    # earlier function

    global vTcl
    # vTcl:WidgetVar $w save  ;# Rozen Get the array for the paticular widget.
    # set class [winfo class $w]
    set ret {}
    foreach i $opts {
        lassign $i opt x x def val
        # if {$opt == "-background" || $opt == "-foreground"} {
        #     # For these opt I always want to save because the colors
        #     # for the GUI may differ from those of PAGE and I want to
        #     # be able to open the saved file and see the correct
        #     # colors.
        #     set save($opt) 1
        # }

        if {[vTcl:streq $opt "-class"]} { continue }
        if {$val == $def} { continue }
        if {![info exists save($opt)]} {
            set save($opt) 0
        }
#         if {$opt != "-tearoff"} {
#             if {!$save($opt) && [lsearch -exact $save_always $opt] == -1} {
#                 continue
#             }
#         }
        # if {$opt == "-font"} {      ;# Rozen 8/25/13
        #     lappend ret $opt $val
        #     continue
        # }
        if {$opt == "-style"} {      ;# Rozen 8/25/13
            lappend ret $opt \"$val\"
            continue
        }

        if {[info exists vTcl(option,translate,$opt)]} {
            set val [$vTcl(option,translate,$opt) $val]
        }
        lappend ret $opt $val
    }
    return $ret
}

proc vTcl:get_class_opts {target} {
    # Rozen. Created to dump the ClassOptions to be saved.
    set ret ""     ;# NEEDS WORK Don't remember why I deleted this line.
    if {[info exist ::widgets::${target}::ClassOption] } {
        foreach {co val} [array get ::widgets::${target}::ClassOption] {
            set save ::widgets::${target}::save($co)
            upvar $save s
            if {$s == 1} {
                # We want to save the value.
                lappend ret $co $val
            }
        }
        return $ret
    }
}

proc vTcl:dump_widget_quick {target} {
    global vTcl
    vTcl:update_widget_info $target
    set result "$target configure $vTcl(w,options)\n"
    append result "$vTcl(w,manager) $target $vTcl(w,info)\n"
    return $result
}

proc vTcl:dump_widget_opt {target basename} {
    # This is where we write out the code creating the widget (usually
    # the common ones) and provide the configuration stuff.  I am adding
    # the configuration stuff for Ttk widgets.0000000
    global vTcl classes
    set result ""
    set mgr [winfo manager $target]
    set class [vTcl:get_class $target]
    # For Ttk widgets, I want style configuration stuff before I
    # generate the widget.
    if {![info exists vTcl(ttk_widget_added)]} {
        # This may be a bit of over kill but doesn't hurt. Am just
        # putting out what is needed by most ttk widgets.
        append result "$vTcl(tab)ttk::style configure $class "
        append result "-background \$vTcl(actual_gui_bg)\n"
        append result "$vTcl(tab)ttk::style configure $class "
        append result "-foreground \$vTcl(actual_gui_fg)\n"
        append result "$vTcl(tab)ttk::style configure $class "
        append result "-font \"\$vTcl(actual_gui_font_dft_desc)\"\n"
        set vTcl(ttk_widget_added) 1
    }

    if {[info exists classes($class,TtkOptions)]} {
        # Rozen's new code for dumping TtkOptions.
#        set topts [split $classes($class,TtkOptions)]
#         foreach topt $topts {
#             switch $topt {
#                 -background {
#                     append result "$vTcl(tab)ttk::style configure $class "
#                     append result "-background $vTcl(pr,guibgcolor)\n"
#                 }
#                 -foreground {
#                     append result "$vTcl(tab)ttk::style configure $class "
#                     append result "-foreground $vTcl(pr,guifgcolor)\n"
#                 }
# NEES WORK - fix for fonts.
#                 -font {
#                     append result "$vTcl(tab)ttk::style configure $class "
#                     append result "-font $vTcl(font,gui_font_dft)\n"
#                 }
#             }
#         }

        # Switch below is where I save the special style specs for ttk
        # widgets. I could be fancier to make sure I never repeat a
        # spec but not now. 12/25/12.
        
        switch $class {
            Scrolledtreeview {
                # append result "$vTcl(tab)ttk::style configure Treeview.Heading "
                # append result "-background \$vTcl(pr,guicomplement_color)\n"
                # append result \
                #     "$vTcl(tab)ttk::style configure Treeview.Heading "
                # # FIXME: Why did I remove the next statement.
                # append result "-font \
                #         \"\$vTcl(actual_gui_font_treeview_desc)\"\n"

                #append result "$vTcl(tab)ttk::style configure Treeview.Heading "
                #append result "-background \$vTcl(pr,guicomplement_color)\n"
                append result \
                    "$vTcl(tab)ttk::style configure Treeview \\\n "
                # FIXME: Why did I remove the next statement.
                append result "$vTcl(tab)$vTcl(tab)-font \
                        \"\$vTcl(actual_gui_font_treeview_desc)\"\n"
            }
            TLabelframe {
                append result "$vTcl(tab)ttk::style configure $class.Label "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Label "
                append result "-foreground \$vTcl(actual_gui_fg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Label "
                append result "-font \"\$vTcl(actual_gui_font_dft_desc)\"\n"
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-background \$vTcl(actual_gui_bg)\n"
            }
            TNotebook {
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Tab "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Tab "
                append result "-foreground \$vTcl(actual_gui_fg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Tab "
                append result "-font \"\$vTcl(actual_gui_font_dft_desc)\"\n"
                append result "$vTcl(tab)ttk::style map $class.Tab "
                append result "-background "
                append result "\[list selected \$vTcl(actual_gui_bg) "
                append result "active \$vTcl(tabbg1) "
                append result "!active \$vTcl(tabbg2)\]\n"
                append result "$vTcl(tab)ttk::style map $class.Tab "
                append result "-foreground "
                append result "\[list selected \$vTcl(actual_gui_fg) "
                append result "active \$vTcl(tabfg1) "
                append result "\!active \$vTcl(tabfg2)\]\n"
            }
            PNotebook {
                append result "$vTcl(tab)ttk::style configure PC.TNotebook "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure PC.TNotebook.Tab "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure PC.TNotebook.Tab "
                append result "-foreground \$vTcl(actual_gui_fg)\n"
                append result "$vTcl(tab)ttk::style configure PC.TNotebook.Tab "
                append result "-font \"\$vTcl(actual_gui_font_dft_desc)\"\n"

                append result "$vTcl(tab)ttk::style map PC.TNotebook.Tab "

                append result "-background "
                append result "\[list selected \$vTcl(actual_gui_bg) "
                append result "active \$vTcl(tabbg1) "
                append result "!active \$vTcl(tabbg2)\]\n"
                append result "$vTcl(tab)ttk::style map PC.TNotebook.Tab "
                append result "-foreground "
                append result "\[list selected \$vTcl(actual_gui_fg) "
                append result "active \$vTcl(tabfg1) "
                append result "\!active \$vTcl(tabfg2)\]\n"

                append result "$vTcl(tab)ttk::style layout PC.TNotebook.Tab {
                    Notebook.tab -children {
                        Notebook.padding -side top -children {
                           t Notebook.focus -side top -children {
                                Notebook.text -side right
                                Notebook.image -side left
                            }
                        }

                    }
               }\n"
            }
            TPanedwindow {
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Label "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Label "
                append result "-foreground \$vTcl(actual_gui_fg)\n"
                append result "$vTcl(tab)ttk::style configure $class.Label "
                append result "-font \"\$vTcl(actual_gui_font_dft_desc)\"\n"
            }
            TFrame -
            TSizegrip {
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-background \$vTcl(actual_gui_bg)\n"
            }
            TMenubutton -
            TCheckbutton -
            TRadiobutton -
            TButton {
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-background \$vTcl(actual_gui_bg)\n"
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-foreground \$vTcl(actual_gui_fg)\n"
                append result "$vTcl(tab)ttk::style configure $class "
                append result "-font \"\$vTcl(actual_gui_font_dft_desc)\"\n"
            }
            Custom {
            }
        }
    }
    set opt [$target configure]
    # The following line seems to assume that the createCmd is a
    # simple tk command or that the more complex function is also
    # written out.
    if {$class == "Message"} {
        # Another of my damned special cases. It is here because on
        # original creation of message box, I need to do complex
        # stuff but on saving it is simple.
        append result "$vTcl(tab)message "
     
    } else {
        append result "$vTcl(tab)$classes($class,createCmd) "
    }
    set items [split $target "."]
    set len [llength $items]
    if {$vTcl(copy) && $vTcl(copy_class) eq "Menu" && $len == 3} {
        append result "\$\{target\}\$\{menu\}"
    # new      ;# NEEDS WORK menubutton
    } elseif {$vTcl(copy) && $vTcl(copy_class) eq "Menubutton" && $len == 4} {
        set sp [split $target .]
        set len [llength $sp]
        set len [expr {[llength $sp] - 1}]
        # append result "\$site_[llength $sp]_0.[lrange $sp end end]"
        append result "\$site_${len}_0.[lrange $sp end end]"
        #append result "\$\{target\}\$\{menu\}"
    } else {
        append result "$basename"
    }
    # end of new
    if {$mgr == "wm" && $class != "Menu" && \
            $mgr == "wm" && $class != "Popupmenu"} {
        append result " -class [winfo class $target]"
    }
    # Use special proc to convert image names to filenames before saving to disk
    # Rozen. If it is one of my complex widgets then I want to skip this.
    set p [vTcl:get_opts_special $opt $target]
    if {$p != ""} {#set exists [info exists vTcl(pr,font_dft)]
        append result " \\\n[vTcl:clean_pairs $p $target ]\n"
        # Now I want to look for command option in a scale.
        if {$class == "Scale"} {
            set cmd_spec [$target cget -command]
            if {$cmd_spec != ""} {
                lappend vTcl(gen_proc) $cmd_spec
            }
        }
    }
    switch $class {
        Listbox -
        Text {
            set text_font [$target cget -font]
            set text_font [vTcl:condense_font_description $text_font]
            set text_font \"$text_font\"
            ;# NEEDS WORK
            if {$vTcl(copy)} {
                append result "$vTcl(tab)$basename configure -font $text_font\n"
                append result "$vTcl(tab)$basename insert end text\n"
            } else {
                append result "$vTcl(tab)$basename configure -font $text_font\n"
                append result "$vTcl(tab)$basename insert end text\n"
            }
        }
    }
    # How about the ClassOptions?  Rozen.  I will try adding them.
    set class_opt [vTcl:get_class_opts $target]
    if {$p == "" && $class_opt == ""} {
        append result "\n"
    }
    foreach {co val} $class_opt {
        ;# NEEDS WORK popup

        if {$co eq "-variant" || $co eq "-proc"}  {
        #append result $vTcl(tab)
        # append result "global vTcl\n"
        # append result $vTcl(tab)
        # append result "set vTcl($target,$co) $val\n"
        # #append result $vTcl(tab)
        # #append result "namespace eval ::widgets::$target \{\}\n"
        # append result $vTcl(tab)
        # append result "set ::widgets::${target}::ClassOption($co) $val\n"
        # append result $vTcl(tab)
        # append result "set ::widgets::${target}::options($co) $val\n"
        # append result $vTcl(tab)
        # append result "set ::widgets::${target}::save($co) [expr {$val != ""}]\n"
        # target is the new  copied widget
        #regsub {\.top[1-9]+|\.bor[1-9]+} $target "\$top" new_target
        regsub {\.top[1-9]+|\.bor[1-9]+} $basename "\$top" new_target
        #regsub {\.top[1-9]+|\.bor[1-9]+} $target "\$top" target

        if {$vTcl(copy)} {
            append result $vTcl(tab) "global vTcl\n"
            append result  $vTcl(tab) "set p_target $basename\n"
            set val $vTcl($target,$co)
            append result $vTcl(tab) "set vTcl(\$p_target,$co) $val\n"
            append result $vTcl(tab) \
                "namespace eval ::widgets::\${p_target} \{\}\n"
            append result $vTcl(tab) \
                "set ::widgets::\${p_target}::ClassOption($co) $val\n"
            append result $vTcl(tab) \
                "set ::widgets::\${p_target}::options($co) $val\n"
            append result $vTcl(tab) \
                "set ::widgets::\${p_target}::save($co) [expr {$val != ""}]\n"
        } else {
            append result $vTcl(tab)
            append result "global vTcl\n"
            append result $vTcl(tab)
            append result "set val vTcl($new_target,$co)\n"
            append result $vTcl(tab)
            append result "set vTcl($new_target,$co) $val\n"
            append result $vTcl(tab)
            append result "namespace eval ::widgets::${new_target} \{\}\n"
            append result $vTcl(tab)
            append result "set ::widgets::${new_target}::ClassOption($co) $val\n"
            append result $vTcl(tab)
            append result "set ::widgets::${new_target}::options($co) $val\n"
            append result $vTcl(tab)
            append result \
                "set ::widgets::${new_target}::save($co) [expr {$val != ""}]\n"
        }
    }
    }
    if {$mgr == "menubar"} then {
        return ""
    }
    append result [vTcl:dump_widget_alias $target $basename]
    # It seems that putting the style option in at createCmd does not
    # work. So I put it in here. Rozen
    if {$class == "PNotebook"} {
        # if {$vTcl(copy)} {
        ## append result "$vTcl(tab)\$target configure -style \"PC.TNotebook\"\n"
        # append result "$vTcl(tab)$basename configure -style \"PC.TNotebook\"\n"
        # } else {
        #     set t_p [split $target "."]
        #     set l_p [lrange $t_p end end]
        #     append result \
        #         "$vTcl(tab)$basename configure -style \"PC.TNotebook\"\n"
        # }
        append result "$vTcl(tab)$basename configure -style \"PC.TNotebook\"\n"
    }
    append result [vTcl:dump_widget_bind $target $basename]
    return $result
}

proc vTcl:dump_validate_functions {} {
    global vTcl
    set ret ""
    if {[info exists vTcl(validate_functions)]} {
        foreach f [lsort -unique $vTcl(validate_functions)] {
            append ret "proc $f {args} {return 1}\n"
        }
    }
    return $ret
}

proc vTcl:dump_widget_alias {target basename} {
    global vTcl widget classes
    if {![info exists widget(rev,$target)]} {
        return ""
    }
    set alias $widget(rev,$target)
    set top_or_alias [vTcl:get_top_level_or_alias $target]

    if {[winfo toplevel $target] == $target} {
        set top_or_alias ""
    }

    set c [vTcl:get_class $target]
    append output $vTcl(tab)
    append output "vTcl:DefineAlias \"$basename\" \"$alias\""
    append output " $classes($c,widgetProc)"
    append output " \"[vTcl:base_name $top_or_alias]\" $vTcl(pr,cmdalias)\n"
    return $output
}

proc vTcl:dump_widget_geom {target basename} {
    global vTcl classes
    if {$target == "."} {
        set mgr wm
    } else {
        set mgr [winfo manager $target]
    }
    if {$mgr == ""} {return}
    set class [winfo class $target]

    ## Let's be safe and force wm for toplevel windows.  Just incase...
    if {$class == "Toplevel"} { set mgr wm }

    ## That shouldn't be necessary any more. Doesn't hurt anyway.
    if {$class == "Menu" && $mgr == "place"} {return ""}

    set result ""
    if {[lsearch -exact {wm menubar tixGeometry tixForm busy} $mgr] == -1} {
        set result ""
        if {(($mgr == "pack") && (![pack propagate $target])) ||
            (($mgr == "grid") && (![grid propagate $target]))} {
            # Do them both!  Important when mixing geometery managers
            append result "$vTcl(tab)pack propagate $basename 0\n"
            append result "$vTcl(tab)grid propagate $basename 0\n"
        }
        set opts [$mgr info $target]
        # What follows is the actual place command, i.e., "  place blah \"
        append result "$vTcl(tab)$mgr $basename \\\n"
        set basesplit  [split $basename .]
        set length     [llength $basesplit]
        set parentname [join [lrange $basesplit 0 [expr $length - 2]] .]
        # Creates the place statement.
        append result "[vTcl:clean_pairs [vTcl:get_mgropts $opts $parentname]]\n"
#         # Here is where I put the sash stuff. 2/27/12
#         set widget_name [lrange $basesplit end end]
#         if {[info exists vTcl(set_sash,$basename)]} {

#             append result "$vTcl(tab)update idletasks\n"
#             foreach item $vTcl(set_sash,$basename) {
#                 append result "$item\n"
#             }
#             unset vTcl(set_sash,$basename)
#         }
    }
    ## Megawidgets are like blackboxes. We don't want to know what's inside,
    ## and besides, they are supposed to configure themselves on construction.
    if {[info exists classes($class,megaWidget)] &&
        $classes($class,megaWidget)} {
        return $result
    }
    append result [vTcl:dump_grid_geom $target $basename]
}

proc vTcl:dump_grid_geom {target basename} {
    set result ""
    set pre g
    set gcolumn [lindex [grid size $target] 0]
    set grow [lindex [grid size $target] 1]
    foreach a {column row} {
        foreach b {weight minsize} {
            set num [subst $$pre$a]
            for {set i 0} {$i < $num} {incr i} {
                if {[catch {
                    set x [expr {round([grid ${a}conf $target $i -$b])}]
                }]} {set x 0}
                if {$x} {
                  append result "$::vTcl(tab)grid ${a}conf $basename $i -$b $x\n"
                }
            }
        }
    }
    return $result
}

proc vTcl:dump:class_bindings {} {
    #return "# class bindings"
} ;# end vTcl:dump:class_bindings


proc vTcl:dump:dump_user_bind {} {
    # This seems to dump stuff needed when one attempts to execute the
    # the save tcl file. Since I never envision the execution of the
    # project file, I think that I will try bypassing this routine.
    return ""
    global vTcl
    # are there any user defined tags at all?
    set tags $::widgets_bindings::tagslist
    if {$tags == ""} {
        return ""
    }
    set result ""
    foreach tag $tags {
        append result {#############################################################################}
        append result "\n\#\# Binding tag:  $tag\n\n"
        if {$tag == "_vTclBalloon"} {
            vTcl:dump:not_sourcing_header result
        }
        set bindlist [lsort [bind $tag]]
        foreach event $bindlist {
            set command [bind $tag $event]
            append result "bind \"$tag\" $event \{\n"
            append result "$vTcl(tab)[string trim $command]\n\}\n"
        }
        if {$tag == "_vTclBalloon"} {
            vTcl:dump:sourcing_footer result
        }
    }

    append result "\n"
    return $result
}

proc vTcl:dump_widget_bind {target basename {include_bindtags 0}} {
    # Rozen. Changed the default from {include_bindtags 1}
    # Think about removing!!!
    global vTcl
    set result ""
    # well, let's see if we have to save the bindtags
    if {$include_bindtags} {
        set tags $vTcl(bindtags,$target)
        lremove tags vTcl(a) vTcl(b)
        if {$tags !=
            [::widgets_bindings::get_standard_bindtags $target]} {
            set reltags ""
            foreach tag $tags {
                if {"$tag" == "$target"} {
                    set tag $basename
                } elseif {"$tag" == "[winfo toplevel $target]"} {
                    set tag \$top
                }
                if {[string match "* *" $tag]} {
                    set tag "\{$tag\}"
                }
                if {$reltags == ""} {
                    set reltags $tag
                } else {
                    append reltags " $tag"
                }
            }
            #append result "$vTcl(tab)bindtags $basename \"$reltags\"\n"
            append result \
                "$vTcl(tab)bindtags $basename \"$reltags\"\n" ;# Rozen 10/28/14
        }
    }

    set bindlist [lsort [bind $target]]
    foreach i $bindlist {
        set command [bind $target $i]
        ## replace occurences of widget path by %W to avoid absolute widget paths
        regsub -all $target $command %W command
        ## dump it
        # The vTcl(bind,ignore) string seems to be a hold over from the
        # Tix support and should probably be removed. The variable is
        # only set in globals.tcl to "" and in lib_tix which is not used.
        if {"$vTcl(bind,ignore)" == "" ||
            ![regexp "^($vTcl(bind,ignore))" [string trim $command]]} {
            append result "$vTcl(tab)bind $basename $i \{\n"
            append result "$vTcl(tab2)[string trim $command]\n    \}\n"
        }
    }
    return $result
}

proc vTcl:dump_top {target} {
    # Rozen the proc below is in Widgets/core/toplevel.wgt It dumps
    # header stuff then back to vTcl:dump:widgets to put out the tree.
    set dump_string [vTcl::widgets::core::toplevel::dumpTop $target]
    return $dump_string
}

proc vTcl:dump_popup_menu {} {
    global vTcl
    set output ""
    set children [winfo children .]
    while {[set index [lsearch $children ".pop*"]] > -1} {
        lappend popups [lindex $children $index]
        set children [lreplace $children $index $index]
    }
    if {![info exists popups]} return
    #    append output "if {!\$vTcl(borrow)} {\n"
    foreach pop $popups {
        append output [vTcl::widgets::core::popup::dumpCmd $pop $pop]
    }
    #    append output "}\n"
    return $output
}

proc vTcl:dump:widgets {target} {
    # Run thru the widget tree dumping as we go.
    global vTcl classes
    set output ""
    # for dumping widgets recursively using relative paths
    set dontDumpChildren {Frame MegaWidget Menu Menubutton Labelframe
        TLabelframe TFrame Scrolledtreeview Custom Canvas} ;# Rozen added these.
    foreach i $dontDumpChildren {
        set classes($i,dumpChildren) 0
    }

    append output $vTcl(head,proc,widgets) ;# puts out "CREATING WIDGETS" banner
    set tree [vTcl:widget_tree $target]
    foreach i $tree {
        if {[string first ".pop" $i] == -1} {
            # Most common case - not a popup menu
            set basename [vTcl:base_name $i]
            set class [vTcl:get_class $i]
        } else {
            set basename ".pop"
            set class "Popupmenu"
        }
        # The classes are created in vTcl:LoadWidget in loadwidg.tcl
        # when it calls SetClassArray which may be overridden.
        append output [$classes($class,dumpCmd) $i $basename] ;# Work horse
        # We need to emit an extra line of code like "set ::vTcl::bbb cancel"

        # if the following three conditions are satisfied: 1. current
        # widget has the -textvariable attribute, and 2. current
        # widget has the -text attribute, and 3. the value of the
        # -textvariable attribute is not "". I generated by hand in
        # global.tcl, vTcl(text_widgets) which is a list of all
        # classes having both attributes. So when I get here I
        # determine the class of the widget and see if it is present in
        # vTcl(text_widgets). Generates line like: set textvariable string.
        #set class [vTcl:get_class $i]
        if {[lsearch -exact $vTcl(text_widgets) $class] > -1} {
            set var [$i cget -textvariable]
            set txt [$i cget -text]
            if {$var ne ""} {
                # set val [set $var]
                set val $txt
                append output "$vTcl(tab)set $var \{$val\}\n"
            }
        }
        if {$class eq "Toplevel"} {
            # The comment below necessary due to a peculiarity of the
            # tcl interpreter. Otherwise, an error is flagged that
            # there are extra characters after the close quote.
            append output "$vTcl(tab)set vTcl(real_top) {}\n"
            ;# NEEDS WORK copy
            #append output "$vTcl(tab)vTcl:withBusyCursor {\n" ;# }
        }

        if {[info exists ::widgets::${i}::locked] &&
            [set ::widgets::${i}::locked]} {
            append output "$vTcl(tab)vTcl:copy_lock $basename\n"
        }
    }
    append output $vTcl(head,proc,geometry) ;# puts out "SETTING GEOMETRY"
    foreach i $tree {
        set basename [vTcl:base_name $i]
        append output [vTcl:dump_widget_geom $i $basename]
    }
    # end of dumping widgets with relative paths
    foreach i $dontDumpChildren {
        set classes($i,dumpChildren)
    }

    # Rozen at this point I will put out the set sash stuff. This was
    # the only way that I was able to figure out for having the saved
    # file handle sahshes which have been moved by the paned window
    # editor. The variable vTcl(set_sash) was set up in
    # tpanedwindow.wgt in the dumpCmd

#     if {[info exists vTcl(set_sash,"target")]} {
#         set length_set_sash [llength $vTcl(set_sash,"target")]
#         # if {$length_set_sash} {
#         #     append output "$vTcl(tab)update idletasks\n"
#         # }
# append output "$vTcl(tab)update idletasks\n"
#         foreach sash $vTcl(set_sash) {
#             append output $sash
#         }
    #     }

    # The opening brace at the end of this comment is required to
    # balance the closing brace character in the following append
    # statement.  {
    ;# NEEDS WORK copy
    #append output "$vTcl(tab)} ;# end vTcl:withBusyCursor \n"
    return $output
}

## These are commands we want executed when we re-source the
## project. Actually occurs at the bottom rather than near top.
proc vTcl:dump:save_tops {i} {
    global vTcl
    # foreach top [concat . $vTcl(tops)] {
    #     append string "Window show $top\n"
    # }
set string \
"Window show .
"
    set j 1
    foreach top $vTcl(tops) {
        append string \
"set btop$j \"\"
if {\$vTcl(borrow)} {
$vTcl(tab)set btop$j .bor\[expr int(\[expr rand() * 100\])\]
$vTcl(tab)while {\[lsearch \$btop$j \$vTcl(tops)\] != -1} {
$vTcl(tab)$vTcl(tab)set btop$j .bor\[expr int(\[expr rand() * 100\])\]
$vTcl(tab)}
}
set vTcl(btop) \$btop$j
"
    # foreach top $vTcl(tops) {
    #      if {[string first ".bor" $top] != 0} {
    #         append string "Window show $top\n"
    #      }
    # }
    append string \
"Window show $top \$btop$j
if {\$vTcl(borrow)} {
$vTcl(tab)\$btop$j configure -background plum
}
"
    incr j
    }
    return $string
}

proc vTcl:dump:gather_widget_info {} {
    # Called from save2 in file.tcl.
    global vTcl classes
    if {[info exists vTcl(images,stock)]} { lappend vars stockImages }
    if {[info exists vTcl(images,user)]}  { lappend vars userImages  }
    if {[info exists vTcl(fonts,stock)]}  { lappend vars stockFonts  }
    if {[info exists vTcl(fonts,user)]}   { lappend vars userFonts   }

    if {[lempty $vars]} { return }
    set used_image {}
    set used_font {}
    set vTcl(dump,libraries) {}
    foreach var $vars { set vTcl(dump,$var) {} }
    set children [vTcl:complete_widget_tree . 0]
    foreach child $children {
        if {[regexp {^\.bor} $child]} { continue }
        set c [vTcl:get_class $child]
        lappend vTcl(dump,libraries) $classes($c,lib)
        foreach resource {image font selectimage} {
            set value {}

            catch {set value [$child cget -$resource]}
            if {$value ne {}} {
                switch $resource {
                    image -
                    selectimage {
                        lappend used_image $value
                    }
                    default {
                        lappend used_${resource} $value
                    }
                }
            }
            set cmd get[string totitle $resource]
            if {[info exists classes($c,$cmd)]} {
                set used_${resource} \
                  [concat [vTcl:at used_${resource}] [$classes($c,$cmd) $child]]
            }
        } ; # foreach resource ...
    } ; # foreach child ...

    # set vTcl(dump,userImages) [list {*}$used_image]
    lappend vTcl(dump,userImages) [list {*}$used_image]
    # foreach var $vars {
    #     set vTcl(dump,$var) [vTcl:lrmdups $vTcl(dump,$var)]
    # }
    # if {[lsearch $vTcl(dump,userImages) {}] > -1} {
    #     set vTcl(dump,userImages) [lrange $vTcl(dump,userImages) 1 end]
    # }
    set vTcl(dump,libraries) [vTcl:lrmdups $vTcl(dump,libraries)]
}

proc vTcl:get_images_and_fonts {menu} {
    # As part of copying this function finds options -image and -font
    global vTcl
    ## any entries in the menu?
    set entries [$menu index end]
    if {$entries == "none"} {return $result}
    ## then all its submenus
    for {set index 0} {$index <= $entries} {incr index} {
        #pathName entrycget index option
        # foreach resource {image font} {    # of a menu. }
        foreach resource {image } {    # of a menu.
            set value {}
            # catch {set value [$child cget -$resource]}
            catch {set value [$menu entrycget $index -$resource]}
            if {$value ne {}} {
                switch $resource {
                    image {
                        lappend vTcl(dump,userImages) $value
                    }
                    font {
                        lappend vTcl(dump,userFonts) $value
                    }
                }
            }
        }
    }
}

proc vTcl:dump:gather_menu_info {} {
    # Called from save2.
    global vTcl classes
    if {[info exists vTcl(images,stock)]} { lappend vars stockImages }
    if {[info exists vTcl(images,user)]}  { lappend vars userImages  }
    if {[info exists vTcl(fonts,stock)]}  { lappend vars stockFonts  }
    if {[info exists vTcl(fonts,user)]}   { lappend vars userFonts   }

    if {[lempty $vars]} { return }
    set vTcl(dump,libraries) {}
    set children [vTcl:complete_widget_tree . 0]
    foreach child $children {
        if {[regexp {^\.bor} $child]} { continue }
        set c [vTcl:get_class $child]
        # Now to borrow from menu.wgt dumpCmd.
        if {$c ni "Menu Popupmenu"} { continue }
        set entries [$child index end]
        if {$entries == "none"} { continue }
        for {set index 0} {$index <= $entries} {incr index} {
            set conf [$child entryconf $index]
            set type [$child type $index]
            set image ""
            catch {set image [$child entrycget $index -image]}
            if {$image != ""} {
                lappend vTcl(dump,userImages) $image
            }
        }
    }
}

proc vTcl:dump:widget_info {target basename} {
    global vTcl
    set testing [namespace children ::widgets ::widgets::${target}]
    #append testing [namespace children ::widgets] \
        [namespace children ::widgets::${target}] ;# NEEDS WORK popup
    if {$testing == ""} {
        return }
    vTcl:WidgetVar $target save
    set list {}
    foreach var [lsort [array names save]] {
       if {!$save($var)} { continue }
       lappend list $var $save($var)
    }
    append out $vTcl(tab)
    append out "namespace eval ::widgets::$basename \{\n"
    append out $vTcl(tab2)
    append out "array set save [list $list]\n"

    ## suboptions for megawidgets
    if {[info exists ::widgets::${target}::subOptions::save]} {
        upvar ::widgets::${target}::subOptions::save subSave
        set list {}
        foreach var [lsort [array names subSave]] {
            if {!$subSave($var)} { continue }
            lappend list $var $subSave($var)
        }
        if {![lempty $list]} {
            append out $vTcl(tab2)
            append out "namespace eval subOptions \{\n"
            append out $vTcl(tab)$vTcl(tab2)
            append out "array set save [list $list]\n"
            append out $vTcl(tab2)\}\n
        }
    }

    append out "$vTcl(tab)\}\n"
    return $out
}

proc vTcl:dump:project_info {basedir project} {
    global vTcl classes
# May Want to return. NEEDS WORK
return
    set out   {}
    set multi [vTcl::project::isMultipleFileProject]

    ## It's a single project without a project file.
    if {!$multi && !$vTcl(pr,projfile)} {
        vTcl:dump:sourcing_header out
    append out "\n"
    }
    # FIXME:
    append out "proc vTcl:project:info \{\} \{\n"

    foreach i $vTcl(tops) {
        if {[string first ".bor" $i] > -1} {
            continue
        } ;# end if
        append out "$vTcl(tab)set base $i\n"
        # Moved this statement here 2/19/18
        # Put $i below 3/19/18
        append out \
"$vTcl(tab)global vTcl
$vTcl(tab)set base \$vTcl(btop)
$vTcl(tab)if \{\$base == \"\"\} \{
$vTcl(tab)$vTcl(tab)set base $i
$vTcl(tab)\}
"
        append out [$classes(Toplevel,dumpInfoCmd) $i {$base}]
    }
#    append out "proc vTcl:project:info \{\{base \"\"\}\} \{\n"

#    set i $vTcl(tops)                            Sunday
#    append out [$classes(Toplevel,dumpInfoCmd) $i {$base}]  Sunday
    # FIXME: End of changes
    append out $vTcl(tab)
    append out "namespace eval ::widgets_bindings \{\n"
    append out $vTcl(tab2)
    append out "set tagslist [list $::widgets_bindings::tagslist]\n"
    append out "$vTcl(tab)\}\n"

    append out "$vTcl(tab)namespace eval ::vTcl::modules::main \{\n"
    append out "$vTcl(tab2)set procs \{\n"
    foreach item $vTcl(procs) {
        append out "$vTcl(tab)$vTcl(tab2)[list $item]\n"
    }
    append out "$vTcl(tab2)\}\n"
    append out "$vTcl(tab2)set compounds \{\n"
    foreach item [vTcl::project::getCompounds main] {
        append out "$vTcl(tab)$vTcl(tab2)[list $item]\n"
    }
    append out "$vTcl(tab2)\}\n"
    array set prjType "0 single 1 multiple"
    append out "$vTcl(tab2)set projectType $prjType($multi)\n"

    append out "$vTcl(tab)\}\n"
    append out "\}\n"
    # FIXME:
    # append out "if {\$vTcl(borrow)} {\n"
    # append out "proc vTcl:project:info \{\} \{}\n"
    # append out "\} ;# end if\n"

    if {!$multi} {
        if {!$vTcl(pr,projfile)} {
        vTcl:dump:sourcing_footer out
        return $out
        }
        set file [file root $project].vtp
    } else {
        set file [file root $project].vtp
        set dir [vTcl:dump:get_multifile_project_dir $project]
        file mkdir [file join $basedir $dir]
        set file [file join $basedir $dir $file]
    }

    # @@ Nelson 20030408 Change to work on backup operations.
    # Make the call to get the data out and with backups.
    if {![vTcl:dump_data_tofile $file $out]} {
       return "::vTcl::MessageBox -icon error -message \"Error on $file with multi file save! Project may be corrupted! If so try the Restore operation!\" -title \"Notification!\" -type ok\n\n"
    }


}

proc vTcl:dump:sourcing_header {varName} {
    upvar 1 $varName var
    append var "\nif {\[info exists vTcl(sourcing)\]} \{\n"
}

proc vTcl:dump:not_sourcing_header {varName} {
    upvar 1 $varName var
    append var "\nif {!\[info exists vTcl(sourcing)\]} \{\n"
}

proc vTcl:dump:sourcing_footer {varName} {
    upvar 1 $varName var
    if {![vTcl:streq [string index $var end] "\n"]} { append var "\n" }
    append var "\}\n"
}
