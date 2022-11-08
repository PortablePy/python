 #! /usr/bin/env sh
# -*-Tcl-*-
# the next line restarts using wish\
#exec wish "$0" ${1+"$@"}
# $Id: vtcl.tcl,v 1.49 2006/07/28 13:43:55 unixabg Exp $

##############################################################################
#
# Visual TCL - A cross-platform application development environment
#
# Copyright (C) 1996-1998 Stewart Allen, 2020-2021 Donald Rozenberg
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

# vTcl:main
# vTcl:setup_meta
# vTcl:setup_gui                  where we initiaite stuff like fonts
# vTcl:new_toplevel_widget
# vTcl:expand_file_name
# vTcl:define_rc_menus
# vTclWindow.vTcl
# autosave

# Menu editing call is to vTcl:edit_target_menu
# Menu editor created by vTclWindow.vTclMenuEdit in menus.tcl.
# Attribute editing for menus is in misc.tcl.


## for Tcl/Tk 8.4
## It also seems needed for later versions. Rozen Removed 1/4/21
# if {![llength [info commands tkTextInsert]]} {
#     ::tk::unsupported::ExposePrivateCommand tkTextInsert
# }
  # New version which doesn't use 'catch', to avoid
  # generating a long stack trace every time the window doesn't
  # have a current selection
  proc tkTextInsert {w s} {
      if {[string equal $s ""] || [string equal [$w cget -state] "disabled"]} {
          return
      }
      if {[llength [$w tag ranges sel]]} {
          if {[$w compare sel.first <= insert] \
                  && [$w compare sel.last >= insert]} {
              $w delete sel.first sel.last
          }
      }
      $w insert insert $s
      $w see insert
  }


namespace eval ::vTcl {}

set vTcl(sourcing) 0

proc vTcl:log {msg} {
    return
    global vTcl tcl_platform

    if {![info exists vTcl(LOG_FD_W)]} {
    ## If we can't open the log files in HOME, try in the vTcl directory.
    if {[catch {open $vTcl(LOG_FILE) "w"} vTcl(LOG_FD_W)] \
        || [catch {open $vTcl(LOG_FILE) "r"} vTcl(LOG_FD_R)]} {
        vTcl:error "Cannot open vTcl log file."
        vTcl:exit
    }
    catch {fconfigure $vTcl(LOG_FD_R) -buffering line}
    }
    puts $vTcl(LOG_FD_W) "$msg"
    flush $vTcl(LOG_FD_W)
    # tkcon_puts $msg
}

proc vTcl:splash_status {string {nodots {}}} {
    global statusMsg
    if {$nodots == {}} { append string ... }
    set statusMsg $string
    update
}

proc vTcl:splash {} {
    global vTcl
    toplevel .x -relief groove
    wm withdraw .x
    set sw [winfo screenwidth .]
    set sh [winfo screenheight .]
    image create photo "title" \
        -file [file join $vTcl(VTCL_HOME) images page_splash.png]
    wm overrideredirect .x 1
    label .x.l -image title -bd 1 -relief sunken -background black
    pack .x.l -side top -expand 1 -fill both
    entry .x.status -relief flat -background black -foreground white \
        -textvar statusMsg -font "Helvetica 12"
    pack .x.status -side bottom -expand 1 -fill both
    set x [expr {($sw - 200)/2}]
    set y [expr {($sh - 250)/2}]
    wm geometry .x +$x+$y
    wm deiconify .x
    update idletasks
    # The following removes the splash screen. Moved to bottom of main
    # proc so that I can create the toplevel with the correct widget
    # tree.
    # after 2000 {catch {destroy .x}}

}

proc vTcl:load_lib {lib} {
    global vTcl
    vTcl:splash_status "Loading library [file tail $lib]"

    set file [file join $vTcl(LIB_DIR) $lib]

    if {[file exists $file] == 0} {
        vTcl:log "Missing Libary: $lib"
        return 0
    } else {
        uplevel #0 [list source $file]
        return 1
    }
}

proc vTcl:load_widgets {} {
    global vTcl
    global tcl_platform

    vTcl:splash_status "Loading widgets"

    ## Query for the list of libs to load. Either from prefs or defaults
    ## to all available libraries.
    ## Make sure lib_core loads before all other widget libraries.
    set toload [list lib_core.tcl lib_ttk.tcl lib_scrolled.tcl]
    foreach i $toload {
        set lib [lindex [split [file root $i] _] end]
        if {[vTcl:load_lib $i]} {
            set libname [lindex [split [lindex [file split $i] end] .] 0]
            ## If we don't have the library, don't load the widgets for it.
            if {![vTcl:$libname:init]} { continue }
            lappend vTcl(w,libs) $libname
            vTcl:LoadWidgets [file join $vTcl(VTCL_HOME) lib Widgets $lib]
        }
    }
}

proc vTcl:load_libs {libs} {
    global vTcl
    foreach i $libs {
        vTcl:load_lib $i
    }
}

proc ::vTcl::load_bwidgets {} {
    vTcl:splash_status "Loading BWidgets"

    uplevel #0 {
        set dir [file join $vTcl(LIB_DIR) bwidget]
        source  [file join $dir pkgIndex.tcl]
    }

}

proc vTcl:get_home_dir { } {
    global env tcl_platform
    # Check if we're using windows
    if {$tcl_platform(platform) eq "windows" } {
        if {[info exists env(HOME)]} {
            return $env(HOME)
        } else {
            return ${env(HOMEDRIVE)}${env(HOMEPATH)}
        }
    } else {
        return $env(HOME)
    }
}

