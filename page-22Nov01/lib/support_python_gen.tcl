# -*- tcl -*-
# Time-stamp: 2012-12-17 23:00:07 rozen>

# gui_python_support.py - procedures for generating Python support
# module skeletons for associated GUI definition.

# This program was written by Don Rozenberg

# The original copyright notice is attached and this program is released
# under the terms of that copyright.
#
# Copyright (C) 1996-1997 Constantin Teodorescu
# Copyright (C) 2013-2021 Donald Rozenberg
#
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

# This module analyzes the widget tree of the project, determines the
# information needed in then support module and generates the support
# module. It works two modules. One mode generates the support module
# from scratch, called "generate" mode, and the other mode, called
# "update" mode, updates an existing support module only adding new
# code where necessary. In the update mode it never removes any code
# from the support module.

# In both modes the first step is to scan the widget tree looking for
# 1) tk variables names, 2) callback function names, and 3) the names
# of custom widget instances.  If there are tk variables, the proper
# variable entries are places in the procedure set_tk_var(). It may be
# necessary to create that procedure.

# If there are callback functions required skeleton procs are created for each.

# If custom widgets are present, rename statements are added for each
# variation.

# This is a stripped down version of python_ui.tcl.  Basically, what
# it does is to run thru the widgets looking for function and Tk
# variable names which are of the form "<module name>.<function name>
# or "<module name>.<variable name>. It keeps a list of the module
# names and raises an error message if there is not exactly one. It
# overlooks names of the form "self.<function name>" and handles
# callback functions containing "lambda:"

# The update operation has the extra step of analyzing the existing
# support module to determine 1) which tk variables are declared, 2)
# which function are present, and which custom widgets are
# renamed. Those lists are compared with the lists of needed entries
# to determine which are to added.


# Copyright (C) 2013-2021 Donald P. Rozenberg

# vTcl:generate_support
# vTcl:python_menu_support
# vTcl:python_inspect_config
# vTcl:python_inspect_bind
# vTcl:python_inspect_menu_config
# vTcl:python_inspect_widget
# vTcl:test_file_content
# vTcl:save_python_file
# vTcl:update_dialog
# vTcl:update_support_module
# vTcl:analyze_existing_support_module    Where we scan existing support module.
# vTcl:scan_widgets
# vTcl:python_inspect_popup
# vTcl:check_custom_list
# vTcl:determine_updates
# vTcl:add_new_tk_vars
# vTcl:replace_support_module

# vTcl:check_toplevel_list
# vTcl:update_support_module
# vTcl:gen_updated_source
# vTcl:generate_support

proc vTcl:generate_python_support {} {
    # Starting routine. it is called from the Gen_Python submenu.
    # Entry point
    global vTcl widget env tcl_platform
    set vTcl(imported_variable) 0
    set vTcl(custom_present) 0
    set vTcl(tk_prefix) "tk."
    set vTcl(support_variable_list)  [list]
    set vTcl(support_function_list)  [list]
    set vTcl(support_custom_list)    [list]
    set vTcl(required_toplevel_classes)  [list]
    set vTcl(variable_parms)         [list]
    set VTcl(validate_function_list) [list]
    set vTcl(source) ""                    ;# new
    set vTcl(toplevel_menu_header) ""
    set support_present 0
    set vTcl(popups_in_tree) 0
    set vTcl(popup_found) 0
    vTcl:get_gui_name
    # See if there is anything to generate.
    if {[llength $vTcl(tops)] == 0} {
        # There is nothing to generate.
        #tk_messageBox -title Error -message "There is no GUI to process."
        tk_dialog .foo "ERROR" "There is no GUI to process." error 0 "OK"
        return
    }
    set window [lindex $vTcl(tops) 0]
    if {$vTcl(change)} {
        vTcl:save
        set vTcl(change) 0
    }
    if {![file exists $vTcl(project,file)]} {
        vTcl:save
    }
    set class [$window cget -class]
    if {$class == "Toplevel"} {
        set menu [$window cget -menu]
        set vTcl(toplevel_menu) $menu
    }

    if {![info exists vTcl($window,x)]} {
        vTcl:active_widget $window
    }
    set vTcl(py_title) [wm title $window]
    set vTcl(py_classname) [string map { " " _ } $vTcl(py_title) ]


    vTcl:Window.py_console "supp"
    update
    #vTcl:withBusyCursor { }
    set con .vTcl.supp_console
    if {[winfo exists $con]} {
        $vTcl(supp_source_window) delete 1.0 end
        $vTcl(supp_output_window) delete 1.0 end
    }
    # if {$vTcl(project,file) == ""} {
    #     vTcl:save
    # }
    vTcl:get_project_name  ;# because I am moving the tcl save to gui save.
    vTcl:get_import_name
    #set top .vTcl.supp_console
    #$top.butframe.but33 configure -command "vTcl:save_support_file"
    set filename "[file rootname $vTcl(project,file)]_support.py"
    #wm title $top "Python Console - $vTcl(import_name).py"
    wm title $con "Support Console - $filename"
    wm withdraw ".vTcl.supp_console"   ;# Hide consol
    update
    if {[file exists $filename]} {
        set support_present 1
        vTcl:determine_updates
        if {$vTcl(update_necessary)} {
            # There are possible updates.
            set reply [tk_dialog .foo "Update Question" \
            "Do you wish to replace, update, or use the existing support file?" \
                       question 3 "Cancel" "Replace" "Use Existing" "Update"]
        } else {
            # Support module exists but no updates necessary so just
            # use the existing support module.
            #set reply 2
            set reply [tk_dialog .foo "Update Question"  \
                 "Do you wish to replace or use the existing support file?" \
                       question 2 "Cancel" "Replace" "Use Existing"]
        }
        switch $reply {
            0 {
                # Cancel
                if {[winfo exists .vTcl.supp_console]} {
                    wm withdraw ".vTcl.supp_console"
                }
               return
            }
            1 {
                # Replace
                # vTcl:replace_support_module
                vTcl:look_for_popups
                foreach top $vTcl(tops) {
                    vTcl:scan_widgets $top
                }
                vTcl:generate_support   ;# Call which creates the code for
                                         # the support module
            }
            2 {
                # Use Existing File
                vTcl:use_existing_support_module
                #set vTcl(save_support) 0
                $vTcl(supp_code_window) edit modified 0
            }
            3 {
                # Update
                vTcl:update_support_module
            }
        }
    } else {
        vTcl:look_for_popups
        foreach top $vTcl(tops) {
            vTcl:scan_widgets $top
        }
        vTcl:generate_support           ;# Call which creates the code for
                                         # the support module
    }
    #wm title $top "Support Console - $filename"
    #Save the file
    set vTcl(python_module) "Support"
    #$vTcl(gui_code_window) edit modified 0
    set vTcl(change) 0
    wm deiconify .vTcl.supp_console
    raise .vTcl.supp_console
}


proc vTcl:replace_support_module {} {
    # Window is the top of the widget tree.
    global vTcl
    vTcl:Window.py_console "supp"   ;# Create console. 3/26/21
    vTcl:generate_support           ;# Call which creates the code for
                                     # the support module
    #Save the file
    set vTcl(python_module) "Support"
    $vTcl(supp_code_window) edit modified 1
}

proc vTcl:read_support_module {} {
    # Reads the support module and return as a string.
    global vTcl
    global support_module
    set module ""
    #  Slurp up the data file
    set fn $vTcl(import_filename)
    set fp [open $fn r]
    set module [read $fp]
    regsub -all {\t} $module $vTcl(tab) module ;# Expand all tabs.
    close $fp
    return $module
}

