##############################################################################
# $Id: menu.tcl,v 1.19 2003/05/12 04:41:22 cgavin Exp $
#
# menu.tcl - library of main app menu items
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

# Rozen. This seems to define the system menus.
# The menu is actually created in page.tcl about line 415.

#     {{Save As With &Binary...} {}  vTcl:save_as_binary        }

#    {separator        {}           {}                         }
#    {Sou&rce...       {}           vTcl:file_source           }
#    {&Close           Ctrl+W       vTcl:close                 }

set vTcl(menu,file) {
    {&New...          Ctrl+N       vTcl:new                   }
    {{&Open as Project}   Ctrl+O       vTcl:open                  }
    {{Open as &Template}   Ctrl+T       vTcl:template         }
    {&Save            Ctrl+S       vTcl:save                  }
    {{Save &As...}    Ctrl+A       vTcl:save_as               }
    {&Borrow...       {Ctrl+B}     vTcl:borrow                }
    {separator        {}           {}                         }
    {@vTcl:initRcFileMenu}
    {@vTcl:initBcFileMenu}
    {separator        {}           {}                         }
    {&Preferences...  {}           {Window show .vTcl.prefs}  }

    {separator        {}           {}                         }
    {{Remove Autosave Files} {}    remove_autosave_files      }

    {separator        {}           {}                         }
    {&Quit            Ctrl+Q       vTcl:quit                  }
}

#    {@vTcl:initBcFileMenu}
#    {separator        {}           {}                         }
#    {&Images...       {}           vTcl:image:prompt_image_manager }
#    {&Fonts...        {}           vTcl:font:prompt_font_manager   }

set vTcl(menu,edit) {
    {Cu&t             Ctrl+X       vTcl:cut                   }
    {&Copy            Ctrl+C       vTcl:copy                  }
    {&Paste           Ctrl+V       vTcl:paste                 }
    {separator        {}           {}                         }
    {&Delete          {}        {vTcl:delete "" $vTcl(w,widget)} }
    {separator        {}           {}                         }
}
# Removed by Rozen  Later I may put some of them back.

    # {&Undo            {Ctrl+Z}     vTcl:pop_action            }
    # {&Redo            {}           vTcl:redo_action           }
    # {Cu&t             {}          vTcl:cut                   }
    # {&Copy            {}          vTcl:copy                  }
    # {&Paste           {}          vTcl:paste                 }

# I don't think I ever use this.
# set vTcl(menu,mode) {
#     {{&Test Mode}     Alt+T        {vTcl:setup_unbind_tree .} }
#     {{&Edit Mode}     Alt+E        {vTcl:setup_bind_tree .}   }
# }

set vTcl(menu,system) {
}

set vTcl(menu,user) {
}

set vTcl(menu,insert) {
    {{System}         {menu system} {} }
    {{User}           {menu user}   {} }
}

set vTcl(menu,compound) {
    {&Create...       Alt+C         {vTcl:name_compound $vTcl(w,widget)} }
    {Insert           {menu insert} {}                         }
    {separator        {}            {}                         }
    {{&Save Compounds...} {}        vTcl:save_compounds        }
    {{&Load Compounds...} {}        vTcl:load_compounds        }
    {separator        {}            {}                         }
    {{Save as &Tclet} {}            {vTcl:create_tclet $vTcl(w,widget)}  }
}

# I don't think we ever use this menu.
# set vTcl(menu,manager) {
#     {{+Place}          {}           {vTcl(w,def_mgr) place {vTcl:set_manager place}}}
#     {{+Pack}           {}           {vTcl(w,def_mgr) pack  {vTcl:set_manager pack}}}
#     {{+Grid}           {}           {vTcl(w,def_mgr) grid  {vTcl:set_manager grid}}}
# }

#     {{Manager}         {menu manager} {} }

#     {separator         {}           {}                         }
#     {&Hide             {}           vTcl:hide                  }


set vTcl(menu,options) {
    {{Set &Alias...}   Alt+A        {vTcl:set_alias $vTcl(w,widget)}}
    {separator         {}           {}                         }
    {{Select Pa&rent}  {Alt+P}      vTcl:select_parent         }
    {separator         {}           {}                         }
    {&Bindings         Alt+B        vTcl:show_bindings         }
    {{&Stash Config}   Alt+S        vTcl:stash_config          }
    {{&Remove All Multi Selections}   {Alt+D}   vTcl:remove_multi_selections}
}