proc vTcl:setup {} {
    global tk_strictMotif env vTcl tcl_platform __vtlog
    global tcl_version
    global vTcl
    #### "Steffen" added at 2019-04-13 #####################
    encoding system utf-8   ; # enforcing to use UTF-8 default on _every_ OS
    ## Linux   - the textfile encoding stays at the Linux standard: UTF-8
    ## Windows - the encoding _changes_ (from "ANSII") to UTF-8
    ##   Note: Python files are allowed to be UTF-8 only !
    ########################################################
    set version_file [file join $vTcl(VTCL_HOME) version]
    source $version_file
    set vTcl(tcl_version) $tcl_version
    set home_dir [vTcl:get_home_dir]
    if {$vTcl(select_profile)} {

        set title "Select rc file"
        set vTcl(file,mode) "Profile"
        set types {
            {{rc files}   {*rc}}
            {{All}       {*} }
            }
            set title "Select profile"
        set initname ".pagerc"
        set file [tk_getOpenFile -title $title -initialfile $initname \
                          -initialdir $home_dir -filetypes $types]

        if {$file == ""} {
            set vTcl(select_profile) 0
        } else {
            set vTcl(CONF_FILE) $file
        }
    } elseif [regexp {^\.+\/} $vTcl(profile)] {
        set vTcl(CONF_FILE) $vTcl(profile)

    } else {
            # Rozen changed file names. This is the path most taken.
            #set vTcl(CONF_FILE) [file join $env(HOME) .pagerc]
            set vTcl(CONF_FILE) [file join $home_dir $vTcl(profile)]
            #set vTcl(LIB_FILE)  [file join $home_dir .pagelibs]
            #set vTcl(LOG_FILE)  [file join $home_dir .pagelog]
    }
    set vTcl(LIB_DIR)   [file join $vTcl(VTCL_HOME) lib]
    set  vTcl(LIB_WIDG) []
    #set vTcl(LIB_WIDG)  [glob -nocomplain [file join $vTcl(LIB_DIR) lib_*.tcl]]
    set LIBS            "globals.tcl about.tcl propmgr.tcl balloon.tcl
             bgerror.tcl bind.tcl command.tcl color.tcl
             compound.tcl do.tcl dragsize.tcl dump.tcl edit.tcl file.tcl
             handle.tcl input.tcl loadwidg.tcl font.tcl images.tcl menu.tcl
             misc.tcl name.tcl prefs.tcl tops.tcl tree.tcl vtclib.tcl
             widget.tcl menus.tcl toolbar.tcl gui_python_gen.tcl
             support_python_gen.tcl color_array.tcl colorDlg.tcl close_color.tcl
             choosefont.tcl lib_core.tcl lib_scrolled.tcl lib_ttk.tcl
             relative_path.tcl callback.tcl apply.tcl tooltip.tcl template.tcl
             convert.tcl multiselect.tcl busy_cursor.tcl undo.tcl msgbox.tcl
             tkfbox.tcl dialog.tcl"

             # clrpick.tcl" sun_valley.tcl Removed from above
             # tclet.tcl attrbar.tcl proc.tcl var.tcl compounds.tcl

    # Removed from above new.tcl, help.tcl, ttd/ttd.tcl, and
    # tkcon.tcl. Added modified versions of msgbox.tcl, tkfbox.tcl,
    # and dialog.tcl to handle dark mode for file dialogues and
    # messages. Original versions of msgbox.tcl, tkfbox.tcl, and
    # dialog.tcl were purloined from the 8.6.10 version of the tcl/tk
    # source.

    # UKo 2000-12-10: initiate some variables
    set vTcl(libs)      {}
    set vTcl(classes)   {}
    set vTcl(options)   {}
    #set tk_strictMotif    1
    wm withdraw .
    vTcl:splash
    #::vTcl::load_bwidget
    #for scrolled Bands widget
    source [ file join $vTcl(LIB_DIR) kpwidgets sbands.tcl ]
    namespace import kpwidgets::*
    vTcl:load_libs $LIBS
    ## load preference or rc file, it may be pagerc.
    if {$vTcl(skip_profile) == 0} {
        if {[file exists $vTcl(CONF_FILE)]} {
            catch {uplevel #0 [list source $vTcl(CONF_FILE)]
                vTcl:update_tabbed_variables}
            catch {set vTcl(w,def_mgr) $vTcl(pr,manager)}
        }
    }
    if {$vTcl(pr,relative_placement) == 1} {
        set vTcl(mode) "Relative"
       } else {
        set vTcl(mode) "Absolute"
    }
    # See if we have to play dual monitor games.
    vTcl:check_geometry   ;# In misc.tcl
    vTcl:load_widgets
    ::vTcl::load_bwidgets
    # initializes the stock images database
    vTcl:image:init_stock
    # initializes the stock fonts database
    set fonts [font names]
    vTcl:font:init_stock
    set fonts [font names]
    # Set Actual Colors and Actual Fonts. (In color.tcl)
    vTcl:set_actuals
    # initializes the project
    vTcl::project::initModule main
    # make sure TkCon doesn't see command line arguments here
    set argc $::argc
    set argv $::argv
    set ::argc 0
    set ::argv {}
    vTcl:setup_gui
    set ::argc $argc
    set ::argv $argv
    update idletasks
    set vTcl(start,procs)   [lsort [info procs]]
    set vTcl(start,globals) [lsort [info globals]]
    vTcl:setup_meta
}

proc vTcl:setup_meta {} {
    global vTcl tcl_platform
return
    proc exit {args} {}
    proc init {argc argv} {}
    proc main {argc argv} {}

    #vTcl:proclist:show $vTcl(pr,show_func)
    #vTcl:toplist:show  $vTcl(pr,show_top)
}