proc vTcl:use_existing_support_module {} {
    # Merely reads the existing file and puts it into the Python
    # Console with colorization.
    global vTcl
    vTcl:Window.py_console "supp"
    # Read existing support module.
    set source [vTcl:read_support_module]
    # Now write the code into the console window.
    set numbered [vTcl:add_line_numbers $source]
    $vTcl(supp_source_window)  delete 1.0 end
    $vTcl(supp_source_window)  insert end $numbered
    set vTcl(py_source) $source
    vTcl:colorize_python "supp"
    #vTcl:syntax_color [$vTcl(source) subwidget text]
    return
}

proc vTcl:look_for_popups {} {
    # Build a list of popup functions that are found.
    global vTcl widget
    if {[info exists vTcl(popup_functions_found)]} {
        unset vTcl(popup_functions_found)
    }
    set children [winfo children .]
    foreach child $children {
        if {[regexp {^\.pop[0-9]+$} $child]} {
            set alias $widget(rev,$child)
            set function [string tolower $alias]
            lappend vTcl(popup_functions_found) $function
        }
    }
}

proc vTcl:determine_updates {} {
    global vTcl
    set vTcl(imported_variable) 0            ;# Move
    set vTcl(support_variable_list)  []
    set vTcl(support_function_list)  []
    set vTcl(required_toplevel_classes) [list]
    set vTcl(support_custom_list) [list]
    set VTcl(validate_function_list) [list]
    vTcl:look_for_popups
    vTcl:analyze_existing_support_module
    # Since any popups are children of the root, the inspection can be
    # done before the loop over the toplevels.
    vTcl:python_inspect_popup
    foreach top $vTcl(tops) {
        if {[string range $top 0 3] eq ".bor"} continue
        vTcl:scan_widgets $top
    }
    vTcl:check_function_list
    vTcl:check_validation_list
    vTcl:check_custom_list
    vTcl:check_rename_list
    vTcl:check_toplevel_list
    #vTcl:check_popup_call
# dpr vTcl(must_add_custom)
# dpr vTcl(must_add_procs)
# dpr vTcl(must_add_validation)
# dpr vTcl(must_add_toplevels)
# dpr vTcl(must_delete_toplevels)
# dpr vTcl(change_class_name)
# dpr vTcl(must_add_popup)
    set vTcl(update_necessary) 0
    if {[info exists vTcl(must_add_custom)] || \
            [info exists vTcl(must_add_procs)] || \
            [info exists vTcl(must_add_validation)] || \
            [info exists vTcl(must_add_toplevels)] || \
            [info exists vTcl(must_delete_toplevels)] || \
            [info exists vTcl(change_class_name)]} {
        set vTcl(update_necessary) 1
        # We decided that the average user would not be helped by
        # displaying update messages. However they are definitely
        # helpful in debugging the update function.
        # set msg [vTcl:create_display_message]
        # vTcl:display_support_module_updates $msg
        if {[info exists vTcl(must_delete_toplevels)]} {
            vTcl:display_toplevel_message
        }
    }
}

proc vTcl:create_display_message {} {
    # This mainly a debugging aid.
    global vTcl
    set string "Requirements met with support module updates.\n"
    set string ""
    if {([info exists vTcl(must_add_vars)])} {
        set sorted [lsort -unique $vTcl(must_add_vars)]
        append string \
"The following Tk variables will be added:
$vTcl(tab)$sorted\n"
# $vTcl(tab)$vTcl(must_add_vars)\n"
    }
    if {([info exists vTcl(must_add_custom)])} {
        append string \
"The following custom widgets will be added:
$vTcl(tab)$vTcl(must_add_custom)\n"
    }
    if {([info exists vTcl(must_add_procs)])} {
        append string \
"The following functions will be added:
$vTcl(tab)$vTcl(must_add_procs)\n"
    }
    if {([info exists vTcl(must_add_validation)])} {
        append string \
"The following validation functions will be added:
$vTcl(tab)$vTcl(must_add_validation)\n"
    }
    if {([info exists vTcl(must_add_toplevels)])} {
        append string \
"The following toplevels will be created:
$vTcl(tab)$vTcl(must_add_toplevel_names)\n"
    }
    if {([info exists vTcl(must_delete_toplevels)])} {
        append string \
"The following toplevels to have been removed but update will not
     remove the creation code, check manually:
$vTcl(tab)$vTcl(must_delete_toplevels)\n"
    }
    if {([info exists vTcl(change_class_name)])} {
        # foreach w $vTcl(change_class_name) {
        #     # append name_string $vTcl(existing_name,$w)
        # }
            append name_string $vTcl(change_class_name)
        append string \
"The following class names will be changed:
$vTcl(tab)$name_string\n"
   }
    if {([info exists vTcl(modify_popup_create)])} {
        if {$vTcl(modify_popup_create) == "1" || \
                $vTcl(modify_popup_create) == "2"} {
            append string \
"The _create_popup_variables() line will be
     added or commented out as needed."
        }
    }
    return $string
}

proc vTcl:display_support_module_updates {msg} {
    # This mainly a debugging aid.
    set WIDTH 80
    set txt [split $msg "\n"]
    set height [llength $txt]
    toplevel .updates_top
    wm title .updates_top "Updates required"
    frame .updates_top.f
    button .updates_top.f.b1 -text "Close" -command {set exitvar 1} \
        -default active
    pack .updates_top.f -fill x
    pack .updates_top.f.b1 -side right -expand 1
    text .updates_top.t -width $WIDTH -height $height
    pack .updates_top.t
    .updates_top.t insert 1.0 $msg
    # Close window when Return is pressed.
    bind .updates_top <Return> {.updates_top.f.b1 invoke}
    bind .updates_top <Key-space> {.updates_top.f.b1 invoke}
    tkwait variable exitvar
    destroy .updates_top
}

proc vTcl:display_toplevel_message {} {
    # Tell user that he has to manually update support module to
    # reflect deletes toplevel widgets.
    global vTcl
    set WIDTH 80
    foreach l $vTcl(must_delete_toplevels) {
        set n [lindex $l 1]
        append names " " $n
    }
    set msg \
"You have deleted the toplevel window(s): $names.
The support module will have to be manually updated."
    set txt [split $msg "\n"]
    set height [llength $txt]
    toplevel .updates_top
    wm title .updates_top "Manual updates required!"
    frame .updates_top.f
    button .updates_top.f.b1 -text "Close" -command {set exitvar 1} \
        -default active -foreground $vTcl(pr,fgcolor)     ;# NEEDS WORK dark
    pack .updates_top.f -fill x
    pack .updates_top.f.b1 -side right -expand 1
    text .updates_top.t -width $WIDTH -height $height \
        -foreground $vTcl(pr,fgcolor)                ;# NEEDS WORK dark
    pack .updates_top.t
    .updates_top.t insert 1.0 $msg
    # Close window when Return is pressed.
    bind .updates_top <Return> {.updates_top.f.b1 invoke}
    bind .updates_top <Key-space> {.updates_top.f.b1 invoke}
    tkwait variable exitvar
    destroy .updates_top
}


proc vTcl:update_support_module {} {
    global vTcl
    vTcl:set_timestamp
    vTcl:Window.py_console "supp"
    set new_code [vTcl:gen_updated_source]
    set numbered [vTcl:add_line_numbers $new_code] ;# Aids console readability.
    $vTcl(supp_source_window)  delete 1.0 end
    $vTcl(supp_source_window)  insert end $numbered
    set vTcl(py_source) $new_code
    vTcl:colorize_python "supp"
}