#    {{Set &Insert}     Alt+I        vTcl:set_insert            }

#    {Project             {}        vTcl:project:show          }
#    {{Select &Toplevel} {}          vTcl:select_toplevel       }

#   Rozen. The Save Window Locations causes the preferences to be
#   saved and that includes saving the locations of where the user may
#   have moved or resized the various windows.
#   Again, I don't see much use in the 'system inspector.  Removed
#    {{System &Inspector}  {}         {Window show .vTcl.inspector} }
#   Ditto for the window list.
#    {{&Window List}       {}         {vTcl:toplist:show 1}      }
#   Getting rid of the console 2/19/14

#   No more Function window or Function Support Rozen 11/8/14
#    {{&Function List}     {}         {vTcl:proclist:show 1}     }
#    {separator            {}         {}                         }
#    {{&Window List}       {}         {vTcl:toplist:show 1}      }

#    {{Save &Default Window Locations and Quit} {}     vTcl:save_current     }

#    {{Bind Editor}        {}         vTcl:show_bind             }
#    {{Menu Editor}        {}         vTcl:show_menu             }


#    {{Callback}           {}         vTcl:show_callback         }
#    {{Apply}              {}         vTcl:show_apply            }
set vTcl(menu,window) {
    {{Toplevel}           {}         vTcl:return_top            }
    {{Main}               {}         vTcl:show_main             }
    {{Attribute Editor}   {}         vTcl:show_propmgr          }
    {{Tool Bar}           {}         vTcl:show_toolbar          }
    {{Widget &Tree}       {}         vTcl:show_wtree            }
    {separator            {}         {}                         }
    {{&Save Current Window Locations} {}     vTcl:save_prefs    }
    {{Save Widget Tree  } Alt+F      vTcl:save_wtree            }
    {{Show All Callbacks } Alt+C      vTcl:show_all_callbacks   }
}

## this menu is built dynamically
set vTcl(menu,widget) {}

set vTcl(menu,help) {
    {{&About PAGE ...} {}         {Window show .vTcl.about}      }
    {{&Open Help ...} {}         {vTcl:open_help_in_browser}      }

}

#    {{&Libraries...}        {}         {Window show .vTcl.infolibs}   }
#    {{Index of &Help...}    {}         {Window show .vTcl.help}       }
#    {separator              {}         {}                         }
#    {{&Tip of the day...}   {}         {Window show .vTcl.tip}    }
#    {{Visual Tcl &News}     {}         {::vTcl::news::get_news}   }

# Rozen
set vTcl(menu,gen_Python) {
    {{Generate Python GUI}      Ctrl+P    vTcl:generate_python_UI   }
    {{Generate Support Module}  Ctrl+U    vTcl:generate_python_support   }
    {{Load PAGE Consoles}       Ctrl+L     vTcl:load_python_consoles   }
    {{Load Project into IDE}    Ctrl+I     vTcl:load_python_idle   }
}


proc vTcl:menu:insert {menu name {root ""}} {
    global vTcl tcl_version
    if {$tcl_version >= 8} then {
        set tab ""
    } else {
        set tab "\t"
    }
    if {$root != ""} then {
        if {![winfo exists $root]} then {
            menu $root
        }
        $root add cascade -label [vTcl:upper_first $name] -menu $menu
    }
    menu $menu -tearoff 0
    set vTcl(menu,$name,m) $menu
    foreach item $vTcl(menu,$name) {
        set txt [lindex $item 0]
        set acc [lindex $item 1]
        if {[llength $acc] > 1} then {
            vTcl:menu:insert $menu.[lindex $acc 1] [lindex $acc 1] $menu
        } else {
            set cmd [lindex $item 2]
            if {$txt == "separator"} then {
                $menu add separator
            } elseif {[string index $txt 0] == "@"} {
                eval [string range $item 1 end]
            } elseif {[string index $txt 0] == "+"} {
                $menu add radiobutton -label \
                    [string range $txt 1 end]$tab -accel $acc \
                    -variable [lindex $cmd 0] -value [lindex $cmd 1] \
                    -command [lindex $cmd 2]
                set vTcl(menu,$name,widget) $menu
            } else {
                set ampersand [string first & $txt]
                if {$ampersand != -1} then {
                    regsub -all & $txt "" txt
                    $menu add command -label $txt$tab -accel $acc -command $cmd \
                        -underline $ampersand
                } else {
                    $menu add command -label $txt$tab -accel $acc -command $cmd
                }
                set vTcl(menu,$name,widget) $menu
            }
        }
    }
}