proc vTcl:setup_gui {} {
    global vTcl tcl_platform tk_version
    rename exit vTcl:exit
    vTcl:splash_status "Setting Up Workspace"
    ## We use our own version of Bwidgets with some bug fixes. Will
    ## submit them the bugs when time permits.
    package require BWidget
    if {$tcl_platform(platform) == "macintosh"} {
        set vTcl(pr,balloon) 0
        set vTcl(balloon,on) 0
    }
    # At this point define the fonts to be used.
    # First associate font with font description for simple case.
    foreach f [list TkDefaultFont TkTextFont TkFixedFont TkMenuFont] {
        set vTcl(font,f) $f
    }
    if {[string index $vTcl(pr,font_dft) 0] != T} {
        # Case where $vTcl(pr,font_dft) is not one of the default
        # fonts. I create the font and remember its name.
        font create font_dft {*}$vTcl(pr,font_dft)
        set vTcl(font,$vTcl(pr,font_dft)) font_dft
    }
    if {$tcl_platform(platform) == "unix"} {
        option add *vTcl*Scrollbar.width 10
        option add *vTcl*Scrollbar.highlightThickness 0
        option add *vTcl*Scrollbar.elementBorderWidth 2
        option add *vTcl*Scrollbar.borderWidth 2
        option add *Scrollbar.width 10
        option add *vTcl*font {Helvetica 12}
        option add *vTcl*font $vTcl(pr,font_dft)
        option add *ScrolledWindow.size 14
    }
    if {$tcl_platform(platform) == "windows"} {
        option add *Button.padY 0
    }
    if {$vTcl(pr,bgcolor) == ""} {set vTcl(pr,bgcolor) $vTcl(tk_default_bgcolor)}
    if {$vTcl(pr,fgcolor) == ""} {set vTcl(pr,fgcolor) "Black"}
    option add *vTcl*font $vTcl(pr,font_dft)
    option add *vTcl*Text*font $vTcl(pr,font_fixed)
    option add *NoteBook.font $vTcl(pr,font_dft)
    option add *vTcl*foreground $vTcl(pr,fgcolor)
    option add *__tk__messagebox*font $vTcl(pr,font_dft)
    #option add *__tk__messagebox*background #d9d9d9
    #option add *__tk__messagebox* #d9d9d9
    if {[info exists vTcl(pr,bgcolor)] && ![lempty $vTcl(pr,bgcolor)]} {
        ## On some systems, the . window has an empty {} background option,
        ## and this makes the tk_setPalette code fail
        . configure -background gray
        tk_setPalette $vTcl(pr,bgcolor)
        option add *vTcl*background $vTcl(pr,bgcolor)
    }

    option add *vTcl*Entry.background $vTcl(pr,entrybgcolor)
    option add *vTcl*Entry.background #d9d9d9
    option add *vTcl*Entry.foreground $vTcl(pr,fgcolor)
    # option add *vTcl*Listbox.background $vTcl(pr,listboxbgcolor)
    option add *vTcl*Listbox.background $vTcl(area_bg) ;# NEEDS WORK dark
    option add *vTcl*Text.background $vTcl(area_bg) ;# NEEDS WORK dark
    option add *vTcl*Listbox.foreground black

    option add *vTcl*Button*activebackground "#f4bcb2"

    #option add *selectBackground blue
    #option add *selectForeground white

    set vTcl(dark) [::colorDlg::dark_color $vTcl(actual_bg)] ;# NEEDS WORK dark

    vTcl:setup_bind_tree .
    vTcl:load_images           ;# in misc.tcl
    # Rozen Window is a proc in vtclib.tcl. Next line brings up main window.
    Window show .vTcl
    foreach l $vTcl(w,libs) {  ;# This appears to load the toolbar.
        vTcl:widget:lib:$l
    }
    vTcl:config_toolbar_canvas
    vTcl:toolbar_reflow
    foreach i $vTcl(startup_windows) {
        # vTcl(startup_windows) is set in global.tcl
        Window show $i    ;# Window is in vtcllib.tcl
    }
    vTcl:clear_wtree
    vTcl:define_bindings
    vTcl:cmp_sys_menu
    vTcl:define_rc_menus
    raise .vTcl
}

proc vTcl:define_rc_menus {} {
    global vTcl
    # RIGHT CLICK MENU
    set vTcl(gui,rc_menu) .vTcl.menu_rc
    menu $vTcl(gui,rc_menu) -tearoff 0
    set vTcl(gui,rc_widget_menu) .vTcl.menu_rc.widgets
    # Commands added to rc_menu by vTcl:add_functions_to_rc_menu in widget.tcl.
    menu $vTcl(gui,rc_widget_menu) -tearoff 0
    $vTcl(gui,rc_menu) add cascade -label "Widget" \
    -menu $vTcl(gui,rc_widget_menu)
    $vTcl(gui,rc_menu) add command -label "Set Alias..." -command {
        vTcl:set_alias $vTcl(w,widget)
    }
    $vTcl(gui,rc_menu) add separator
    $vTcl(gui,rc_menu) add command -label "Select Toplevel" -command {
        vTcl:select_toplevel
    }
    $vTcl(gui,rc_menu) add command -label "Select Parent" -command {
        vTcl:select_parent
    }
    $vTcl(gui,rc_menu) add separator

    # Rozen deleted pending a bit of debuging.
    $vTcl(gui,rc_menu) add comm -label "Cut" -command {
        vTcl:cut
     }
    $vTcl(gui,rc_menu) add comm -label "Copy" -command {
        vTcl:copy
    }
    $vTcl(gui,rc_menu) add comm -label "Paste" -command {
        vTcl:paste -mouse
    }
    $vTcl(gui,rc_menu) add comm -label "Delete" -command {
        vTcl:delete "" $vTcl(w,widget)
    }

    $vTcl(gui,rc_menu) add separator
    $vTcl(gui,rc_menu) add command -label "Bindings..." -command {
        vTcl:show_bindings
    }
    $vTcl(gui,rc_menu) add command -label "Callbacks..." -command {
        vTcl:show_callbacks   ;# Added May 2018
    }
    $vTcl(gui,rc_menu) add separator
    $vTcl(gui,rc_menu) add command -label "Lock Widget"  -command {
        vTcl:lock_widget   ;# Added August 2018
    }
    $vTcl(gui,rc_menu) add command -label "Unlock Widget" -command {
        vTcl:unlock_widget   ;# Added October 2018
    }
    # Stash and Apply entries
    $vTcl(gui,rc_menu) add separator
    $vTcl(gui,rc_menu) add command -label "Stash Config"  -command {
        vTcl:stash_config   ;# Added October 2018
    }
    # $vTcl(gui,rc_menu) add command -label "Apply Config" -command {
    #     vTcl:apply_config   ;# Added October 2018
    # }
    $vTcl(gui,rc_menu) add separator  ;# Rozen
    # Rozen. I want to be able to close the menu with nothing happening.
    $vTcl(gui,rc_menu) add command -label "Close Menu" -command {
        vTcl:show_selection_in_tree $vTcl(w,widget)
        vTcl:multi_destroy_handles
        vTcl:replace_all_multi_handles
    }

    # Right click multi menu.
    set vTcl(gui,rc_multi_menu) .vTcl.multi_menu_rc
    menu $vTcl(gui,rc_multi_menu) -tearoff 0
    # Remove All Multi Selections
    $vTcl(gui,rc_multi_menu) add command -label "Remove All Multi Selections" \
         -command {vTcl:remove_multi_selections
    }
    # Remove One Multi Selection
    $vTcl(gui,rc_multi_menu) add command -label "Remove One Multi Selection" \
         -command {vTcl:drop_multi_target $vTcl(multi_select_widget)
    }
    # Align Horizontal
    $vTcl(gui,rc_multi_menu) add separator
    $vTcl(gui,rc_multi_menu) add command -label "Align Horizontal" -command {
        vTcl:align_horizontal   ;# Added October 2018
    }
    # Align Vertial
    $vTcl(gui,rc_multi_menu) add command -label "Align Vertial" -command {
        vTcl:align_vertical   ;# Added October 2018
    }
    # Spread Horizontal
    $vTcl(gui,rc_multi_menu) add separator
    $vTcl(gui,rc_multi_menu) add comm -label "Spread Horizontal" -command {
        vTcl:spread_horizontal
    }
    # Spread Vertical
    $vTcl(gui,rc_multi_menu) add comm -label "Spread Vertical" -command {
        vTcl:spread_vertical
    }
    # Center Horizontal
    $vTcl(gui,rc_multi_menu) add separator
    $vTcl(gui,rc_multi_menu) add comm -label "Center Horizontal" -command {
        vTcl:center_horizontal
    }
    # Center Vertical
    $vTcl(gui,rc_multi_menu) add comm -label "Center Vertical" -command {
        vTcl:center_vertical
    }
    # Undo Multilevel
    $vTcl(gui,rc_multi_menu) add separator  ;# Rozen
    $vTcl(gui,rc_multi_menu) add command -label "Undo" -command {
        vTcl:undo_multi
    }
    # Rozen. I want to be able to close the menu with nothing happening.
    $vTcl(gui,rc_multi_menu) add separator  ;# Rozen
    $vTcl(gui,rc_multi_menu) add command -label "Close Menu" -command {
        vTcl:show_selection_in_tree $vTcl(w,widget)
        vTcl:multi_destroy_handles
        vTcl:replace_all_multi_handles
    }
}