proc vTcl:check_variable_list {} {
    global vTcl
    if {[info exists vTcl(must_add_vars)]} {
        unset vTcl(must_add_vars)
    }
    # vTcl(tk_vars) is the list of variables already found in an
    # existing set_Tk_var() function.  vTcl(support_variable_list) is
    # built by vTcl:python_inspect_config which is called for each
    # widget in the tree.
    if {[llength $vTcl(support_variable_list)] == 0} return
    if {[info exists vTcl(support_variable_list)]} {
        #        set vTcl(support_variable_list) \
            [lsort -unique $vTcl(support_variable_list)]
        }
    if {[info exists vTcl(set_tk_vars_found)]
        && [info exists vTcl(support_variable_list)]} {
        foreach {v t} $vTcl(support_variable_list) {
            lappend needed $v
        }
        foreach v $needed {
            set ret [lsearch -exact $vTcl(tk_vars) $v]
            if {$ret == -1} {
                lappend vTcl(must_add_vars) $v $t
            }
        }
    } else {
        # This is the case where we do not have an existing
        # set_Tk_var() and so must add all of the pairs.
        if {[info exists vTcl(support_variable_list)]} {
            foreach {v t} $vTcl(support_variable_list) {
                lappend vTcl(must_add_vars) $v $t
            }
        }
    }
}



# proc vTcl:check_popup_call { } {
#     global vTcl
#     set vTcl(must_add_popup) 0
#     if {$vTcl(popups_in_tree) && !$vTcl(popup_found)} {
#         set vTcl(must_add_popup) 1
#     }
# }

proc vTcl:check_rename_list { } {
}



proc vTcl:update_support_module {} {
    global vTcl
    vTcl:set_timestamp
    vTcl:Window.py_console "supp"
    set new_code [vTcl:gen_updated_source]
    set numbered [vTcl:add_line_numbers $new_code] ;# Aids console readability.
    $vTcl(supp_source_window)  delete 1.0 end
    $vTcl(supp_source_window)  insert end $numbered
    set vTcl(py_source) $new_code
    vTcl:colorize_python "supp"
}

proc vTcl:check_variable_list {} {
    global vTcl
    if {[info exists vTcl(must_add_vars)]} {
        unset vTcl(must_add_vars)
    }
    # vTcl(tk_vars) is the list of variables already found in an
    # existing set_Tk_var() function.  vTcl(support_variable_list) is
    # built by vTcl:python_inspect_config which is called for each
    # widget in the tree.
    if {[llength $vTcl(support_variable_list)] == 0} return
    if {[info exists vTcl(support_variable_list)]} {
        #        set vTcl(support_variable_list) \
            [lsort -unique $vTcl(support_variable_list)]
        }
    if {[info exists vTcl(set_tk_vars_found)]
        && [info exists vTcl(support_variable_list)]} {
        foreach {v t} $vTcl(support_variable_list) {
            lappend needed $v
        }
        foreach v $needed {
            set ret [lsearch -exact $vTcl(tk_vars) $v]
            if {$ret == -1} {
                lappend vTcl(must_add_vars) $v $t
            }
        }
    } else {
        # This is the case where we do not have an existing
        # set_Tk_var() and so must add all of the pairs.
        if {[info exists vTcl(support_variable_list)]} {
            foreach {v t} $vTcl(support_variable_list) {
                lappend vTcl(must_add_vars) $v $t
            }
        }
    }
}


# proc vTcl:check_popup_call { } {
#     global vTcl
#     set vTcl(must_add_popup) 0
#     if {$vTcl(popups_in_tree) && !$vTcl(popup_found)} {
#         set vTcl(must_add_popup) 1
#     }
# }

proc vTcl:check_rename_list { } {
}



proc vTcl:update_support_module {} {
    global vTcl
    vTcl:set_timestamp
    vTcl:Window.py_console "supp"
    set new_code [vTcl:gen_updated_source]
    set numbered [vTcl:add_line_numbers $new_code] ;# Aids console readability.
    $vTcl(supp_source_window)  delete 1.0 end
    $vTcl(supp_source_window)  insert end $numbered
    set vTcl(py_source) $new_code
    vTcl:colorize_python "supp"
}

proc vTcl:check_variable_list {} {
    global vTcl
    if {[info exists vTcl(must_add_vars)]} {
        unset vTcl(must_add_vars)
    }
    # vTcl(tk_vars) is the list of variables already found in an
    # existing set_Tk_var() function.  vTcl(support_variable_list) is
    # built by vTcl:python_inspect_config which is called for each
    # widget in the tree.
    if {[llength $vTcl(support_variable_list)] == 0} return
    if {[info exists vTcl(support_variable_list)]} {
        #        set vTcl(support_variable_list) \
            [lsort -unique $vTcl(support_variable_list)]
        }
    if {[info exists vTcl(set_tk_vars_found)]
        && [info exists vTcl(support_variable_list)]} {
        foreach {v t} $vTcl(support_variable_list) {
            lappend needed $v
        }
        foreach v $needed {
            set ret [lsearch -exact $vTcl(tk_vars) $v]
            if {$ret == -1} {
                lappend vTcl(must_add_vars) $v $t
            }
        }
    } else {
        # This is the case where we do not have an existing
        # set_Tk_var() and so must add all of the pairs.
        if {[info exists vTcl(support_variable_list)]} {
            foreach {v t} $vTcl(support_variable_list) {
                lappend vTcl(must_add_vars) $v $t
            }
        }
    }
}