# Rcfiles is the list of recently opened files.
proc vTcl:initRcFileMenu {} {
    global vTcl
    if {[info tclversion] >= 8} then {
        set base .vTcl.m.file
    } else {
        set base $vTcl(gui,main).menu
    }
    set w [menu $base.projects -tearoff 0]
    $base add cascade -label "Recent Files" -menu $w
    vTcl:updateRcFileMenu
}

proc vTcl:addRcFile {file} {
    global vTcl
    if {[file pathtype $file] != "absolute"} then {
        set file [file join [pwd] $file]
    }
    ::vTcl::lremove vTcl(rcFiles) $file
    set vTcl(rcFiles) [linsert $vTcl(rcFiles) 0 $file]
    vTcl:updateRcFileMenu
}

proc vTcl:updateRcFileMenu {} {
    global vTcl
    if {![info exists vTcl(rcFiles)]} { set vTcl(rcFiles) {} }
    ## Remove duplicate entries in the file list.
    ## set vTcl(rcFiles) [vTcl:lrmdups $vTcl(rcFiles)]
    if {[info tclversion] >= 8} {
        set w .vTcl.m.file.projects
    } else {
        set w $vTcl(gui,main).menu.projects
    }
    $w delete 0 end
    foreach file $vTcl(rcFiles) {
        if {[file exists $file]} { continue }
        ::vTcl::lremove vTcl(rcFiles) $file
    }
    ##
    # Trim down the number of files to the specified amount.
    ##
    set vTcl(rcFiles) [lrange $vTcl(rcFiles) 0 [expr $vTcl(numRcFiles) - 1]]
    set i 1
    foreach file $vTcl(rcFiles) {
        $w insert end command \
            -label "$i $file" \
            -command "vTcl:open [list $file]" \
            -underline 0
        incr i
    }
}

# bcfiles is the list of recently opened files for
# borrowing. Essentially like the above code for rcfiles.
proc vTcl:initBcFileMenu {} {
    global vTcl
    if {[info tclversion] >= 8} then {
        set base .vTcl.m.file
    } else {
        set base $vTcl(gui,main).menu
    }
    set w [menu $base.borrow -tearoff 0]
    $base add cascade -label "Borrowed Files" -menu $w
    vTcl:updateBcFileMenu
}

proc vTcl:addBcFile {file} {
    global vTcl
    if {[file pathtype $file] != "absolute"} then {
        set file [file join [pwd] $file]
    }
    ::vTcl::lremove vTcl(bcFiles) $file
    set vTcl(bcFiles) [linsert $vTcl(bcFiles) 0 $file]
    vTcl:updateBcFileMenu
}

proc vTcl:updateBcFileMenu {} {
    global vTcl
    if {![info exists vTcl(bcFiles)]} { set vTcl(bcFiles) {} }
    ## Remove duplicate entries in the file list.
    ## set vTcl(bcFiles) [vTcl:lrmdups $vTcl(bcFiles)]
    set w .vTcl.m.file.borrow
    $w delete 0 end
    foreach file $vTcl(bcFiles) {
        if {[file exists $file]} { continue }
        ::vTcl::lremove vTcl(bcFiles) $file
    }
    ##
    # Trim down the number of files to the specified amount.
    ##
    set vTcl(bcFiles) [lrange $vTcl(bcFiles) 0 [expr $vTcl(numBcFiles) - 1]]
    set i 1
    foreach file $vTcl(bcFiles) {
        $w insert end command \
            -label "$i $file" \
            -command "vTcl:borrow [list $file]" \
            -underline 0
        incr i
    }
}

proc vTcl:enable_entries {menu state} {
    set last [$menu index end]
    if {$last == "none"} return
    for {set i 0} {$i <= $last} {incr i} {
        $menu entryconfigure $i -state $state
    }
}

# Not used because I have not found out how to identify the window or
# what the default is.
# proc vTcl:show_bind {} {
#     global vTcl
#     Window show .vTcl.tree
#     wm geometry .vTcl.tree $vTcl(default,.vTcl.tree)
#     vTcl:init_wtree
# }

# proc vTcl:show_menu {} {
#     global vTcl
#     Window show .vTcl.tree
#     wm geometry .vTcl.tree $vTcl(default,.vTcl.tree)
#     vTcl:init_wtree
# }