proc vTclWindow.vTcl {args} {
    global vTcl tcl_platform tcl_version
    if {[winfo exists .vTcl]} {return}
    vTcl:image:create_new_image "images/page48.png" {} user {} icon
    toplevel $vTcl(gui,main)
    # wm title $vTcl(gui,main) "PAGE"  ;# Rozen
    wm title .vTcl "PAGE - $vTcl(project,name)"
    wm resizable $vTcl(gui,main) 0 0
    wm group $vTcl(gui,main) $vTcl(gui,main)
    wm command $vTcl(gui,main) "$vTcl(VTCL_HOME)/page"
    wm iconname $vTcl(gui,main) "PAGE"   ;# Rozen
    #    wm iconphoto $vTcl(gui,main) icon
    #if {$tcl_platform(platform) == "unix"} {
    #    wm iconphoto $vTcl(gui,main) icon
    #}
    if {$tcl_platform(platform) == "macintosh"} {
        wm geometry $vTcl(gui,main) +0+20
    } else {
         wm geometry $vTcl(gui,main) +0+0
    }
    catch { ;# Rozen removed the following statement so that I could
             # control the size from the stuff in the prefs.  regsub
             # -all {[0-9]+x[0-9]+} $vTcl(geometry,.vTcl) "" \
             # vTcl(geometry,.vTcl)

        wm geometry .vTcl $vTcl(geometry,.vTcl)
    }
    wm protocol .vTcl WM_DELETE_WINDOW {vTcl:quit}
    set tmp $vTcl(gui,main).menu
    frame $tmp -relief flat
    frame .vTcl.stat -relief flat
    pack $tmp -side top -expand 1 -fill x

    .vTcl conf -menu .vTcl.m -relief groove

    # Changed by Rozen mode and compound do not have meaning for Page
    # but gen_Python definitely does.  Perhaps I do want to use the
    # compound stuff.
    foreach menu {file edit options window widget gen_Python help} {
        if {$tcl_version >= 8} {
            vTcl:menu:insert .vTcl.m.$menu $menu .vTcl.m
        #} else {
        #    menubutton $tmp.$menu -text [vTcl:upper_first $menu] \
        #        -menu $tmp.$menu.m -anchor w
        #    vTcl:menu:insert $tmp.$menu.m $menu
        #    pack $tmp.$menu -side left
        #}
    }
    # Rozen. The help isn't worth crap anyway.
    #vTcl:menu:insert .vTcl.m.help help .vTcl.m

    # STATUS AREA
    label .vTcl.stat.sl \
        -relief groove -bd 2 -text "Status" -anchor w -width 35 \
            -textvariable vTcl(status)
    # Label below is the Absolute-Relative spot.
    label .vTcl.stat.mo \
        -relief groove -bd 2 -textvariable vTcl(mode) -width 10 -height 2
    bind .vTcl.stat.mo <Button-1> {
        %W configure -relief sunken
    }
    bind .vTcl.stat.mo <ButtonRelease-1> {
        if {[%W cget -relief] == "sunken"} {
            vTcl:convert_project
        }
        %W configure -relief groove
    }
    vTcl:set_balloon .vTcl.stat.mo "Convert Relative<->Absolute."
    frame .vTcl.stat.f -relief sunken -bd 1 -width 150 -height 15
    frame .vTcl.stat.f.bar -relief raised -bd 1 -bg #ff4444 ;# status prog bar
    pack .vTcl.stat.sl -side left -expand 1 -fill both
    pack .vTcl.stat.mo -side left -padx 2
    pack .vTcl.stat.f  -side left -padx 2 -fill y
        # New Stuff for convert
        #button .vTcl.stat.cb -text "convert" -bg red
        #pack .vTcl.stat.cb -side
    pack .vTcl.stat -side top -fill both
    vTcl:setup_vTcl:bind .vTcl
    ## Create a hidden entry widget that holds the name of the current widget.
    ## We use this for copying the widget name and using it globally.
    entry .vTcl.widgetname -textvariable vTcl(w,widget)
    ## Make the menu flat
    .vTcl.m configure -relief flat
}

proc vTcl:show_main {} {
    # Called from Main menu -> Window -> Main. Puts main window in
    # default position
    global vTcl
    vTclWindow.vTcl
    wm geometry .vTcl $vTcl(default,.vTcl)
}

proc vTcl:return_top {} {
    # Called from Main menu -> Window -> Toplevel. Puts toplevel window in
    # default position.
    global vTcl
    set top $vTcl(tops)
    foreach {w h x y} [split [winfo geometry $top] "x+"] {}
    set x_1 [ expr {([ winfo screenwidth  $top ] - $w ) / 2 }]
    set y_1 [ expr {([ winfo screenheight $top ] - $h ) / 3 }]
    #set vTcl(geom_center) ${w}x${h}+$x_1+$y_1
    set vTcl(default_coordinates) "+$x_1+$y_1"

    wm geometry $vTcl(tops) $vTcl(default_coordinates)
    incr vTcl(change)
}

proc vTcl:vtcl:remap {w} {
    global vTcl

    if {![vTcl:streq $w ".vTcl"]} { return }
    if {![info exists vTcl(tops,unmapped)]} { return }

    foreach i $vTcl(tops,unmapped) {
        if {![winfo exists $i]} { continue }

        vTcl:show_top $i
    }

    wm deiconify .vTcl.toolbar
    set vTcl(tops,unmapped) ""
}

proc vTcl:vtcl:unmap {w} {
    global vTcl

    if {![vTcl:streq $w ".vTcl"]} { return }
    if {[vTcl:streq [wm state $w] "normal"]} { return }

    set vTcl(tops,unmapped) ""

    foreach i $vTcl(tops) {
    if {![winfo exists $i]} { continue }
        if {[wm state $i] != "withdrawn"} {
            vTcl:hide_top $i
            lappend vTcl(tops,unmapped) $i
        }
    }
}


proc vTcl:define_bindings {} {
    global vTcl
    vTcl:status "creating bindings"
    foreach i {a b} {
        #bind vTcl($i) <Control-z>  { vTcl:pop_action }
        bind vTcl($i) <Control-z>  { vTcl:undo_multi }
        #bind vTcl($i) <Control-r>  { vTcl:redo_action }
        bind vTcl($i) <Control-x>  { vTcl:cut %W }
        bind vTcl($i) <Control-c>  { vTcl:copy %W }
        bind vTcl($i) <Control-v>  { vTcl:paste {} %W }
        bind vTcl($i) <Control-q>  { vTcl:quit }
        #bind vTcl($i) <Control-n>  { vTcl:new }
        bind vTcl($i) <Control-o>  { vTcl:open }
        bind vTcl($i) <Control-s>  { vTcl:save }
        #bind vTcl($i) <Control-w>  { vTcl:close %W}  ;# Rozen 10/24/18
        bind vTcl($i) <Control-a>  { vTcl:save_as }
        bind vTcl($i) <Control-b>  { vTcl:borrow }
        #bind vTcl($i) <Control-t>  { vTcl:template }

        #bind vTcl($i) <Control-h>  { vTcl:hide }     ;# Rozen
        bind vTcl($i) <Control-p>  { vTcl:generate_python_UI }  ;# Rozen
        bind vTcl($i) <Control-u>  { vTcl:generate_python_support }  ;# Rozen
        bind vTcl($i) <Control-i>  { vTcl:load_python_idle } ;# Rozen
        bind vTcl($i) <Control-l>  { vTcl:load_python_consoles } ;# Rozen

        #bind vTcl($i) <Key-Delete> { vTcl:delete %W $vTcl(w,widget) }
        bind vTcl($i) <Alt-a>      { vTcl:set_alias $vTcl(w,widget) }
        #bind vTcl($i) <Alt-f>      { vTcl:proclist:show flip }
        #bind vTcl($i) <Alt-o>      { vTcl:toplist:show flip }
        #bind vTcl($i) <Alt-t>      { vTcl:setup_unbind_tree . }
        #bind vTcl($i) <Alt-e>      { vTcl:setup_bind_tree . }
        bind vTcl($i) <Alt-b>      { vTcl:show_bindings }
        bind vTcl($i) <Alt-w>      { vTcl:show_wtree }
        #bind vTcl($i) <Alt-c>      { vTcl:name_compound $vTcl(w,widget) }
        bind vTcl($i) <Alt-c>      { vTcl:show_all_callbacks }
        bind vTcl($i) <Alt-f>      { vTcl:save_wtree }
        bind vTcl($i) <Alt-p>      { vTcl:select_parent }
        bind vTcl($i) <Alt-s>      { vTcl:stash_config }
        bind vTcl($i) <Alt-d>      { vTcl:remove_multi_selections }
        #bind vTcl($i) <Alt-o>      { vTcl:drop_multi_target %W}
    }

    bind vTcl(c) <Configure>  {
        if {$vTcl(w,widget) == "%W"} {
            vTcl:update_widget_info %W
        }

        after idle "vTcl:place_handles \"$vTcl(w,widget)\""
    }

    bind Text <Control-Key-c> {tk_textCopy %W}
    bind Text <Control-Key-x> {tk_textCut %W}
    bind Text <Control-Key-v> {tk_textPaste %W}
    bind Text <Key-Tab>       {
        tkTextInsert %W $vTcl(tab)
        focus %W
        break
    }
    #
    # handles auto-indent and syntax coloring
    #
    bind Text <Key-Return>    {

        # exclude user inserted text widgets from vTcl bindings
        if {(! [string match .vTcl* %W]) ||
            [info exists %W.nosyntax] } {
            tkTextInsert %W "\n"
            focus %W
            break
        }

        vTcl:syntax_color %W
        set pos [%W index "insert linestart"]
        # change by Nelson 3.9.2003: better auto indent
        set nos [%W search -regexp "\[^#\ \]|$" $pos]
        # set nos [%W search -regexp -nocase "\[a-z0-9\]" $pos]
        if {$nos != ""} {
            set ct [%W get $pos $nos]
            tkTextInsert %W "\n${ct}"
            focus %W
            break
        } else {
            tkTextInsert %W "\n"
            focus %W
            break
        }
    }
    # bind Text <Key-space> {
    #     vTcl:syntax_color %W
    #     tkTextInsert %W " "
    #     focus %W
    #     break
    # }
    bind Text <KeyRelease>   {
        # exclude user inserted text widgets from vTcl bindings
        if {(! [string match .vTcl* %W]) ||
            [info exists %W.nosyntax]  } {
            break
        }
        if {"%K"=="Up" ||
            "%K"=="Down" ||
            "%K"=="Right" ||
            "%K"=="Left"||
            "%K"=="space"||
            "%K"=="End"||
            "%K"=="Home"||
            "%K" == "apostrophe" ||
            "%K" == "quotedbl" ||
            [regexp {[]\")\}]} %A]} {
                scan [%W index insert] %%d pos
                vTcl:syntax_color %W ;# $pos $pos
                focus %W
                break
            }
# if {"%K" == "apostrophe" ||
#     "%K" == "quotedbl"} {
#     vTcl:syntax_color %W
#     focus %W
#     break
# } ;# end if

    }
    bind vTcl(b) <Button-3>          {vTcl:right_click %W %X %Y %x %y}
    bind vTcl(b) <Double-Button-1>   {vTcl:widget_dblclick %W %X %Y %x %y}
    bind vTcl(b) <Button-1>          {vTcl:bind_button_1 %W %X %Y %x %y}
    #bind vTcl(b) <Button-2>          {vTcl:bind_button_2 %W %X %Y %x %y}
    bind vTcl(b) <Button-2>           {vTcl:bind_button_multi %W %X %Y %x %y}
    bind vTcl(b) <Control-Button-2>   {vTcl:bind_top_multi %W %X %Y %x %y}
    #bind vTcl(b) <Shift-ButtonRelease-2> {vTcl:drop_multi_target %W}
    bind vTcl(b) <Control-Key-Delete> {vTcl:remove_multi_selections}
    bind vTcl(b) <Control-Button-1>   {vTcl:bind_button_top %W %X %Y %x %y}
    bind vTcl(b) <Shift-Button-1>    {vTcl:bind_button_container %W %X %Y %x %y}
    bind vTcl(b) <B1-Motion>         {vTcl:bind_motion %W %X %Y}
    #bind vTcl(b) <B2-Motion>         {vTcl:bind_motion %W %X %Y 0 "multi"}
    bind vTcl(b) <B2-Motion>         {vTcl:bind_motion_multi %W %X %Y}
    bind vTcl(b) <Control-B1-Motion> {vTcl:bind_motion_ctrl %W %X %Y}
    bind vTcl(b) <Control-B2-Motion> {vTcl:bind_motion_ctrl_B2 %W %X %Y}
    bind vTcl(b) <ButtonRelease-1>   {vTcl:bind_release %W %X %Y %x %y}
    bind vTcl(b) <ButtonRelease-2>   {vTcl:bind_release_multi %W %X %Y %x %y}

    bind vTcl(b) <Up> {
        vTcl:widget_delta $vTcl(w,widget) 0 -$vTcl(key,y) 0 0
    }

    bind vTcl(b) <Down> {
        vTcl:widget_delta $vTcl(w,widget) 0 $vTcl(key,y) 0 0
    }

    bind vTcl(b) <Left> {
        vTcl:widget_delta $vTcl(w,widget) -$vTcl(key,x) 0 0 0
    }

    bind vTcl(b) <Right> {
        vTcl:widget_delta $vTcl(w,widget) $vTcl(key,x) 0 0 0
    }

    bind vTcl(b) <Shift-Up> {
        vTcl:widget_delta $vTcl(w,widget) 0 0 0 -$vTcl(key,h)
    }

    bind vTcl(b) <Shift-Down> {
        vTcl:widget_delta $vTcl(w,widget) 0 0 0 $vTcl(key,h)
    }

    bind vTcl(b) <Shift-Left> {
        vTcl:widget_delta $vTcl(w,widget) 0 0 -$vTcl(key,w) 0

    }

    bind vTcl(b) <Shift-Right> {
        vTcl:widget_delta $vTcl(w,widget) 0 0 $vTcl(key,w) 0
    }

    bind vTcl(b) <Alt-h> {
        if {$vTcl(h,exist)} {
            vTcl:destroy_handles
        } else {
            vTcl:create_handles $vTcl(w,widget)
        }
    }

    ## If we iconify or deiconify vTcl, take the top windows with us.
    bind .vTcl <Unmap> { vTcl:vtcl:unmap %W }
    bind .vTcl <Map> { vTcl:vtcl:remap %W }
    vTcl:status "Status"
}

proc vTcl:expand_file_name {file} {
    # If a file name is give, we look at it to see if there is an
    # extension. If not or the extension is "." we add the extension
    # "tcl". Then we check to see if the file exists, if not we give
    # user choice of continuing.
    global tcl_platform
    if {$file == ""} { ;# Nothing to expand.
        return
    }
    # if {$tcl_platform(platform) == "windows"} {
    #     # STEFFEN support short names (so-called 8.3 names) by expanding them.
    #     set file [file attributes $file -longname]
    # }
    set ext [file extension $file]
    if {$ext == ""} {
        set file "$file.tcl"
    } elseif { $ext == "."} {
        append file "tcl"
    } else {
        if {[string tolower $ext] != ".tcl"} {
            # STEFFEN added tolower; ignore case of the extension
            destroy .x
            tk_dialog .foo "File Error" \
                 "File $file must have extension \".tcl\"\n Exiting PAGE" \
                  info 0 "ok"
            puts "File must have the extension \".tcl\""
            puts "Exiting PAGE."
            vTcl:exit
        }
    }
    return $file
}

proc vTcl:new_toplevel_widget {} {
    global vTcl
    vTcl:new_widget 0 "Toplevel" bbb
    set vTcl(change) 0
    set top [lindex $vTcl(tops) 0]
    set vTcl(real_top) $top
    set vTcl($top,top_geometry) [wm geometry $top]
    set vTcl(initialdir) [pwd]
    namespace eval ::${top} "

            variable _aliases
            lappend _aliases $alias
        "
}

# This is copied from debug.tcl so that I can use it to print out argv
# at the top of vTcl:main.  Will try to erase it later. In any case it
# will be rewritten when debug.tcl is read in vTcl:main.
proc dpl { arg } {
    # Print out list with each element in a list printed on a separate line..
    set x [expr [info level]-1]
    set y [lindex [info level $x] 0]

    set str "dpl: $y: "
    upvar 1 $arg var
    append str "$arg:"
    foreach element $var {
        append str "\n $element"
    }
    puts stdout $str
}

proc vTcl:help_msg {} {
    global vTcl
    puts \
"
PAGE version: $vTcl(version)
usage: page \[<option>\] <project_file>

Where option can be:
      -p <rcfile>    : specifies the rcfile to be used. If absent
                       the rcfile is ~/.pagerc.
      -s             : select the rcfile to be used.
      -d             : use default options.
      -h, --help     : display this message and exit.

and the project_file is an exiting project file to be opened or
a project file to be created.
"
}

proc vTcl:display_help {} {
    # Display PAGE options. When closed, PAGE exits.
    global vTcl
    toplevel .top
    wm title .top "PAGE Help"
    text .top.t -width 70 -height 13
    pack .top.t
    .top.t insert 1.0 "PAGE version: $vTcl(version)\n\n"
    .top.t insert end "usage: page \[<option>\] <project_file>\n\n"
    .top.t insert end "Where option can be:\n"
    .top.t insert end \
        "      -p <rcfile>    : specifies the rcfile to be used. If absent\n"
    .top.t insert end "                       the rcfile is ~/.pagerc\n"
    .top.t insert end "      -s             : select the rcfile to be used.\n"
    .top.t insert end "      -d             : use default options.\n"
    .top.t insert end "      -h, --help     : display this message and exit.\n\n"
    .top.t insert end \
        "and the project_file is an existing project file to be opened or\n"
    .top.t insert end "a project file to be created."
    set exitvar 0
    button .top.b -text Close -command {set exitvar 1}
    pack .top.b
    wm withdraw .
    tkwait variable exitvar
}

proc vTcl:main {argc argv} {
    set dir "./bwidget"
    global env vTcl tcl_version tcl_platform
    set vTcl(page_running) 1
    after 100
    set vTcl(platform)  $tcl_platform(platform)
    catch {package require dde}    ; #for windows
    #catch {package require Tk}     ; #for dynamic loading tk
    catch {package require Ttk}    ; #for themed widgets - Rozen
    set vTcl(select_profile) 0
    set vTcl(skip_profile) 0
    update
    if {![info exists env(PAGE_HOME)]} {
        set home [file dirname [info script]]
        switch [file pathtype $home] {
            absolute {set env(PAGE_HOME) $home}
            relative {set env(PAGE_HOME) [file join [pwd] $home]}
            volumerelative {
                set curdir [pwd]
                cd $home
                set env(PAGE_HOME) [file join [pwd] [file dirname \
                          [file join [lrange [file split $home] 1 end]]]]
                cd $curdir
            }
        }
    }
    # Directory containing the installation that we are executing.
    set vTcl(VTCL_HOME) $env(PAGE_HOME)

    # Stuff to support Img. I got these image packages from
    # Sourceforge and this is a hack to relieve the PAGE user from
    # needing to do it inorder to have support for more image types
    # especially JPEG's.
    if {$vTcl(platform) eq "windows"} {
        if {[::tcl::pkgconfig get 64bit]} {
            lappend ::auto_path $vTcl(VTCL_HOME)/Img/Img1.4.13-win64
        } else {
            lappend ::auto_path $vTcl(VTCL_HOME)/Img/Img1.4.13-win32
        }
    } elseif {$tcl_platform(os) eq "Darwin"} {
        lappend ::auto_path $vTcl(VTCL_HOME)/Img/Img1.4.13-Darwin64
    } else {
        lappend ::auto_path $vTcl(VTCL_HOME)/Img/Img1.4.13-Linux64
    }
    set vTcl(Img_found) 0
    catch {
        package require Img
        set vTcl(Img_found) 1
    }

    if {![file isdir $env(PAGE_HOME)]} { set vTcl(VTCL_HOME) [pwd] }
    # Set up the debugging stuff at this point, which is early in the
    # executions.  I can use the debugging functions in this code
    # before the other libs are loaded.
    source [file join $vTcl(VTCL_HOME) lib debug.tcl]
    set version_file [file join $vTcl(VTCL_HOME) version]
    source $version_file
    if {$argv == ""} {
        set vTcl(profile) ".pagerc"
    } else {
        # Process options.
        set first_token [lindex $argv 0]
        set vTcl(profile) ".pagerc"
        set vTcl(select_profile) 0
        set vTcl(skip_profile) 0
        switch $first_token {
            -p {
                # Specify profile rc to use
                set vTcl(profile) [lindex $argv 1]
                set argv [lrange $argv 2 end]
            }
            -d {
                # Skip the profile and use default values.
                set vTcl(skip_profile) 1
                set argv [lrange $argv 1 end]
                set vTcl(skip_save_prefs) 1
            }
            --help -
            -h {
                vTcl:help_msg
                vTcl:display_help
                exit
            }
            -s {
                # Use get file dialog to chose the profile rc. The
                # actual selection is found in vTcl:setup in this
                # module.
                set vTcl(select_profile) 1
                set argv [lrange $argv 1 end]
            }

        }
    }
    set file ""
    vTcl:setup
    ## init the bindings editor
    ::widgets_bindings::init
    vTcl:splash_status "              PAGE Loaded" -nodots
    after 250 {if {[winfo exists .x]} {destroy .x}}
    ## load file passed in command line, get rid of splash window right here
    set file [lindex $argv 0]
    set file [string trimright $file]
    set file [vTcl:expand_file_name $file]
    set vTcl(proj_dir) [file dirname $file]

    proc create_blank_toplevel {} {
        # I use this code in both branches of following if statement
        # and want just one copy of the code. I put here to be close
        # to only usage. The call tree goes like this:
        #  create_blank_toplevel
        #    vTcl:new_widget
        #      vTcl:auto_place_widget
        #        vTcl:new_widget_name
        #          vTcl:create_widget
        #            vTcl:push_action
        global vTcl
        destroy .x
        # vTcl:new_widget 0 "Toplevel" bbb
        set new_widget [vTcl:new_widget 0 "Toplevel" bbb]
        set vTcl(real_top) [lindex $vTcl(tops) 0]
        set vTcl($vTcl(real_top),top_geometry) [wm geometry $vTcl(real_top)]
        # Set the initial project directory to the current working directory.
        set vTcl(initialdir) [pwd]

        namespace eval ::widgets::${vTcl(real_top)} {
            # Create the variable so that I can store the widget mode there.
            variable mode
        }
        if {$vTcl(pr,relative_placement) == 1} {
            set vTcl(mode) "Relative"
            set ::widgets::${vTcl(real_top)}::mode "Relative"
        } else {
            set vTcl(mode) "Absolute"
            set ::widgets::${vTcl(real_top)}::mode "Absolute"
        }
    }
    # Where we open an existing called-for project file.
    if {$file != ""} {
        if {$vTcl(platform) eq "windows"} {
            set vTcl(MS_dirname) [file dirname $file]
        }
        if {[file exists $file]} {
            destroy .x                    ;# .x is the splash screen.
            set vTcl(initial_open) 1
            vTcl:open $file
            set vTcl(initial_open) 0
        } elseif {[file exists [autosave_filename $file]]} {
            destroy .x
            set vTcl(initial_open) 1
            vTcl:open [autosave_filename $file]
            set vTcl(initial_open) 0
        } else {
            # If project name not given, create blank toplevel here.
            set vTcl(project,file) $file
            create_blank_toplevel
        }
        set vTcl(change) 0
    } else {
        # No file name given so we will just start up with a blank
        # toplevel. However, that leaves us with no project name and that
        # complicates auto-save, for that reason, I am deprecating this
        # form of invocation.
        if {$vTcl(platform) eq "windows"} {
            set vTcl(MS_dirname) [pwd]
        }
        create_blank_toplevel
        set vTcl(change) 0
    }
}

# proc watch {varname key op} {
#         if {$key != ""} {
#                 set varname ${varname}($key)
#                 }
#         upvar $varname var
#         puts "$varname is $var (operation $op)"
# }

proc touch {filename} {
    # Touch a file: without modifying the contents, change a file's
    # access time to (now); create it if it doesn't exist, with 0
    # bytes contents. I have to synthesize a touch command.
    close [open $filename a]
} ;# after Don Porter in c.l.t

proc autosave_filename {fname} {
    # Construct name for the autosave file.
    if {$fname eq ""} {
        set filename "autosave.tcl"
        # Since I want the user to be able to choose to Open
        # autosave.tcl, the dialog will return only an existing file,
        # I make sure that autosave.tcl exists by a UNIX like touch
        # operation.
        #touch "autosave.tcl"
    } else {
        set dirname [file dirname $fname]
        set tail [file tail $fname]
        set ext [file extension $tail]
        set rootname [file rootname $tail]
        regsub -all "#" $rootname "" rootname
        set filename "${dirname}/#${rootname}${ext}#"
    }
    return $filename
}

proc autosave {varname args} {
    upvar #0 $varname var
    upvar #0 vTcl(autosave_time) vtime
    upvar #0 vTcl(autosave_filename) vlast_save_name
    upvar #0 vTcl(project,file) vfile
    upvar #0 vTcl(save_as) vsaveas
    upvar #0 vTcl(autosave_skip) vskip
    upvar #0 vTcl(w,widget) vtarget      ;# active widget
    upvar #0 vTcl(change) vchange
#    if {$vchange == 0} { return }
    if {$vskip} { return }
    set vsaveas 0
    set c_time [clock seconds]
    set s_vfile $vfile
    set s_target $vtarget
    if {$var} {
        # vTcl(change) > 0. A GUI change has occurred, so if the wait
        # period is exceeded then do a backup and reset the clock.
        set period 10  ;# in seconds.
        if {[expr {$c_time - $vtime}] > $period} {
            set filename [autosave_filename $vfile]
            vTcl:save_as $filename  "autosave" ;# Actual autosave.
            set vtime $c_time                           ;# Reset clock
            set vfile $s_vfile  ;# vTcl(project,file) was set to
                                 # manufactured name in save2, so we
                                 # reset it here.
        } else { set ::vTcl(change) 1 }
    } else {
        #  vTcl(change) = 0. Indicates that a user inspired save of the
        #  project file has occurred, so remove the auto-save file and
        #  reset the clock.prog_call = sys.argv\[0\]
        set filename [autosave_filename $vfile]
        set vtime [clock seconds]
        file delete $filename
        file delete "autosave.tcl"
        if {![regexp {^.top\d+$} $s_target]} {
            vTcl:active_widget $s_target
            vTcl:create_handles $s_target
        }
        set vfile $s_vfile
    }
}

proc remove_autosave_files {} {
    # Delete all autosave files in current directory
    set file_list [glob -nocomplain #*.tcl#]
    file delete autosave.tcl
    if {[llength $file_list] == 0} { return }
    file delete {*}${file_list}
}

# Whenever vTcl(change) is modified, i.e. any change to the GUI, we
# call autochange above to consider saving a backup version of the
# GUI. This trace is not a debugging trace. It is the trigger for autosave.
# To remove autosave function comment next line.

trace add variable vTcl(change) write "autosave vTcl(change)"

proc tracer {varname args} {
    upvar #0 $varname var
#puts "################################################"
    puts "tracer: $varname was updated to be: $var"
    puts "$var"
    dtrace
#puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    dskip
}


# Examples of debugging trace statements.

#trace add variable vTcl(tops) \
    write "tracer vTcl(tops)"

# set c ".vTcl.ae"
# set opt command
# set var "$c.f2.f._$class.t${opt}_save"
# trace add variable $var \
#     write "tracer $var"

# most common case
# set var "vTcl(dump,userImages)"
# set var "options(-labelanchor,text)"
# set var "vTcl(dump,userImages)"
# puts "var = $var"
# trace add variable $var \
#      write "tracer $var"

# trace add variable $var \
#      read "tracer $var"


# namespace eval ::widgets::.top1.tRa45 { }
# set var "::widgets::.top1.tLa45::save(-font)"
# trace add variable $var \
#     write "tracer $var"

# namespace eval ::widgets::.top1.tRa45 { }
# set var "::widgets::.top1.tRa45::defaults(-variable)"
# trace add variable $var \
    #     write "tracer $var"

# STEFFEN use the default system encoding to convert $argv to Unicode

#vTcl:main $argc [encoding convertfrom [encoding system] $argv]

vTcl:main $argc $argv