proc vTcl:check_function_list {} {
    global vTcl
    if {[info exists vTcl(must_add_procs)]} {
        unset vTcl(must_add_procs)
    }
    # vTcl(support_function_list) is the list of function that need to
    # be supported. It is generated in vTcl:scan_widgets.
    # It does not include the validation functions.
    if {[info exists vTcl(support_function_list)] } {
        set vTcl(support_function_list) \
            [lsort -unique $vTcl(support_function_list)] ;# Remove duplicates.
        foreach f $vTcl(support_function_list) {
            if {$f == "_button_press" || $f == "_button_release"
                || $f ==  "_mouse_over"} continue
            # Since popup functions are in GUI module not support module.
            if {[regexp {^popup[0-9]+} $f]} continue
            # For the special case of sys.exit()
            if {[regexp {sys.exit\(.*\)} $f]} continue
            if {[regexp {sys.exit} $f]} continue
            set nf $f
                                              # from function name
            regexp {\w+\.(\w+)} $f match nf  ;# delete "xxx_support."
            regexp {[ ]*lambda.*:[ ]*(.*)} $nf match nf ; # delete any lambda.
            regexp {(.*)\(} $nf match nf ;# delete parameters from function name
            # See if the function we need in the functions already there.
            set procs_found [list {*}$vTcl(procs_found) {*}$vTcl(rename_found)]
            set ret [lsearch -exact $procs_found $nf]
            # if not add it.
            if {$ret == -1 && $f ne ""} {
                lappend vTcl(must_add_procs) $f
            }
        }
    }
}
proc vTcl:check_validation_list {} {
    global vTcl
    # vTcl(validation_function_list) is the list of function that need to
    # be supported. It is generated in vTcl:scan_widgets.
    # It does not include the validation functions.
    if {[info exists vTcl(must_add_validation)]} {
        unset vTcl(must_add_validation)
    }
    if {[info exists vTcl(validate_function_list)] } {
        set vTcl(validation_function_list) \
            [lsort -unique $vTcl(validate_function_list)] ;# Remove duplicates.
        foreach f $vTcl(validate_function_list) {
            if {$f == "_button_press" || $f == "_button_release"
                || $f ==  "_mouse_over"} continue
            # Since popup functions are in GUI module not support module.
            if {[regexp {^popup[0-9]+} $f]} continue
            set nf $f
            regexp {\w+\.(\w+)} $f match nf  ;# delete "xxx_support."
                                              # from function name
            regexp {[ ]*lambda.*:[ ]*(.*)} $nf match nf ; # delete any lambda.
            regexp {(.*)\(} $nf match nf ;# delete parameters from function name
            # See if the function we need in the functions already there.
            set procs_found [list {*}$vTcl(procs_found) {*}$vTcl(rename_found)]
            set ret [lsearch -exact $procs_found $nf]
            # if not add it.
            if {$ret == -1 && $f ne ""} {
                # lappend vTcl(must_add_procs) $f
                lappend vTcl(must_add_validation) $f
            }
        }
    }
}

proc vTcl:check_toplevel_list {} {
    # First check to see if we must add a toplevel invocation.
    global vTcl widget
    if {![info exists vTcl(required_toplevel_classes)]} { return }
    if {[info exists vTcl(must_add_toplevels)]} {
        unset vTcl(must_add_toplevels)
        unset vTcl(must_add_toplevel_names)
    }
    if {[info exists vTcl(must_delete_toplevels)]} {
        unset vTcl(must_delete_toplevels)
    }
    if {[info exists vTcl(change_class_name)]} {
        unset vTcl(change_class_name)
    }
    # vTcl(required_toplevel_classes) looks like
    #           {.top1 Toplevel1} {.top2 Toplevel2} {.top4 Toplevel3}
    # vTcl(toplevel_create_statements_found) looks like
    #    {.top1 Toplevel1 _top1} {.top2 Toplevel2 _top2} {.top4 Toplevel3 _top4}
    # First check to see what toplevel create code is needed.
    foreach rn $vTcl(required_toplevel_classes) {
        set req_top [lindex $rn 0]
        set req_name [lindex $rn 1]
        set found 0
        foreach cs $vTcl(toplevel_create_statements_found) {
            if {$req_top in $cs} {
                set found 1
            }
        }
        if {!$found} {
            lappend vTcl(must_add_toplevels) $req_top
            lappend vTcl(must_add_toplevel_names) $req_name
        }
    }
    # Next see if class names need to be changed.
    foreach c $vTcl(toplevel_create_statements_found) {
        set create_widget [lindex $c 0]
        set create_name [lindex $c 1]
        set create_top [lindex $c 2]
        if {[winfo exists $create_widget]} {
            set alias [vTcl:clean_string $widget(rev,$create_widget)]
            if {$create_name ne $alias} {
                lappend vTcl(change_class_name) \
                    [list $create_name]
            }
        }
    }
    # See if we need to delete toplevel create code.
    foreach c $vTcl(toplevel_create_statements_found) {
        set create_widget [lindex $c 0]
        set create_name [lindex $c 1]
        set create_top [lindex $c 2]
        set found 0
        foreach rn $vTcl(required_toplevel_classes) {
            # if {$create_widget in $rn} {              }
            if {$create_name in $rn} {
                set found 1
            }
        }
            if {!$found} {
                lappend vTcl(must_delete_toplevels) \
                    [list $create_widget $create_name]
            }
    }
}

proc vTcl:check_custom_list { } {
    global vTcl
    # if {[info exists vTcl(must_add_custom)]} {
    #     unset vTcl(must_add_custom)
    # }
    if {[info exists vTcl(must_add_custom)]} {
        unset vTcl(must_add_custom)
    }
    if {[info exists vTcl(support_custom_list)] } {
        foreach c $vTcl(support_custom_list) {
            if {[info exists vTcl(custom_found)]} {
                set ret [lsearch -exact $vTcl(custom_found) $c]
                if {$ret == -1} {
                    lappend vTcl(must_add_custom) $c
                }
            } else {
                lappend vTcl(must_add_custom) $c
            }
        }
    }
} ;# end check_custom_list

proc vTcl:check_popup_call { } {
    global vTcl
    set vTcl(must_add_popup) 0
    if {[info exists vTcl(popups_in_tree)] == 0} {
        return
    }
    if {$vTcl(popups_in_tree) && !$vTcl(popup_found)} {
        set vTcl(must_add_popup) 1
    }
}

proc vTcl:check_rename_list { } {
}

proc vTcl:gen_updated_source {} {
    # Adds actual new lines of code to the support module. This was
    # modified extensively for Release 7. Removed code can be found in
    # 7w version.
    global vTcl tcl_platform widget
    set line_count 0
    set first_function 0
    set timestamp_found 0
    set last_line_null 0
    set added_set_tk_var_call 0
    set protocol_line_found 0
    set time_patt \
        "#\\s*(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec).+(AM|PM)"
    set tkvar_patt "^def +set_Tk_var()"
    set destroy_patt "^def +destroy_window()"
    set proc_patt "^def +(\\w+)"
    # set name_patt "^if __name__ == '__main__':"
    # set name_patt "^if __name__ == \['\"\]__main__\['\"\]:"
    set name_patt "^if\\s+__name__\\s*==\\s* \['\"\]__main__\['\"\]:"
    set root_patt "^\\s*root\\s*=\\s*tk.Tk\\(\\)"
    set mainloop_patt "^\\s*root.mainloop()"
    # Next three for updating toplevel invocation.
    # set global_patt "^\\s*global _top(\[0-9\]+)"
    set global_patt "^(\\s*)(global _top(\[0-9\]+, _w\[0-9\]+))"
    # set toplevel_patt "_top(\[0-9\]+)\\s*=\\s*tk\.Toplevel\(root\)"
    # set toplevel_patt "^\\s*_top(\[0-9\]+)\\s*=\\s*tk\.Toplevel\\(root\\)"
    set toplevel_patt \
        "^(\\s*)(_top(\[0-9\]+)\\s*=\\s*tk\.Toplevel\\(root\\))"
    set create_toplevel_patt \
    "^(\\s*)(_w(\[0-9\]+)\\s*=\\s*.*\\.(\\w+)\\((\\w+)\\))"
    set proc_rename_patt "^(\\w+)\\s*=\\s*"
    set popup_patt "^\\s*\\w+\\._create_popup_variables\\(\\)"
    set root_destroy_patt "^\\s*root\\.protocol.*root\\.destroy"
    foreach line $vTcl(support_module) {
        #set skip 0
        # First test for the tmodify_popup_creatype of import statement.
        if {[string first "import Tkinter as tk" $line] > -1} {
            set vTcl(tk_prefix) "tk."
        }
        if {[string first "from Tkinter import *" $line] > -1} {
            set vTcl(tk_prefix) ""
        }
        # Look for time stamp. Since we are doing an update There will be one.
        set ret [regexp $time_patt $line]
        if {$ret} {
            set vTcl(time_stamp_line) $line_count
            set vTcl(timestamp_found) 1
            set timestamp_found 1
            append str $line "\n"
            continue
        }
        # In the middle of time stamp lines, go past them all and then
        # add the new one.
        if {$timestamp_found && ![regexp $time_patt $line]} {
            append str "#    $vTcl(timestamp)  platform: $tcl_platform(os)\n"
            set timestamp_found 0
            append str $line "\n"
            continue
        }
        # Look for "root.mainloop()" precede with new invocations.
        set ret [regexp $mainloop_patt $line]
        if {$ret} {
            if {[info exists vTcl(must_add_toplevels)]} {
                foreach top $vTcl(must_add_toplevels) {
                    # Extract number
                    set n [string range $top 4 end]
                    append str "$vTcl(tab)# Creates a toplevel widget.\n"
                    append str "$vTcl(tab)global _top$n, _w$n\n"
                    append str "$vTcl(tab)_top$n = tk.Toplevel(root)\n"
                    set alias $widget(rev,$top)
                    set alias [vTcl:clean_string $alias]
                    ;# NEEDS WORK
                    set project_name [vTcl:get_project_name]
                    set project_root [file rootname $project_name]
                    append str \
                        "$vTcl(tab)_w$n = ${project_root}.${alias}(_top${n})\n"
                }
            }
        }
        set ret [regexp $create_toplevel_patt \
                     $line match blanks stmt number name]
        if {$ret} {
            set w ".top$number"
            # First see if we are deleting toplevel
            # No longer deleting toplevel invocations. Basic rule: don't delete.
            # if {$w ni $vTcl(tops)} {
            #     # We are deleting w so comment line
            #     # set line "#$line"
            #     set line "${blanks}# $stmt"
            # } else {
            if {[info exists vTcl(change_class_name)] && \
                $name in $vTcl(change_class_name)} {
                # there has been a change to a toplevel class alias
                # and so the class name has been changed so update the
                # class name in the invocation code by changing the
                # current line to a comment and then adding a new
                # line.
                #set alias $widget(rev,$w)
                #set alias [vTcl:clean_string $alias]
                if {[info exists vTcl(toplevel_alias,$name)]} {
                    set alias  $vTcl(toplevel_alias,$name)
                    regsub $name $line $alias name_string
                    set line "${blanks}# $stmt\n"
                    append line $name_string
                }
            }
                # } ;# Part of toplevel deletion, that I decided against.
        }
        # Look for "if __name__ == '__main__':"
        set ret [regexp $name_patt $line]
        if {$ret} {
            append str [vTcl:add_new_functions]
            append str "\n"
            append str [vTcl:add_new_validation]
            append str "\n"
            append str [vTcl:add_new_custom_stmts] "\n"
            append str $line "\n"
            continue
        }
        append str $line "\n"  ;# The default case.
    }
    set vTcl(supp_save_warning) "Unsaved changes"
        set ret [regexp $toplevel_patt $line match number]
    #set str [vTcl:remove_multiple_blank_lines $str]
    return $str
}


proc vTcl:add_new_functions {} {
    # The actual creation of the functions occurs in the function
    # vTcl:create_functions which resides in gui_python_gen.tcl.
    global vTcl
    if {![info exists vTcl(must_add_procs)]} return
    set vTcl(proc_list) {}
    set vTcl(funct_list) $vTcl(must_add_procs)
    vTcl:create_functions  "import"
    append ret "\n" $vTcl(functions) "\n"
    return $ret
}

proc vTcl:add_new_validation {} {
    # The actual creation of the validation functions occurs in the function
    # vTcl:create_functions which resides in gui_python_gen.tcl.
    global vTcl
    if {![info exists vTcl(must_add_validation)]} return
    set vTcl(proc_list) {}
    set vTcl(funct_list) $vTcl(must_add_validation)
    set vTcl(validate_function_list) $vTcl(must_add_validation)
    vTcl:create_validation_functions
    append ret "\n" $vTcl(functions) "\n"
    return $ret
}

proc vTcl:add_new_custom_stmts {} {
    global vTcl
    if {![info exists vTcl(must_add_custom)]} return
    append str "\n"
    foreach c [lsort -unique $vTcl(must_add_custom)] {
        append str \
          "$c = tk.Frame  # To be updated by user with name of custom widget.\n"
    }
    return $str
}

proc vTcl:analyze_existing_support_module {} {
    # Read existing support file and look for (1) defined function
    # names, (2) tk var occurrences, (3) custom rename occurrences,
    # (4) toplevel creations, and (4) toplevel class names. The list
    # of support module may include set_Tk_var which will are to be
    # treated specially. The main things calculated are the lists of
    # existing tk vars, callback functions, custom renames, toplevel
    # creation statements, and toplevel class names.
    global vTcl widget
    set module [vTcl:read_support_module]
    set vTcl(support_module) [split $module "\n"] ;# module split into lines
    set time_patt "# +(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec).+(AM|PM)"
    set proc_patt "^def +(\\w+)"
    set custom_patt "^(Custom\\w*)\\s*="
    set name_patt "^if __name__ == '__main__':"
    set end_patt "^\[#\\w\]"
    set create_toplevel_patt \
        "^\\s*_w(\[0-9\]+)\\s*=\\s*.*\\.(\\w+)\\((\\w+)\\)"
    set proc_rename_patt "^(\\w+)\\s*=\\s*"
    set popup_patt "^\\s*\\w+\\._create_popup_variables\\(\\)"
    set vTcl(timestamp_found) 0
    set vTcl(procs_found) [list]
    set vTcl(name_found) 0
    set vTcl(set_tk_vars_found) 0
    set vTcl(rename_found) [list]
    set vTcl(custom_flag) 0
    set vTcl(toplevel_classes_found) [list]
    set vTcl(toplevel_create_statements_found) [list]
    set line_count 0
    set var_flag 0
    #set first_class_flag 0
    foreach line $vTcl(support_module) {
        # look for functions found in the support module.
        set ret [regexp $proc_patt $line match name]
        if {$ret} {
            lappend vTcl(procs_found) $name
        }

        # look for "module._create_popup_variables()"
        set ret [regexp $popup_patt $line match name]
        if {$ret} {
            set vTcl(popup_found) 1
        }
        # look for custom lines
        set ret [regexp $custom_patt $line match name]
        if {$ret} {
            lappend vTcl(custom_found) $name
        } else {
            # look for proc rename lines
            set ret [regexp $proc_rename_patt $line match name]
            if {$ret} {
                lappend vTcl(rename_found) $name
            }
        }
        # look for Class creation line
        set ret [regexp $create_toplevel_patt $line match number name master]
        if {$ret} {
            lappend vTcl(toplevel_classes_found) $name
            lappend vTcl(toplevel_create_statements_found) \
                        [list .top$number $name $master]
            #set vTcl(existing_name,.top$number) $name
            if {[winfo exists .top$number]} {
                set alias $widget(rev,.top$number)
                set alias [vTcl:clean_string $alias]
                lappend vTcl(toplevel_alias,$name) $alias
            }
        }
    }
}

proc vTcl:get_import_name { } {
    # Builds the root name of the support module for use in generating
    # skeletal functions.
    global vTcl
    set t [file tail $vTcl(project,file)]
    set vTcl(import_name) [file rootname $t]_support
    set vTcl(import_filename) "[file rootname $vTcl(project,file)]_support.py"
}

proc vTcl:get_gui_name { } {
    # Builds the root name of the support module for use in generating
    # skeletal functions.
    global vTcl
    set t [file tail $vTcl(project,file)]
    set vTcl(gui_name) [file rootname $t]
    set vTcl(gui_filename) "[file rootname $vTcl(project,file)].py"
}

proc  vTcl:generate_support {} {
    # This is the top of the generation.
    global vTcl
    global tcl_platform widget
    vTcl:python_inspect_popup  ;# Here we look at any popup menus. 1/12/17

    vTcl:set_timestamp
    set source \
"#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version $vTcl(version)
#  in conjunction with Tcl version $vTcl(tcl_version)
#    $vTcl(timestamp)  platform: $tcl_platform(os)\n"
    # Append to source the import code.
#     append source \
# "
# import sys

# try:
# $vTcl(tab)import Tkinter as tk
# except ImportError:
# $vTcl(tab)import tkinter as tk

# try:
# $vTcl(tab)import ttk
# $vTcl(tab)py3 = False
# except ImportError:
# $vTcl(tab)import tkinter.ttk as ttk
# $vTcl(tab)from tkinter.constants import *
# $vTcl(tab)py3 = True"

    append source \
"
import sys
import tkinter as tk
import tkinter.ttk as ttk
from tkinter.constants import *"
    vTcl:get_gui_name
    append source "\n\nimport $vTcl(gui_name)\n"
#    if {[llength $vTcl(support_variable_list)] > 0} {
#       append source \
#"$vTcl(tab)set_Tk_var()"
#    }
    append source \
"
def main(*args):
$vTcl(tab)'''Main entry point for the application.'''"
    append source \
"
$vTcl(tab)global root
$vTcl(tab)root = tk.Tk()
${vTcl(tab)}root.protocol( 'WM_DELETE_WINDOW' , root.destroy)"
    # if {[info exists vTcl(p_v_list)]  &&  [llength $vTcl(p_v_list)]} {
    #     append source \
    #         "\n$vTcl(tab)$vTcl(gui_name)._create_popup_variables()"
    # }
#     if {[llength $vTcl(support_variable_list)] > 0} {
#         append source \
# "
# $vTcl(tab)set_Tk_var()"
#     }
# Code for creating the toplevels.
    set tc 1
    foreach t $vTcl(tops) {
        if {[string first ".bor" $t] > -1} { continue }
        set alias $widget(rev,$t)
        set alias [vTcl:clean_string $alias]
        set n [string range $t 4 end]
        append source \
"
$vTcl(tab)# Creates a toplevel widget.
$vTcl(tab)global _top$n, _w$n"

        if {$tc == 1} {
            append source \
"
${vTcl(tab)}_top$n = root"
        } else {
            append source \
"
${vTcl(tab)}_top$n = tk.Toplevel(root)"


        }
            append source \
"
${vTcl(tab)}_w$n = ${vTcl(gui_name)}.${alias}(_top$n)"

        incr tc
    }
# end of toplevel creation code.

    append source \
"
$vTcl(tab)root.mainloop()
"

    set vTcl(import_module) "[file rootname $vTcl(project,file)]_support.py"
    # Create code for the Tk support variables.  This section may not be needed.
    # if {[llength $vTcl(support_variable_list)] > 0} {
    #     set vTcl(variable_code) \
    #         [vTcl:py_build_set_Tk_var $vTcl(support_variable_list)]
    #     append source "\n" $vTcl(variable_code)
    # }

    # Create code for the functions needed.

    # NEEDS WORK: Consider replacing the next4 lines with call to
    # add_new_tk_vars "new".

    #set vTcl(support_variable_list) \
    #    [lsort -unique $vTcl(support_variable_list)]
    set vTcl(proc_list) {}
    set vTcl(funct_list) $vTcl(support_function_list)
    vTcl:create_functions "import"
    append source "\n" $vTcl(functions) "\n"
    vTcl:create_validation_functions

    set project_name [vTcl:get_project_name]
    append source "\n" $vTcl(functions)


    if {$vTcl(custom_present)} {
        set ll [lsort -unique $vTcl(support_custom_list)]
        foreach l  $ll {
        append source \
"
$l = tk.Frame  # To be updated by user with name of custom widget.
"
       }
    }
    set vTcl(project,GUI_module) [file rootname $vTcl(project,name)]
    # Adding restart function required removal of # from project name.
    regsub -all "#" $vTcl(project,GUI_module) "" import_module
    append source \
"
if __name__ == '__main__':
$vTcl(tab)$import_module.start_up()
"
    # Now write the code into the console window.
#    vTcl:Window.py_console "supp"
    set numbered [vTcl:add_line_numbers $source]
    $vTcl(supp_source_window)  delete 1.0 end
    $vTcl(supp_source_window)  insert end $numbered
    set vTcl(supp_save_warning) "Unsaved changes"
    set vTcl(py_source) $source
    vTcl:colorize_python "supp"
    return
}

proc vTcl:scan_widgets {top} {
    # Here I scan the widget tree looking for stuff to put into the
    # support module as part of the skeleton code, mainly functions
    # and variables. New stuff includes class names. This is called
    # for each toplevel widget.
    global vTcl
    global widget
    set c [vTcl:get_class $top]
    if {$c eq "Toplevel"} {
        # Build list of toplevel class names.
        set alias $widget(rev,$top)
        set alias [vTcl:clean_string $alias]
        lappend vTcl(required_toplevel_classes) [list $top $alias]
        set vTcl($top,top_alias) $alias
        set vTcl($alias,top_widget) $top
    }
    vTcl:python_inspect_bind $top
    foreach w [winfo children $top] { # Rozen
        if {[string first "vTH_" $w] > -1} continue ;# skip over handles
        set class [vTcl:get_class $w]
        if {$class == "Custom"} {
            set vTcl(custom_present) 1
            # Get variation if any
            if {[info exists vTcl($w,-variant)]} {
                set variant $vTcl($w,-variant)
                set c_v Custom$variant
            } else {
                set c_v Custom
            }
            # Add alias to custom list
            lappend vTcl(support_custom_list) $c_v
            #continue
        }
        vTcl:python_inspect_widget $w
        vTcl:python_inspect_bind $w
        vTcl:scan_widgets $w       ; # trying to recurse thru children
                                     # of widgets 12/18/2015
    }
    return 0
}

proc vTcl:python_inspect_popup {} {
    # See if we have a popup menu and if so find all the functions to be invoked.
    global vTcl
    set root_list [winfo children .]
    # if {[lsearch $root_list ".popup"] > -1} {
    #     vTcl:python_inspect_widget .popup
    # }
    set vTcl(popup_in_tree) 0
    set vTcl(modify_popup_create) 0
    set popups [lsearch -all -inline $root_list ".pop*"]
    if {[llength $popups]} {
        set vTcl(popups_in_tree) 1
    } else {
        set vTcl(popups_in_tree) 0
    }
    foreach popup $popups {
        vTcl:python_inspect_widget $popup
    }
    # if {[info exists vTcl(p_v_list)]} {
    #     # No popups in tree, but _create... line in support module. Must
    #     # comment line.
    #     if {[llength $vTcl(p_v_list)] > 0} {
    #         if {$vTcl(popups_in_tree) == 0} {
    #            if { [info exists vTcl(popup_found)] && $vTcl(popup_found) == 1} {
    #                 set vTcl(modify_popup_create) 1
    #                 return 1
    #            }
    #         }
    #         # Popups_in_tree, but no _create... line in support module. Must add.
    #         if {$vTcl(popups_in_tree) == 1 && $vTcl(popup_found) == 0} {
    #             set vTcl(modify_popup_create) 2
    #             return 1
    #         }
    #     }
    # }
    return 0
}
proc vTcl:python_inspect_widget {target} {
    # Decide which configuration inspection function to call.
    global vTcl
    set widclass [winfo class $target]
    switch $widclass {
        TMenubutton {
            set menu [$target cget -menu]
            vTcl:python_inspect_menu_config $menu
        }
        Menu -
        Popupmenu {
            vTcl:python_inspect_menu_config $target
        }
        PNotebook -
        TNotebook {
            # A container widget.
            set pages [$target tabs]
            foreach p $pages {
                # for widgets inside each page.
                vTcl:python_inspect_subwidgets $p
            }
        }
        TPanedwindow {
            # A container widget
            set panes [$target panes]
            foreach p $panes {
                vTcl:python_inspect_subwidgets $p
            }
        }
        Frame -
        TFrame -
        TLabelframe {
            # The other container widgets.
            vTcl:python_inspect_subwidgets $target
        }
        Scrolledcanvas -
        Scrolledlistbox -
        Scrolledtext -
        Scrolledtreeview -
        Scrolledentry -
        Scrolledcombo {
            vTcl:python_inspect_subwidgets $target
        }
        default {
            vTcl:python_inspect_config $target $widclass
        }
    }
    return 0
}

proc vTcl:python_inspect_config {widget widclass} {
    global vTcl
    set opt [$widget configure]
    foreach op $opt {
        foreach {o x y d v} $op {}
        set v [string trim $v]
        set len [string length $o]
        set sub [string range $o 1 end] ;# Removes leading '-'.
        switch -exact -- $sub {
            textvariable {
                if {[string length $v] == 0} continue
                if {[string first self. $v] == 0} continue
                #if {[string first . $v] == -1} continue
                # Import variable
                # set i [string first . $v]
                # set vv [string range $v 0 [expr $i - 1]]
                # set vTcl(global_variable) 1
                # lappend vTcl(support_variable_list) $vv "StringVar"
                lappend vTcl(support_variable_list) $v "StringVar"
                # switch $widclass {
                #     "Button" -
                #     "TButton" -
                #     "Label" -
                #     "TLabel" -
                #     "Message" {
                #         set vTcl($v,add_smileyface) [$widget cget -text]
                #     }
                #     default {
                #         set vTcl($v,add_smileyface) 0
                #     }
                # }
                if {[lsearch $vTcl(widgets_with_textvarable) $widclass] > -1} {
                    set vTcl($v,add_smileyface) [$widget cget -text]
                } else {
                    set vTcl($v,add_smileyface) 0
                }
            }
            variable {
                if {[string length $v] == 0} continue
                if {[string first self. $v] == 0} continue
                set vTcl(imported_variable) 1
                switch $widclass {
                    Radiobutton -
                    TRadiobutton {
                        set tvalue [$widget cget -value]
                        set tvalue [string trim $tvalue]
                        if {[string first "'" $tvalue] == 0} {
                            set m StringVar
                        } else {
                            set m IntVar
                        }
                    }
                    default {
                        # Includes TProgressbar and TScale
                        set m IntVar
                    }
                }
                lappend vTcl(support_variable_list) $v $m
            }
            listvariable {
                if {[string length $v] == 0} continue
                if {[string first self. $v] == 0} continue
                    set vTcl(imported_variable) 1
                    switch $widclass {
                        "Scrolledlistbox" -
                        "TCheckbutton" -
                        "Listbox" -
                        "TRadiobutton" {
                            # If the variable contains '::' then I
                            # want to remove the '::'.
                            regsub "::" $v "" v
                            set m "StringVar"
                        }
                        "TScale" -
                        "Scale" {
                            set m "DoubleVar"
                        }
                        "Checkbutton" -
                        "Radiobutton" -
                        "TProgressbar" {
                            set m "IntVar"
                        }
                    }
                lappend vTcl(support_variable_list) $v $m
            }
            geoge {
                if {$v == ""} continue
                # regexp {[a-zA-Z0-9_]+} $v vvv ;# Extracts the command
                regexp {\w+} $v vvv ;# Extracts the command
                                               # which has already
                                               # been checked.
                lappend vTcl(validate_function_list) [string trim $vvv]
                lappend vTcl(support_function_list) [string trim $vvv]
                set vTcl(validate_function,$vvv) $sub
            }
            validatecommand -
            invalidcommand -
            postcommand -
            command  {
                if {$v == ""} continue
                set r $v
                if {[string first xview $v] > -1} continue
                if {[string first yview $v] > -1} continue
                if {[string first "self." $v] == 0} {
                    # discard class functions
                    continue
                }
                if {[string first "lambda" $v] == 0} {
                    # Remove the lambda part of the function name but
                    # leave parameters.
                    set index [string first ":" $v]
                    set exp [expr $index + 1]
                    set r [string range $v [expr $index + 1] end]
                }
                set rr [string trim $r]
                if {$sub eq "command" | $sub eq "postcommand"} {
                    lappend vTcl(support_function_list) [string trim $r]
                } else {
                    set pieces [split $rr]
                    set first_piece [lindex $pieces 0]
                    lappend vTcl(validate_function_list) $first_piece
                    set vTcl(validate_function,$rr) $sub
                }
                if {$widclass == "Scale" || $widclass == "TScale"} {
                    lappend vTcl(variable_parms) [string trim $r]
                }
            }
            opencmd -
            closecmd -
            browsecmd {
            }
        }
    }
    return 0
}

proc vTcl:invalid_syntax_response {widget} {
    # Come here when bad syntax is detected.
    global vTcl
    set name [vTcl:widget_2_widname $widget]
    ::vTcl::MessageBox -icon error -message \
        "Syntax error: $vTcl(bad_string), contains syntax error for $name\nCode generation aborted." \
        -title "Syntax Error!" -type ok
    set message \
        "Syntax error: $widget $name"
    error $message "" 401
}

proc vTcl:check_validate_cmd {cmd} {
    # cmd should have the form: (vcmd, '%x', ...)
    global vTcl
    set tcmd [string trim $cmd]
    # Check for enclosing '(' ')'
    if {![regexp {^\((.*)\)$} $tcmd dummy ext]} {
        set vTcl(bad_string) $cmd
        return 0
    }

    set pieces [split $ext "," ]
    # Grab first chunk and check that it is an identifier.
    set p [lrange $pieces 0 0]
    set p [string trim $p]
    # call isident to check p
    # if {![vTcl:isident $p]} {
    #     set vTcl(bad_string) $cmd
    #     return 0
    # }

    # Exclude first piece
    set pieces [lrange $pieces 1 end]
    # each piece
    foreach p $pieces {
        set pp [string trim $p] ;# for case where input tuple ends with ','.
        if {$pp == ""} continue
        set xx [regexp {^'%[diPsSvVW]'$}  $pp]
        set yy [regexp {^"%[diPsSvVW]"$}  $pp]
        if {!$xx && !$yy} {
            set vTcl(bad_string) $cmd
            return 0
        }
    }
    return 1
}

proc vTcl:python_inspect_subwidgets {subwidget} {
    global vTcl
    set widget_tree [vTcl:get_children $subwidget]
    foreach i $widget_tree {
        if {"$i" != "$subwidget"} {
            vTcl:python_inspect_widget $i
            vTcl:python_inspect_widget $i
        }
    }
    return 0
}

proc extract_up_to_period {str} {
    set index [string first ":" $str]
    if {$index > -1} {
        set str [string range $str [expr $index + 1] end]
    }
    set index [string first "." $str]
    set module [string range $str 0 [expr $index - 1]]
    set module [string trim $module]
    return $module
}

proc vTcl:extract_module_name {fun_list var_list import} {
    # Look at the variable and function names and extract the module name.
    global vTcl
    set module {}
    if {[llength $fun_list] > 0} {
         foreach {funct} $fun_list {
             set m [extract_up_to_period $funct]
             if {$m != "" && $m != "self"} {
                lappend module [extract_up_to_period $funct]
             }
          }
    set vTcl(l_v_list) {}
    }
    if {[llength $var_list] > 0} {
        foreach {var type} $var_list {
            set m [extract_up_to_period $var]
            if {$m != "" && $m != "self"} {
                lappend module [extract_up_to_period $var]
            }
        }
    }
    set module [lsort -unique $module]
    # A couple of diagnostics to see that there is only one import named.
    if {[llength $module] > 1} {
        append msg "There is more than one module specified for import. " \
            "\nThey are: "
        foreach {m} $module {
            append msg $m ", "
        }
        tk_dialog -title Error $msg error 0 "OK"
        return "Failure"
    }
    if {$import == "import"} {
        if {[llength $module] < 1} {
            set msg "There no modules specified for import"
            foreach {m} $module {
                append msg $m ", "
            }
            ::vTcl::MessageBox -title Error -message $msg
            #tk_dialog -title Error $msg error 0 "OK"
        }
    }
    if {[info exists module]} {
        return $module
    } else {
        return ""
    }
}

proc vTcl:test_file_content {filename new_content} {
    # Function to determine if we can safely skip the save function.
    # A return value of 0 means that we can skip the actual save.
    # A return value of 1 means that we must save.
    global vTcl
    set save 1
    set skip 0
    # If we changed the GUI then save everything
    if {$vTcl(change) > 0} {
        vTcl:save
        return $save
    }
    # If the Python file does not exist, we clearly have to save it.
    if {[file exists $filename] == 0} {
        return $save
    }
    # If we have edited the Python Console code window, we have to save.
    #set modified [$vTcl(gui_code_window) edit modified]
    #if {$modified} {
    #    return $save
    #}
    # If the content of the code window is unchanged, we can skip the save.
    if {$new_content == $vTcl(last_save,$vTcl(python_module))} {
        return $skip     ;# Skip the save.
    }
    # If we have not modified the file then we can skip the save.
    #if {!$modified} {
    #    return $skip
    #    }
    # If we got this far then we want to save.
    return $save     ;# Do the save.
}

proc vTcl:save_python_file {filename prefix} {
    # Write out the file using filename which should be a file name in
    # the same directory as the input tcl file.  It saves existing
    # versions of the file in rotating backup files with added
    # extensions of bak1, bak2, ...
    global vTcl
    update
    vTcl:backup_files $filename
    set vTcl(py_source) [$vTcl(${prefix}_source_window) get 1.0 end]
    set vTcl(py_source) [vTcl:remove_numbers $vTcl(py_source)]
    set vTcl(py_source) [vTcl:remove_tabs $vTcl(py_source)]
    set fid [open $filename "w"]
    puts $fid $vTcl(py_source)
    flush $fid
    close $fid
    #set vTcl(last_save,$vTcl(python_module)) $vTcl(py_source)
    #$vTcl(gui_code_window) edit modified 0
    return 0
}

proc  vTcl:python_inspect_menu_config {target} {
    global vTcl
    if {[string first .# $target] >= 0} {return}
    set entries [$target index end]
    if {$entries == "none"} {return}
    set result ""
    for {set i 0} {$i<=$entries} {incr i} {
        set type [$target type $i]
        if {$target == $vTcl(toplevel_menu)} {
            if {$type == "tearoff"} {
                # tearoff at toplevel doesn't really mean anything,
                # but let the user specify it anyway.
                continue
            }
        }
        set opts [$target entryconfigure $i]
        switch $type {
            cascade {
                set child [$target entrycget $i -menu]
                vTcl:python_inspect_menu_config $child
            }
            command -
            checkbutton -
            radiobutton {
                vTcl:python_menu_support $opts
            }
        }
    }
}

proc vTcl:python_menu_support {opts} {
    # Look at menus to extract module names and Tk variables.
    global vTcl
    foreach op $opts {
        foreach {o x y d v} $op {
            # o - option
            # d - default
            # v - value
        }
        set v [string trim $v]
        if {$d == $v && $o != "-variable"} continue ;# If value ==
                                                     # default value bail.
        set oa [string range $o 1 end]
        switch -exact -- $o {
            -command {
                set r $v
                if {$v == ""} continue
                if {$v == "\{\}"} continue
                if {[string first xview $v] > -1} continue
                if {[string first yview $v] > -1} continue
                if {[string first "self." $v] == 0} {
                    # discard class functions
                    continue
                }
                # Remove any lambda present.
                set x [regexp {[ \#]*lambda.*:[ ]*(.*)} $v match v]
                # if {[string first "lambda:" $v] == 0} {
                #     # Remove the lambda part of the function name
                #     set index [string first ":" $v]
                #     set exp [expr $index + 1]
                #     set r [string range $v [expr $index + 1] end]
                # }
                # Remove leading "#" chars.
                while {[string first "#" $v] == 0} {
                    set v [string range $v 1 end]
                }
                # if {[string first "." $v ] == -1} {
                #     # Discard global functions not in the imported module
                #     set v [vTcl:prepend_import_name $v]
                # }
                lappend vTcl(support_function_list) [string trim $v]
            }
            -onvariable -
            -offvariable -
            -variable {
                if {[string first self. $v] == 0} continue
                #if {[string first . $v] == -1} continue
                # imported variable.
                set vTcl(imported_variable) 1
                set m StringVar
                lappend vTcl(support_variable_list) $v $m
            }
        }
    }
}

proc vTcl:python_inspect_bind {target} {
    # Look at bindings for module names.
    global vTcl
    set class [vTcl:get_class $target]
    set bindlist [lsort [bind $target]]
    foreach i $bindlist {
        if {$i == "<<SetBalloon>>"} continue
        set command [bind $target $i]
        set command [string trim $command]
        set v $command
                if {$v == ""} continue
                set r $v
                if {[string first xview $v] > -1} continue
                if {[string first yview $v] > -1} continue
                if {[string first "self." $v] == 0} {
                    # discard class functions
                    continue
                }
                if {[string first "." $v ] == 0} {
                    # Skip of weird binding put in place when
                    # TPanedwindow is created
                    continue
                }
                if {[string first "lambda" $v] == 0} {
                    # Remove the lambda part of the function name
                    set index [string first ":" $v]
                    set exp [expr $index + 1]
                    set r [string range $v [expr $index + 1] end]
                }
                lappend vTcl(support_function_list) [string trim $r]
    }
}

proc vTcl:save_support_file {} {
    # Generate support module filename and invoke vTcl:save_python_file
    # to save the file.
    global vTcl
    set filename "[file rootname $vTcl(project,file)]_support.py"
    if {[file exists $filename] && \
        $vTcl(supp_save_warning) != ""} {
        set reply [tk_dialog .foo "Save Question" \
      "The file $filename already exists, do you want to save support console?" \
                       question 1 "Yes" "No"]
        if {$reply == 1} {
            return
        } else {
            vTcl:save_python_file  $filename "supp"
        }
    } else {
        # Doesn't exist so save.
        vTcl:save_python_file  $filename "supp"
    }
}

proc debug_support_requirements {} {
    # Debugging routine listing requirements from scan_widgets.
    global vTcl
    dpr vTcl(support_variable_list)
    dpr vTcl(support_custom_list)
    dpr vTcl(rename_found)
    dpr vTcl(toplevel_create_statements_found)
    puts '\n'
}

proc debug_must_add_statements {} {
    global vTcl
    dpr vTcl(must_add_custom)
    dpr vTcl(must_add_procs)
    dpr vTcl(must_add_vars)
    dpr vTcl(must_add_toplevels)
}
