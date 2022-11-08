##############################################################################
# $Id: propmgr.tcl,v 1.2 2012/01/22 03:14:34 rozen Exp rozen $
#
# propmgr.tcl - procedures used by the widget properties manager
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

# vTcl:prop:new_attr
# vTcl:prop:update_attr
# vTclWindow.vTcl.ae
# vTcl:prop:geom_config_cmd
# vTcl:prop:geom_config_mgr
# vTcl:prop:update_saves
# vTcl:propmgr:show_rightclick_menu
# vTcl:prop:default_opt
# vTcl:prop:apply_opt
# vTcl:prop:set_opt
# vTcl:prop:config_cmd

# If user does Button-3 on a label that exercises a binding, set in
# vTcl:prop:new_attr around line 980, which will call
# vTcl:propmgr:show_rightclick_menu.

# The user modifies a geometry entry field, the actual change of place
# configuration takes place in vTcl:prop:geom_config_mgr being driven
# there by the <KeyRelease-Return> event binding in
# vTcl:prop:new_attr.  Similarly the program goes to
# vTcl:prop:config_cmd to handle other attributes.

proc vTcl:show_propmgr {} {
    global vTcl
    vTclWindow.vTcl.ae
    wm geometry .vTcl.ae $vTcl(geometry,.vTcl.ae)
}

proc vTcl:grid:height {parent {col 0}} {
    update idletasks
    set h 0
    set s [grid slaves $parent -column $col]
    foreach i $s {
        incr h [winfo height $i]
    }
    return $h
}

proc vTcl:grid:width {parent {row 0}} {
    update idletasks
    set w 0
    set s [grid slaves $parent -row $row]
    foreach i $s {
        incr w [winfo width $i]
    }
    return $w
}

proc vTcl:prop:set_visible {which {on ""}} {
    global vTcl
    set var ${which}_on
    switch $which {
        info {
            set f $vTcl(gui,ae,canvas).f1
            set name "Widget"
        }
        attr {
            set f $vTcl(gui,ae,canvas).f2
            set name "Attributes"
        }
        geom {
            set f $vTcl(gui,ae,canvas).f3
            set name "Geometry"
        }
        default {
            return
        }
    }
    # if {$on == ""} {
    #     set on [expr - $vTcl(pr,$var)]
    # }
    # if {$on == 1} {
    #     pack $f.f -side top -expand 1 -fill both
    #     $f.l conf -text "$name (-)"
    #     set vTcl(pr,$var) 1
    # } else {
    #     pack forget $f.f
    #     $f.l conf -text "$name (+)"
    #     set vTcl(pr,$var) -1
    # }
    pack $f.f -side top -expand 1 -fill both
    $f.l conf -text "$name"
    set vTcl(pr,$var) 1
    update idletasks
    vTcl:prop:recalc_canvas
}

proc vTclWindow.vTcl.ae {args} {
    # Build the Attribute Editor window.
    global vTcl tcl_platform
    set ae $vTcl(gui,ae)
    set top $ae
    set base $top

    if {[winfo exists $ae]} {
        wm deiconify $ae
        vTcl:prop:recalc_canvas
        return}
    set geom_ae $vTcl(geometry,.vTcl.ae)
    toplevel $ae -class vTcl
    wm withdraw $ae
    wm transient $ae .vTcl
    wm title $ae "Attribute Editor"
    wm geometry $ae $geom_ae
    wm resizable $ae 1 1
    wm transient $vTcl(gui,ae) .vTcl
    wm overrideredirect $ae 0

    wm protocol $ae  WM_DELETE_WINDOW {
        vTcl:error "You cannot remove the Attribute Editor"
    }

    if {$tcl_platform(platform) == "windows"} {
        set scrincr 25
    } else {
    set scrincr 20
    }

    # set vTcl(gui,ae,canvas) [ScrolledWindow $ae.sw].c
    # set c $vTcl(gui,ae,canvas)

    # Create a scrolling canvas
    ScrolledWindow $ae.sw
    canvas $ae.sw.c -highlightthickness 0 \
        -background $vTcl(pr,bgcolor) \
        -borderwidth 0 \
        -closeenough 1.0 -relief flat
    $ae.sw setwidget $ae.sw.c

    pack $ae.sw \
        -in $base -anchor center -expand 1 -fill both -side top

    set c $ae.sw.c
    set vTcl(gui,ae,canvas) $c

    set f1 $c.f1; frame $f1 -bg $vTcl(pr,bgcolor)     ; # Widget Info
        $c create window 0 0 -window $f1 -anchor nw -tag info
    set f2 $c.f2; frame $f2  -bg $vTcl(pr,bgcolor)     ; # Widget Attributes
        $c create window 0 0 -window $f2 -anchor nw -tag attr
    set f3 $c.f3; frame $f3  -bg $vTcl(pr,bgcolor)     ; # Widget Geometry
        $c create window 0 0 -window $f3 -anchor nw -tag geom

    label $f1.l -text "Widget"     -relief raised -bg #aaaaaa -bd 1 -width 30 \
        -anchor center  -fg black
        pack $f1.l -side top -fill x
    label $f2.l -text "Attributes" -relief raised -bg #aaaaaa -bd 1 -width 30 \
        -anchor center  -fg black
        pack $f2.l -side top -fill x
    label $f3.l -text "Geometry"   -relief raised -bg #aaaaaa -bd 1 -width 30 \
        -anchor center  -fg black
        pack $f3.l -side top -fill x

    bind $f1.l <ButtonPress> {vTcl:prop:set_visible info}
    bind $f2.l <ButtonPress> {vTcl:prop:set_visible attr}
    bind $f3.l <ButtonPress> {vTcl:prop:set_visible geom}

    set w $f1.f
    frame $w; pack $w -side top -expand 1 -fill both
    # In the following labels I changed the disabled colors.
    label $w.ln -text "Widget" -width 11 -anchor w
        vTcl:entry $w.en -width 12 -textvariable vTcl(w,widget) \
        -relief sunken \
        -state normal -bg $vTcl(pr,disablebg) -fg  $vTcl(pr,disablefg)
        # Changed the state of this entry so that for long values of the entry
        # user can move cursor to end to read it.
        #-state disabled -disabledbackground $vTcl(pr,disablebg) \
        #-disabledforeground $vTcl(pr,disablefg)
    label $w.lc -text "Class"  -width 11 -anchor w
        vTcl:entry $w.ec -width 12 -textvariable vTcl(w,class) \
        -relief sunken \
        -state disabled -disabledbackground $vTcl(pr,disablebg) \
        -disabledforeground $vTcl(pr,disablefg)
    label $w.lm -text "Manager" -width 11 -anchor w
        vTcl:entry $w.em -width 12 -textvariable vTcl(w,manager) \
        -relief sunken \
        -state disabled -disabledbackground $vTcl(pr,disablebg) \
        -disabledforeground $vTcl(pr,disablefg)
    label $w.la -text "Alias"  -width 11 -anchor w
    # ea is the entry field where an alias is entered.
    vTcl:entry $w.ea -width 12 -textvariable vTcl(w,alias) \
        -disabledbackground $vTcl(pr,disablebg) \
        -disabledforeground $vTcl(pr,disablefg) \
        -relief sunken -foreground #000000       ;# NEEDS WORK dark
    bind $w.ea <KeyRelease-Return> "
        ::vTcl::properties::setAlias \$::vTcl(w,widget) ::vTcl(w,alias) $w.ea
        set vTcl(change) 1; vTcl:show_wtree" ;# Line added 5/27/16 & 4/4/17.
    bind $w.ea <FocusOut> "
        ::vTcl::properties::setAlias \$::vTcl(w,widget) ::vTcl(w,alias) $w.ea
        set vTcl(change) 1
        vTcl:show_wtree" ;# Line added 5/27/16 & 4/4/17. Rozen
    # va is the entry field where the variant is entered.
    if {[info exists vTcl(show_variant)] && $vTcl(show_variant)} {
        label $w.lv -text "Variant"  -width 11 -anchor w
        vTcl:entry $w.ev -width 12 -textvariable vTcl(w,variant) \
            -relief sunken
        bind $w.ea <KeyRelease-Return> "
          ::vTcl::properties::setAlias \$::vTcl(w,widget) ::vTcl(w,alias) $w.ea
          set vTcl(change) 1; vTcl:show_wtree"
        bind $w.ea <FocusOut> "
          ::vTcl::properties::setAlias \$::vTcl(w,widget) ::vTcl(w,alias) $w.ea
        set vTcl(change) 1; vTcl:show_wtree"
    }
    label $w.li -text "Insert Point" -width 11 -anchor w
        vTcl:entry $w.ei -width 12 -textvariable vTcl(w,insert) \
        -relief sunken \
        -state normal -bg $vTcl(pr,disablebg) -fg  $vTcl(pr,disablefg)

    grid columnconf $w 1 -weight 1

    grid $w.ln $w.en -padx 0 -pady 1 -sticky news
    grid $w.lc $w.ec -padx 0 -pady 1 -sticky news
    grid $w.lm $w.em -padx 0 -pady 1 -sticky news
    grid $w.la $w.ea -padx 0 -pady 1 -sticky news
    if {[info exists vTcl(show_variant)] && $vTcl(show_variant)} {
        grid $w.lv $w.ev -padx 0 -pady 1 -sticky news
    }
    grid $w.li $w.ei -padx 0 -pady 1 -sticky news

    #ttk::style configure PyConsole.TSizegrip \
        -background $vTcl(actual_gui_bg) ;# 11/22/12

    set w $f2.f
    frame $w; pack $w -side top -expand 1 -fill both

    set w $f3.f
    frame $w; pack $w -side top -expand 1 -fill both

    vTcl:prop:set_visible info $vTcl(pr,info_on)
    vTcl:prop:set_visible attr $vTcl(pr,attr_on)
    vTcl:prop:set_visible geom $vTcl(pr,geom_on)
    vTcl:setup_vTcl:bind $vTcl(gui,ae)
    if {$tcl_platform(platform) == "macintosh"} {
        set w [expr [winfo vrootwidth .] - 206]
        wm geometry $vTcl(gui,ae) 200x300+$w+20
    }
    update idletasks
    vTcl:prop:recalc_canvas

    bind $ae.sw.c <Enter> \
        {vTcl:bind_mousewheel  $::vTcl(gui,ae).sw.c}
    bind $ae.sw.c <Leave> \
        {vTcl:unbind_mousewheel $::vTcl(gui,ae).sw.c}

    # For debugging set up <configure> binding.
    #bind $base <Configure> vTcl:configure_ae_event

    # When you enter the Attribute Editor window raise it to the top.
    bind $base <Enter> "raise $base"

    wm deiconify $ae
    wm geometry $ae $geom_ae  ;# Keeps ae from moving across the screen. 10/20

}

proc vTcl:configure_ae_event {} {
    # Debugging routine so I can follow movement of ae.
    dmsg
    set g [wm geometry .vTcl.ae]
    dpr g
}

proc vTcl:prop:recalc_canvas {} {
    global vTcl
    set ae $vTcl(gui,ae)
    set c  $vTcl(gui,ae,canvas)
    if {![winfo exists $ae]} { return }

    set f1 $c.f1                              ; # Widget Info Frame
    set f2 $c.f2                              ; # Widget Attribute Frame
    set f3 $c.f3                              ; # Widget Geometry Frame
    $c coords attr 0 [winfo height $f1]
    $c coords geom 0 [expr [winfo height $f1] + [winfo height $f2]]

    set w [vTcl:util:greatest_of "[winfo width $f1] \
                                  [winfo width $f2] \
                                  [winfo width $f3]" ]
    set h [expr [winfo height $f1] + \
                [winfo height $f2] + \
               [winfo height $f3] ]
    $c configure -scrollregion "0 0 $w $h"
    wm minsize .vTcl.ae $w 200

    set vTcl(propmgr,frame,$f1) 0
    lassign [vTcl:split_geom [winfo geometry $f1]] w h
    set vTcl(propmgr,frame,$f2) $h
    lassign [vTcl:split_geom [winfo geometry $f2]] w h2
    set vTcl(propmgr,frame,$f3) [expr $h + $h2]
}

proc vTcl:key_release_cmd {k config_cmd target option variable args} {
    global vTcl
    switch $option {
        -command -
        -variable -
        -textvariable -
        -listvariable -
        -tearoffcommand {
            set value [set [set variable]]
        }
        # -validatecommand -
        # -invalidcommand {
        #     # extract the command from (cmd, '%P", ...)
        #     set value [set [set variable]]
        #     #regexp {[a-zA-Z0-9_]+} $value value
        # }
    }
    ## Don't change if the user presses a directional key.
    # Rozen.  I removed the following "if" because leaving it there
    # goofed up stuff when changing a button text to "process". I
    # really don't understand why.
    #if {$k < 37 || $k > 40} {
    set value [set $variable]
    set ::vTcl::config($target) [list $config_cmd $target $option \
                                     $variable $value $args]
    ## Geometry options do not have checkboxes to save/not save
    if {$config_cmd != "vTcl:prop:geom_config_mgr"} {
        vTcl:prop:save_opt $target $option $variable
    }
    #}
}

proc vTcl:focus_out_cmd {} {
    # ::vTcl::config is an array of configure commands which are
    # created in the function vTcl:key_release_cmd directly above. One
    # element of the array is related to each widget.
    global vTcl
    set names [array names ::vTcl::config]
    set vTcl(change) 1
    foreach w $names {
        if {![winfo exists $w]} {
            continue
        }
        #catch {
            # The line below takes apart a widget configure command
            # and stuffs the constituents into a list of variables.
        lassign $::vTcl::config($w) config_cmd target option \
            variable value args
        regsub {^::} $value "" value ;# Remove leading "::" artifact.
        # The line below causes the actual configuration.
        $config_cmd $target $option $variable $value $args
        if {$option eq "-text"} {
            set vTcl(w,opt,text) $value
        }
        #} ;# catch
        # The configuration is done so remove the command from the
        # array so that it isn't repeated.
        unset ::vTcl::config($w)
    }
    vTcl:place_handles $::vTcl(w,widget)
}


proc vTcl:prop:config_cmd {target option variable value args} {
    # This where a changed non-geometry attribute is actually handled.
    global vTcl
    # if {$option in "-command -textvariable"} {
    #     regsub {^::} $value "" value
    #     if {![vTcl:isident $value]} {
    #         ::vTcl::MessageBox -icon error  \
    #             -message "Syntax Error: Illegal variable name -\"$value\"" \
    #             -title "Syntax Error"
    #     }
    # }
    if {$option == "-image"} {
        set x [set $variable]
        if {[file exists $x]} {
            # The value of $variable is a file presumably a gif or ppm.
            set new_value [vTcl:image:create_new_image $x]
            set $variable $new_value
            set y [set $variable]
        }
    }
    if {$value == ""} {
        $target configure $option [set $variable]
        vTcl:prop:save_opt $target $option $variable
        vTcl:place_handles $target
    } else {
        # The comment code below is part of solving the current
        # problem of not being able to change the text of a widget
        # when a text variable is specified. Stay tuned. It looks
        # possible that the solution could be worse than the problem.
        if {$vTcl(w,class) in {TButton TCheckbutton TLabel TRadiobutton}} {
            switch -exact $option {
                -textvariable {
                    set text $vTcl(w,opt,text)
                    set var [set value]
                    set ::$var  $text
                    $target configure -textvariable ::$var
                    vTcl:prop:save_opt_value $target $option $value
                    vTcl:place_handles $target
                    update
                    return
                }
             -text {
        #         set textvar [$target cget -textvariable]
        #         set $textvar $value
        #         vTcl:prop:save_opt_value $target $option $value
        #         vTcl:place_handles $target
        #         update
        #         return
             }
            }
        }
        ############################################
        $target configure $option $value
        vTcl:prop:save_opt_value $target $option $value
        vTcl:place_handles $target
        ############################################
        update idletasks
    }
}

proc vTcl:prop:spec_config_cmd {target option variable value args} {
    global vTcl
    set cmd $args
    if {$value == ""} {
        $cmd $target [set $variable]
        vTcl:prop:save_opt $target $option $variable
        vTcl:place_handles $target
    } else {
        $cmd $target $value
        vTcl:prop:save_opt_value $target $option $value
    }
}

proc vTcl:prop:geom_config_mgr {target option variable value args} {
    # Destination when user modifies geometric option.
    global vTcl
    set class [vTcl:get_class $target]
    if {$class eq "Toplevel"} { return }
# These two tests support changing geometry in the face design modes.
    vTcl:convert_for_geom_option $target $option
#     if {$option in "-x -y -width -height"} {
# dmsg have x or y target_mode =  [vTcl:get_mode $target]
#         set w_mode [vTcl:get_mode $target]
#         if {$w_mode ne "Absolute"} {
#             vTcl:convert_widget $target
#         }
#     }
#     if {$option in "-relx -rely -relwidth -relheight"} {
# dmsg have relx or rely target_mode =  [vTcl:get_mode $target]
#         set w_mode [vTcl:get_mode $target]
#         if {$w_mode ne "Relative"} {
#             vTcl:convert_widget $target
#         }
#     }
# dmsg have x or y target_mode =  [vTcl:get_mode $target]
#         set w_mode [vTcl:get_mode $target]
#         if {$w_mode ne $vTcl(mode)} {
#             vTcl:convert $target
#         }


    vTcl:setup_unbind_widget $target
    if {$value == ""} {
        set value [set $variable]
    }
    # Since place figures many geometric properties as the sum of an
    # absolute and relative value and the Attribute Editor shows both
    # values as the complete value, if we change one then require a
    # zero value for the other should be passed to the place command.
    vTcl:convert_for_geom_option $target $option
    switch -exact $option {
        -relx {
            place configure $target $option $value -x 0
            # set $variable $value ;# NEEDS WORK I removed this for
            # consistency reasons. Hope that I haven't introduced any
            # problems.
        }
        -rely {
            place configure $target $option $value -y 0
        }
        -relwidth {
            place configure $target $option $value -width 0
        }
        -relheight {
            place configure $target $option $value -height 0
        }
        -width {
            place configure $target $option $value -relwidth 0
        }
        -height {
            place configure $target $option $value -relheight 0
        }
        -x {
            place configure $target $option $value -relx 0
        }
        -y {
            place configure $target $option $value -rely 0
        }
    }
    update
    set t_mode [vTcl:get_mode $target]
    if {$t_mode ne $vTcl(mode)} {
        vTcl:convert_widget $target
    }
    vTcl:relative_place $target
    vTcl:update_widget_info $target
    vTcl:setup_bind_widget $target
    vTcl:place_handles $target
    ::vTcl::notify::publish geom_config_mgr $target place $option
    set vTcl(change) 1
}

proc vTcl:prop:geom_config_cmd {target option variable value args} {
    global vTcl
    set cmd $args
    vTcl:setup_unbind_widget $target
    if {$value == ""} {
        $cmd $target $option [set $variable]
        vTcl:place_handles $target
    } else {
        $cmd $target $option $value
    }
    vTcl:setup_bind_widget $target
    ::vTcl::notify::publish geom_config_cmd $target $cmd $option
    set vTcl(change) 1
    update
}

proc vTcl:prop:update_attr {{redo 0}} {
    # Called when widget is selected. $vTcl(options) is a list of all
    # attributes for all widgets. Basically, this fills out the area
    # for the attributes which apply to the widget class and the
    # geometry and then calls vTcl:prop:new_attr to fill in the
    # particulars for each of the attributes.

    # The the list of options will probably differ with each widget
    # class so the Attribute Editor creates section for attributes
    # anew when this function is called. However, the geometric
    # section will only have its fields changed when the geometry
    # manager changes, but since we only have one, place, the section
    # needs to be created only once. So the vTcl:new_attr function
    # does not need to be called for the geometric entries each
    # time. Those values are updated at the bottom of
    # vTcl:select_widget when it calls vTcl:update_widget_info. It is
    # a small optimization but it really obfuscates the code.
    global vTcl options specialOpts
    set ae $vTcl(gui,ae)
    if {$vTcl(var_update) == "no"} {
        return
    }
    if {[vTcl:streq $vTcl(w,widget) "."]} {
        vTcl:prop:clear
        return
    }
    vTclWindow.vTcl.ae
    #
    # Update Widget Attributes
    #
    set fr $vTcl(gui,ae,canvas).f2.f
    set top $fr._$vTcl(w,class)
# set fr_children [winfo children $fr]
# dpr -s fr
# dpr top
#dpr vTcl(w,last_class) vTcl(w,class)
    if {[winfo exists $top] } {
#dmsg Spot Big If $vTcl(w,widget)
        if {$vTcl(w,class) != $vTcl(w,last_class) || \
                [string first "Scroll" $vTcl(w,class)] > -1 } {
            catch {pack forget $fr._$vTcl(w,last_class)}
        # if {[catch {pack forget $fr._$vTcl(w,last_class)}]} {
        #     dmsg failed to forget $fr._$vTcl(w,last_class)
        # } else {
        #     dmsg forgot $fr._$vTcl(w,last_class)
        # }
            update
            pack $top -side left -fill both -expand 1
        }
        foreach i $vTcl(options) {
            if {$i ni  $vTcl(w,optlist)} { continue }
            if {$i == "-variant" && $vTcl(w,class) == "Custom"} {
                set w $vTcl(w,widget)
                set val $vTcl(w,opt,$i)
                #set variable [$::configcmd($i,get) $w]
                set variable $val
                vTcl:prop:new_attr $top $i $variable vTcl:prop:config_cmd "" opt
            }
            if {$vTcl(w,class) == "Custom"} { continue }
            set type $options($i,type)
            if {[info exists specialOpts($vTcl(w,class),$i,type)]} {
                set type $specialOpts($vTcl(w,class),$i,type)
            }
            if {$type == "synonym"} { continue }
            if {[lsearch $vTcl(w,optlist) $i] >= 0} {
                if {$type == "color"} {
                    set val $vTcl(w,opt,$i)
                    if {$val == ""} {
                        ## if empty color use default background
                        set val [lindex [$top.t${i}.f configure -bg] 3]
                    }
                    if {[string first "#" $val] >= -1} {
                        # Rozen Kludge in case color is in hex form.
                        set vTcl(tmp) $val
                        set val vTcl(tmp)
                    }
                    ::vTcl::ui::attributes::show_color $top.t${i}.f $val
                    #$top.t${i}.f configure -bg $val
                }
            }
        }
    } elseif [winfo exists $fr] {
#dmsg Big Else If $vTcl(w,widget)
        if {$vTcl(w,class) != $vTcl(w,last_class) || \
                [string first "Scroll" $vTcl(w,class)] > -1 } {
            catch {pack forget $fr._$vTcl(w,last_class)}
        # if {[catch {pack forget $fr._$vTcl(w,last_class)}]} {
        #     dmsg failed to forget $fr._$vTcl(w,last_class)
        # } else {
        #     dmsg forgot $fr._$vTcl(w,last_class)
        # }
        }
        frame $top
        pack $top -side top -expand 1 -fill both
        grid columnconf $top 1 -weight 1
        set type ""
        # vTcl(options) is list of all possible attributes and it is
        # set statically in Widgets/core/Options.wgt via NewOption.
        # vTcl(w,optlist) is the list of options which are valid for
        # the window w. It is set in vTcl:update_widget_info in
        # widget.tcl which uses vTcl:conf_to_pairs in widget.tcl to
        # build the list from the widget configuration.  Rozen
        # We only look at those options which apply to this widget.
        foreach i $vTcl(options) {
            if {$vTcl(w,class) == "Custom"} { continue }
            if {$options($i,type) == "synonym"} { continue }
            set newtype $options($i,title)
            if {$type != $newtype} {
                set type $newtype
            }
            # You can't change container option after widget is
            # created. No point in showing it.
            if {$i == "-container"} { continue }
            if {$i ni  $vTcl(w,optlist)} { continue }
            if {$i == "-class"} { continue } ;# class already displayed.
            set variable "vTcl(w,opt,$i)"
            vTcl:prop:new_attr $top $i $variable vTcl:prop:config_cmd "" opt
        }
        ## special stuff to edit menu items (cascaded items)
        if {$vTcl(w,class) == "Menu"} {
            global dummy
            set dummy ""
            vTcl:prop:new_attr $top -menuspecial dummy "" "" opt ""
        }
        ## special options support
        if {[info exist ::classoption($vTcl(w,class))]} {
            foreach spec_opt $::classoption($vTcl(w,class)) {
                if {$spec_opt == "-variant"} {
                    set w $vTcl(w,widget)
                    set vTcl(w,opt,$spec_opt) [$::configcmd(-variant,get) $w]
                }
                vTcl:prop:new_attr $top $spec_opt vTcl(w,opt,$spec_opt) \
                    vTcl:prop:spec_config_cmd $::configcmd($spec_opt,config) opt
            }
        }
        set mgr $vTcl(w,manager)
    } ;# End of Big Else if
    set vTcl(w,last_class) $vTcl(w,class) ;# Part of solution 1.
    if {$vTcl(w,manager) == ""} {
        update idletasks
        vTcl:prop:recalc_canvas
        return
    }
    #vTcl:prop:set_visible attr
    #update
    #
    # Update Widget Geometry
    #
    set fr $vTcl(gui,ae,canvas).f3.f
    set top $fr._$vTcl(w,manager)
    set mgr $vTcl(w,manager)
    update idletasks
    set w $vTcl(w,widget)
    set parent [winfo parent $w]
    set p_class [vTcl:get_class $parent]
    if {$p_class != "TPanedwindow" && $p_class != "TNotebook"
        && $p_class != "PNotebook"} {
        if {[winfo exists $top]} {
            if {$vTcl(w,manager) != $vTcl(w,last_manager)} {
                catch {pack forget $fr._$vTcl(w,last_manager)}
                pack $top -side left -fill both -expand 1
            }
        } elseif [winfo exists $fr] {
        catch {pack forget $fr._$vTcl(w,last_manager)}
        frame $top
        pack $top -side top -expand 1 -fill both
        grid columnconf $top 1 -weight 1
    #catch {
        # Removed the comment delimiter above and at the end of the catch
        # vTcl(m,$mgr,list) are the usual geometry
        # options. vTcl(m,$mgr,extlist) are the extra ones needed by
        # PAGE. As above they are added by vTcl:prop:new_attr.
        # Reordered item in foreach stmt to put the locked item at the top.
        if {[vTcl:is_geom_fluid $vTcl(w,widget)]} {
            # Only display geometric attributes if they may be
            # modified. widgets inside of Scrolled wrappers cannot
            # have their attributes modified only the wrapper widget
            # can have their geometry changed.
            foreach i "$vTcl(m,$mgr,extlist) $vTcl(m,$mgr,list)" {
                if {$i == "title"} continue ;# Rozen moved title to attributes.

                # I find the anchor option of place geometry manager
                # to be very confusing and have decided to remove it
                # from the Attribute Editor.
                if {$i == "-anchor"} continue
                # New stuff for handling prop,geom and dflt,origin.
                if {[info exists vTcl(save,$i)]} {
                    # Read from the project file - xxx.tcl
                    set vTcl(w,$mgr,$i) "$vTcl(save,$i)"
                    unset vTcl(save,$i)
                }
                set variable "vTcl(w,$mgr,$i)"    ;# Note a 'w' not 'm'
                # The command is gotten from vTcl(m,wm,*) array of
                # variables which are set in global.tcl. We are not
                # using the grid or pack window managers, so I think
                # the arrays vTcl(m,grid,*) and vTcl(m,pack,*) are not
                # relevant.
                set cmd [lindex $vTcl(m,$mgr,$i) 4]
                if {$cmd == ""} {
                    vTcl:prop:new_attr $top $i $variable \
                        vTcl:prop:geom_config_mgr $mgr m,$mgr -geomOpt
                } else {
                    vTcl:prop:new_attr $top $i $variable \
                        vTcl:prop:geom_config_cmd $cmd m,$mgr -geomOpt
                }
            }
        }
    #}   ;# End of catch.
        }
        vTcl:prop:set_visible geom
    }

    if {$vTcl(w,manager) == "wm"} {
        # enable/disable position/size values depending on settings
        vTcl:wm:enable_geom
    }
    vTcl:prop:recalc_canvas
    vTcl:prop:update_saves $vTcl(w,widget)
    # Following two loc added to make the AE look right in Windows 10
    update
    vTcl:prop:set_visible attr
    # In order to disallow the changing of the alias of a Popupmenu
    # widget I do the following.
    set alias_label $vTcl(gui,ae,canvas).f1.f.ea
    if {$vTcl(w,class) eq "Popupmenu"} {
        $alias_label configure -state disabled
    } else {
        $alias_label configure -state normal
    }
}

proc vTcl:prop:combo_update {w var args} {
    if {[winfo exists $w]} {
        set values [set ::$var]
        set index [lindex $values 0]
        $w configure -values [lrange $values 1 end]
        if {$index != -1} {
            $w setvalue @$index
        }
    }
}

proc vTcl:prop:combo_select {w option} {
    $::configcmd($option,select) $::vTcl(w,widget) [$w getvalue]
}

proc vTcl:prop:combo_edit {w option} {
    $::configcmd($option,edit) $::vTcl(w,widget) $::configcmd($option,editArg)
}

proc vTcl:prop:choice_update {w var args} {
    if {[winfo exists $w]} {
        set values [$w cget -values]
        set value  [set ::$var]
        set index [lsearch -exact $values $value]
        if {$index != -1} {
            $w setvalue @$index
        }
    }
}

proc vTcl:prop:choice_select {w var} {
    set index [$w getvalue]
    set values [$w cget -values]
    if {$index != -1} {
        set ::$var [lindex $values $index]
    }
}

proc vTcl:prop:color_update {w val} {
    if {$val == ""} {
        ## if empty color use default background
        set val [lindex [$w configure -bg] 3]
    }
    if {[::colorDlg::dark_color $val]} {
        set ell_image ellipseslight
    } else {
        set ell_image ellipsesdark
    }
    $w configure -bg $val -image $ell_image
}

proc vTcl:prop:new_attr {top option variable config_cmd \
                             config_args prefix {isGeomOpt ""}} {
    # This routine creates the right hand side of the Attribute
    # editor one attribute per call from vTcl:prop:update_attr.
    # Rozen removed $variable from the global stmt below.
    global vTcl options specialOpts propmgrLabels
    global opt_list
    if {$option == "-colormap"} {return}  ;# user really can't change.
    set base $top.t${option}
    # Hack for Tcl/Tk 8.5
    # Tristan 2008-05-13
    foreach v {vTcl $variable options specialOpts propmgrLabels} {
        upvar #0 $v $v
    }
    set base $top.t${option} ;# This is going to be the entry name
    # Hack for Tix
    if {[winfo exists $top.$option]} { return }
    if {![lempty $isGeomOpt]} {
        set isGeomOpt 1
    } else {
        set isGeomOpt 0
    }
    if {$prefix == "opt"} {
        if {[info exists specialOpts($vTcl(w,class),$option,type)]} {
            set text    $specialOpts($vTcl(w,class),$option,text)
            set type    $specialOpts($vTcl(w,class),$option,type)

            set choices $specialOpts($vTcl(w,class),$option,choices)
        } else {
            set text    $options($option,text)
            set type    $options($option,type)
            set choices $options($option,choices)
        }
    } else {
        # Option information is basically found in
        # lib/Widgets/core/Options.wgt.
        set text    [lindex $vTcl($prefix,$option) 0]
        set type    [lindex $vTcl($prefix,$option) 2]
        set choices [lindex $vTcl($prefix,$option) 3]
    }
    if {[vTcl:streq $type "relief"]} {
        set type    choice
        set choices $vTcl(reliefs)
    }
    set label $top.$option
    label $label -text $text -anchor w -width 13 -fg black \
        -relief $vTcl(pr,proprelief) \
        -activebackground $vTcl(analog_color_m) \
           -foreground $vTcl(actual_fg)  ;# Rozen
    # button $label -text $text -anchor w -width 11 -fg black \
    #     -relief $vTcl(pr,proprelief) \
    #        -foreground $vTcl(actual_gui_fg)  ;# Rozen
    set focusControl $base   ;# Again this will be the entry field.
    # The option spec "-insertborderwidth 3" below makes cursor
    # visible when bg is dark.
    # the validation options to increment vTcl(change) added to entry
    # widgets below by Rozen. vTcl:incr_change in misc.tcl. 12/2/17
    switch $type {
        boolean {
            frame $base
                #-selectcolor black
            vTcl:boolean_radio ${base}.y \
                -variable $variable -value 1 -text "Yes" -relief sunken  \
                -command "
            #incr vTcl(change)
            $config_cmd \$vTcl(w,widget) $option $variable {} $config_args" \
                -padx 0 -pady 1
                #-selectcolor black
            vTcl:boolean_radio ${base}.n \
                -variable $variable -value 0 -text "No" -relief sunken  \
                -command "
            $config_cmd \$vTcl(w,widget) $option $variable {} $config_args" \
                -padx 0 -pady 1
            pack ${base}.y ${base}.n -side left -expand 1 -fill both
        }
        combobox {
            frame $base
            ComboBox ${base}.c -width 8 -editable 0 \
                -modifycmd "vTcl:prop:combo_select ${base}.c $option" \
                -foreground #000000             ;# NEEDS WORK dark
            pack ${base}.c -side left -fill x -expand 1
            set focusControl ${base}.c
            if {[trace vinfo ::$variable] == ""} {
                trace variable ::$variable w \
                    "vTcl:prop:combo_update ${base}.c $variable"
            } else {
                vTcl:prop:combo_update ${base}.c $variable
            }
        }
        ;# NEEDS WORK  work  fg option
        choice {
            ComboBox ${base} -editable 0 -width 12 -values $choices \
                -foreground black \
                -modifycmd "
               #incr vTcl(change)
               vTcl:prop:choice_select ${base} $variable
               $config_cmd \$vTcl(w,widget) $option $variable {} $config_args"
            trace remove variable ::$variable write \
                  "vTcl:prop:choice_update ${base} $variable"
                   #${base} configure -bg #d9d9d9 $ -fg #000000"
                   # ${base} configure -bg white"
            trace variable ::$variable w \
                  "vTcl:prop:choice_update ${base} $variable"
            vTcl:prop:choice_update ${base} $variable
        }
        menu {
            button $base \
                -text "<click to edit>" -relief sunken  -width 12 \
                -highlightthickness 1 -fg black -padx 0 -pady 1 \
                -command "
                    #incr vTcl(change)
                    focus $base
                    vTcl:propmgr:select_attr $top $option
                    set current \$vTcl(w,widget)
                    vTcl:edit_target_menu \$current
                    set $variable \[\$current cget -menu\]
                    vTcl:prop:save_opt \$current $option $variable" \
                -anchor w -background #d9d9d9          ;# NEEDS WORK dark
        }
        menuspecial {
            button $base \
                -text "<click to edit>" -relief sunken  -width 12 \
                -highlightthickness 1 -fg black -padx 0 -pady 1 \
                -command "
                    vTcl:propmgr:select_attr $top $option
                    set current \$vTcl(w,widget)
                    vTcl:edit_menu \$current
                    vTcl:prop:save_opt \$current $option $variable" \
                -anchor w
        }
        color {
            frame $base
            vTcl:entry ${base}.l -relief sunken  \
                -textvariable $variable -width 8 \
                -highlightthickness 1 -fg black -insertborderwidth 3
            bind ${base}.l <KeyRelease-Return> \
                "$config_cmd \$vTcl(w,widget) $option $variable {} $config_args
                 ${base}.f configure -bg \$$variable"
            button ${base}.f \
                -image ellipses  -width 12 \
                -highlightthickness 1 -fg black -padx 0 -pady 1 \
                -command "
                   vTcl:propmgr:select_attr $top $option
                   vTcl:show_color $top.t${option}.f $option $variable ${base}.f
                   vTcl:prop:save_opt \$vTcl(w,widget) $option $variable"
            vTcl:prop:color_update ${base}.f [set $variable]
            pack ${base}.l -side left -expand 1 -fill x
            pack ${base}.f -side right -fill y -pady 1 -padx 1
            set focusControl ${base}.l
        }
        validatecommand {
            frame $base
            vTcl:entry ${base}.l -relief sunken  \
                -textvariable $variable -width 8 \
                -highlightthickness 1 -fg black  -insertborderwidth 3
                #-validate focusout -validatecommand {vTcl:test_val %P %W}
            bind ${base}.l <KeyRelease-Return> \
                "$config_cmd \$vTcl(w,widget) $option $variable {} $config_args
                 #${base}.f configure -bg \$$variable
                 vTcl:prop:create_dummy_function \$$variable "
            pack ${base}.l -side left -expand 1 -fill x
            set focusControl ${base}.l
        }
        command {
            frame $base
            vTcl:entry ${base}.l -relief sunken  \
                -textvariable $variable -width 8 \
                -highlightthickness 1 -fg black  -insertborderwidth 3
            pack ${base}.l -side left -expand 1 -fill x
            set focusControl ${base}.l
        }
        font {
            frame $base
            vTcl:entry ${base}.l -relief sunken  \
                -textvariable $variable -width 8 \
                -highlightthickness 1 -fg black  -insertborderwidth 3
            button ${base}.f \
                -image ellipses  -width 12 \
                -highlightthickness 1 -fg black -padx 0 -pady 1 \
                -command "
                    #incr vTcl(change)
                    vTcl:propmgr:select_attr $top $option
                    vTcl:font:prompt_user_font \$vTcl(w,widget) $option
                    vTcl:prop:save_opt \$vTcl(w,widget) $option $variable"
            pack ${base}.l -side left -expand 1 -fill x
            pack ${base}.f -side right -fill y -pady 1 -padx 1
            ::vTcl::ui::attributes::show_color ${base}.f \
                vTcl(pr,bgcolor) ;# Rozen 2-3-13
            set focusControl ${base}.l
        }
        image {
            frame $base
            vTcl:entry ${base}.l -relief sunken  \
                -textvariable $variable -width 8 \
                -highlightthickness 1 -fg black  -insertborderwidth 3 \
                -state disabled -disabledbackground $vTcl(pr,disablebg) \
                -disabledforeground $vTcl(pr,disablefg)
            button ${base}.f \
                -image ellipses  -width 12 \
                -highlightthickness 1 -fg black -padx 0 -pady 1 \
                -command "
                    #incr vTcl(change)
                    ${base}.l configure -state normal
                    vTcl:propmgr:select_attr $top $option
                    vTcl:prompt_user_image \$vTcl(w,widget) $option
                    vTcl:prop:save_opt \$vTcl(w,widget) $option $variable
                    ${base}.l configure -state disabled"
            pack ${base}.l -side left -expand 1 -fill x
            pack ${base}.f -side right -fill y -pady 1 -padx 1
            set focusControl ${base}.l
        }
        default {
            # Part of making text appear in ttk widgets when the text
            # variable is specified.
            if {$option in  {"-text" "-textvariable"}} {
                # if {$vTcl(w,class) eq "TLabel"} { }
                if {$vTcl(w,class) in
                    {TButton TLabel TCheckbutton TRadiobutton}} {
                    set widget_text [$vTcl(w,widget) cget -text]
                    set vTcl(w,opt,text) $widget_text
                }
            }
            # The value of $variable, not Variable, for geometric
            # attributes is set in vTcl:update_widget_values in
            # widget.tcl. See second long comment in
            # vTcl:prop:update_attr.
            vTcl:entry $base \
                -textvariable $variable -width 12 -highlightthickness 1 \
                -foreground black \
                -background #d9d9d9          ;# NEEDS WORK dark
         }
    }

    ## Append the label to the list for this widget and add the focusControl
    ## to the lookup table.  This is used when scrolling through the property
    ## manager with the directional keys.  We don't want to append geometry
    ## options, we just handle them later.
    set c [vTcl:get_class $vTcl(w,widget)]
    if {!$isGeomOpt} {
        lappend vTcl(propmgr,labels,$c) $label
    } else {
        lappend vTcl(propmgr,labels,$vTcl(w,manager)) $label
    }
    set propmgrLabels($label) $focusControl
    ## If they clunderick the label, select the focus control.
    bind $label <Button-1> "focus $focusControl"
    bind $label <Enter> "
        if {\[vTcl:streq \[$label cget -relief] $vTcl(pr,proprelief)]} {
            $label configure -relief raised
        }"
    bind $label <Leave> "
        if {\[vTcl:streq \[$label cget -relief] raised]} {
            $label configure -relief $vTcl(pr,proprelief)
        }"
    ## If they click Button-3 on the label, show the context menu. No
    ## right-click for geometry or widget options is currently
    ## provided. I subsequently added "-x", "-y", "-height", and
    ## "-width" 7/23/19.
    if {$type == "color"} {set b ${base}.f} else {set b ""}
    if {!$isGeomOpt} {
        bind $label <ButtonRelease-3> \
            "vTcl:propmgr:show_rightclick_menu $vTcl(gui,ae) $option \
                                                     $variable %X %x %Y $b"
        # bind $label <Enter> "$label configure -bg $vTcl(actual_bg_analog)"
        bind $label <Enter> "$label configure -bg $vTcl(activebacground_color)"
        bind $label <Leave> "$label configure -bg $vTcl(actual_bg)"
    } elseif {$option in $vTcl(geom_option_list)} {
        bind $label <ButtonRelease-3> \
            "vTcl:propmgr:show_rightclick_menu $vTcl(gui,ae) $option \
                                                         $variable %X %x %Y"
        # bind $label <Enter> "$label configure -bg $vTcl(actual_bg_analog)"
        bind $label <Enter> "$label configure -bg $vTcl(activebacground_color)"
        bind $label <Leave> "$label configure -bg $vTcl(actual_bg)"
    }

    bind after_$focusControl <FocusIn>    \
        "vTcl:propmgr:select_attr $top $option"
    bind after_$focusControl <FocusOut>   \
        "#vTcl:propmgr:check_and_update $top $option
        vTcl:focus_out_cmd"
    bind $focusControl <MouseWheel> \
        "vTcl:propmgr:scrollWheelMouse %D $label"
    # NEEDS WORK - I may have created a problem when changing
    # \$vTcl(w,widget) to \$vTcl(w,widget) below.
    bind after_$focusControl <KeyRelease> \
        "vTcl:key_release_cmd %k $config_cmd \
         \$vTcl(w,widget) $option $variable $config_args"
    # Following is the binding that can send the attribute change to a
    # routine like vTcl:prop:geom_config_cmd.
    bind after_$focusControl <KeyRelease-Return> \
       "$config_cmd \$vTcl(w,widget) $option $variable {} $config_args"
    bind after_$focusControl <Key-Up> \
        "vTcl:propmgr:focusPrev $label"
    bind after_$focusControl <Key-Down> \
        "vTcl:propmgr:focusNext $label"
    bindtags $focusControl "[bindtags $focusControl] after_$focusControl"

    if {[vTcl:streq $prefix "opt"]} {
        set saveCheck [checkbutton ${base}_save -pady 0]
        vTcl:set_balloon $saveCheck "Check to save option"
        grid $top.$option $base $saveCheck -sticky news
    } else {
        grid $top.$option $base -sticky news
        global tcl_platform
        ## If we're on windows, we need geometry labels to be padded a little
        ## to match the rest of the labels in the options.
        if {$tcl_platform(platform) == "windows"} {
            $label configure -pady 4
        }
    }
}

proc debug_b {target cnt} {
    set bindlist [lsort [bind $target]]
    foreach i $bindlist {
        set command [bind $target $i]
    }
}

proc vTcl:prop:enable_manager_entry {option state} {
    global vTcl
    if {![winfo exists $vTcl(gui,ae)]} return

    set fr $vTcl(gui,ae,canvas).f3.f
    set top $fr._$vTcl(w,manager)

    set base $top.t${option}

    array set background [list normal $vTcl(pr,entrybgcolor) disabled gray]

    ## makes sure the property entry does exist
    if {[winfo exists $base]} {
        # $base configure -state $state -bg $background($state)
        catch {$base configure -state $state -bg $background($state)} ;# Rozen
    }
}

# Debugging stuff delete
proc vTcl:test_val {str widget} {
    $widget configure -bg plum
    return 1
}

proc vTcl:prop:clear {} {
    global vTcl

    if {![winfo exists $vTcl(gui,ae)]} return

    #vTcl:propmgr:deselect_attr

    if {![winfo exists $vTcl(gui,ae,canvas)]} {
        frame $vTcl(gui,ae,canvas)
        pack $vTcl(gui,ae,canvas)
    }
    foreach fr {f2 f3} {
        set fr $vTcl(gui,ae,canvas).$fr
        if {![winfo exists $fr]} {
            frame $fr
            pack $fr -side top -expand 1 -fill both
        }
    }

    ## Destroy and rebuild the Attributes frame
    set fr $vTcl(gui,ae,canvas).f2.f
    catch {destroy $fr}
    frame $fr; pack $fr -side top -expand 1 -fill both

    ## Destroy and rebuild the Geometry frame
    set fr $vTcl(gui,ae,canvas).f3.f
    catch {destroy $fr}
    frame $fr; pack $fr -side top -expand 1 -fill both

    set vTcl(w,widget)  {}
    set vTcl(w,insert)  {}
    set vTcl(w,class)   {}
    set vTcl(w,alias)   {}
    set vTcl(w,manager) {}

    update
    vTcl:prop:recalc_canvas
}

###
## Update all the option save checkboxes in the property manager.
###
proc vTcl:prop:update_saves {w} {
    global vTcl
    set c $vTcl(gui,ae,canvas)
    set class [vTcl:get_class $w]
    ## special options support
    set spec_opts ""
    if {[info exist ::classoption($class)]} {
        set spec_opts $::classoption($class)
    }
    foreach opt [concat $vTcl(w,optlist) $spec_opts] {

        set check $c.f2.f._$class.t${opt}_save
        if {![winfo exists $check]} { continue }
        $check configure -variable ::widgets::${w}::save($opt)
    }
}

###
## Update the checkbox for an option in the property manager.
##
## If the option becomes the default option, we uncheck the checkbox.
## This will save on space because we're not storing options we don't need to.
###
proc vTcl:prop:save_opt {w opt varName} {
    if {[vTcl:streq $w "."]} { return }
    upvar #0 $varName var
    vTcl:WidgetVar $w options
    vTcl:WidgetVar $w defaults
    vTcl:WidgetVar $w save
    if {![info exists options($opt)]} { return }
    if {[vTcl:streq $options($opt) $var]} { return }
    set options($opt) $var
    if {$options($opt) == $defaults($opt)} {
        set save($opt) 0
    } else {
        set save($opt) 1
    }
    vTcl:change
}

proc vTcl:prop:save_opt_value {w opt value} {
    if {[vTcl:streq $w "."]} { return }
    vTcl:WidgetVar $w options
    vTcl:WidgetVar $w defaults
    vTcl:WidgetVar $w save
    if {![info exists options($opt)]} { return }
    if {[vTcl:streq $options($opt) $value]} { return }

    set options($opt) $value
    if {$options($opt) == $defaults($opt)} {
        set save($opt) 0
    } else {
        set save($opt) 1
    }
    vTcl:change
}

proc vTcl:propmgr:select_attr {top opt} {
    global vTcl
    vTcl:propmgr:deselect_attr
    #$top.$opt configure -relief sunken
    set vTcl(propmgr,lastAttr) [list $top $opt]
    set vTcl(propmgr,opt) $opt
}

proc vTcl:propmgr:deselect_attr {} {
    global vTcl
    if {![info exists vTcl(propmgr,lastAttr)]} { return }
    catch {
        [join $vTcl(propmgr,lastAttr) .] configure -relief $vTcl(pr,proprelief)}
    unset vTcl(propmgr,lastAttr)
}

proc vTcl:propmgr:focusOnLabel {w dir} {
    global vTcl propmgrLabels
    set m $vTcl(w,manager)
    set c [vTcl:get_class $vTcl(w,widget)]
    set list [concat $vTcl(propmgr,labels,$c) $vTcl(propmgr,labels,$m)]

    set ind [lsearch $list $w]
    incr ind $dir

    if {$ind < 0} { return }

    set next [lindex $list $ind]

    if {[lempty $next]} { return }

    ## We want to set the focus to the focusControl, but we want the canvas
    ## to scroll to the label of the focusControl.
    focus $propmgrLabels($next)

    vTcl:propmgr:scrollToLabel $vTcl(gui,ae,canvas) $next $dir
}

proc vTcl:propmgr:focusPrev {w} {
    vTcl:propmgr:focusOnLabel $w -1
}

proc vTcl:propmgr:focusNext {w} {
    vTcl:propmgr:focusOnLabel $w 1
}

proc vTcl:propmgr:scrollToLabel {c w units} {
    global vTcl
    set split [split $w .]
    set split [lrange $split 0 5]
    set frame [join $split .]

    if {$units > 0} {
    set offset [expr 2 * [winfo height $w]]
    } else {
    set offset [winfo height $w]
    }
    lassign [$c cget -scrollregion] foo foo cx cy
    lassign [vTcl:split_geom [winfo geometry $w]] foo foo ix iy
    set yt [expr $iy.0 + $vTcl(propmgr,frame,$frame) + $offset]
    lassign [$c yview] topY botY
    set topY [expr $topY * $cy]
    set botY [expr $botY * $cy]

    ## If the total new height is lower than the current view, scroll up.
    ## If the total new height is higher than the current view, scroll down.
    if {$yt < $topY || $yt > $botY} {
    $c yview scroll $units units
    }
}

proc vTcl:propmgr:show_rightclick_menu {base option variable X x Y {button {}}} {
    # Put up the context menu when user hit label in ae with B-3.
    # button will be non "" only when the attribute we are dealing
    # with is of type color. Added to parameter to handle background
    # colors of ellipsis buttons in the ae.
    global vTcl

    if {[winfo exists $base.menu_rightclk]} {
        destroy $base.menu_rightclk
    }
    #if {![winfo exists $base.menu_rightclk]} {
        menu $base.menu_rightclk -tearoff 0
        if {$option ni $vTcl(geom_option_list)} {
            $base.menu_rightclk add cascade \
                -menu "$base.menu_rightclk.men22" \
                -label {Reset to default}
            $base.menu_rightclk add separator
        }

        $base.menu_rightclk add cascade \
            -menu "$base.menu_rightclk.men26" -accelerator {} -command {} \
            -font {} \
            -label {Apply to}


        ###############################
        # The men26 submenu for "Apply"
        ###############################
        menu $base.menu_rightclk.men26 -tearoff 0

        $base.menu_rightclk.men26 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          multi vTcl:prop:set_opt \
                          [set $::vTcl::_rclick_variable]
                            set vTcl(change) 1
            } \
            -label {All Multi Select Widgets}

        $base.menu_rightclk.men26 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          all vTcl:prop:set_opt \
                          [set $::vTcl::_rclick_variable]
                            set vTcl(change) 1
            } \
            -label {All Widgets in Toplevel}


        $base.menu_rightclk.men26 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          frame vTcl:prop:set_opt \
                          [set $::vTcl::_rclick_variable]
                            set vTcl(change) 1
            } \
            -label {All Same Class in Parent}

        $base.menu_rightclk.men26 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          toplevel vTcl:prop:set_opt \
                          [set $::vTcl::_rclick_variable]
                            set vTcl(change) 1
            } \
            -label {All Same Class in Toplevel}


        ###############################
        # men22 is the default submenu.
        ###############################
        menu $base.menu_rightclk.men22 -tearoff 0

        $base.menu_rightclk.men22 add command \
            -accelerator {} \
            -command {vTcl:prop:default_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable
                if {$::vTcl::_rclick_button ne ""} {
                    vTcl:prop:color_update $::vTcl::_rclick_button \
                        [set $::vTcl::_rclick_variable]
                }
                set vTcl(change) 1
            } \
            -label {This Widget}

        #$base.menu_rightclk.men22 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          subwidgets vTcl:prop:default_opt} \
            -label {Same Class Subwidgets}

        $base.menu_rightclk.men22 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          multi vTcl:prop:default_opt
                          set vTcl(change) 1} \
            -label {All Multi Select Widgets}

        $base.menu_rightclk.men22 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          frame vTcl:prop:default_opt
                # Following if block sets set the background color of
                # the ellipsis button to the default color when we are
                # playing with an attribute of type color. Repeated below.
                if {$::vTcl::_rclick_button ne ""} {
                    vTcl:prop:color_update $::vTcl::_rclick_button \
                        [set $::vTcl::_rclick_variable]
                }
                set vTcl(change) 1
            } \
            -label {All Same Class, same Parent}


        $base.menu_rightclk.men22 add command \
            -accelerator {} \
            -command {vTcl:prop:apply_opt $vTcl(w,widget) \
                          $::vTcl::_rclick_option $::vTcl::_rclick_variable \
                          toplevel vTcl:prop:default_opt
                if {$::vTcl::_rclick_button ne ""} {
                    vTcl:prop:color_update $::vTcl::_rclick_button \
                        [set $::vTcl::_rclick_variable]
                }
                set vTcl(change) 1
            } \
            -label {All Same Class, Toplevel}


    #}
    # These global (?) are set to be available to the menu commands above.
    set ::vTcl::_rclick_option   $option
    set ::vTcl::_rclick_variable $variable
    set ::vTcl::_rclick_button $button
    tk_popup $base.menu_rightclk [expr $X - $x] $Y
}

# This proc resets a given option to its default value
# The goal is to help making cross-platform applications easier by
# only saving options that are necessary

proc vTcl:prop:default_opt {
            w opt varName {user_param {}} {index {}} {force_save {}}} {
    # Rozen. I added the three parameters user_param, index, and
    # force_save as I was trying to get the menu stuff to work
    # correctly.  This all seems to have be required since I want to
    # be able to specify new defaults for menu colors and fonts. (Such
    # defaults are set by the user in the Preferences dialog using the
    # Fonts and Colors tabs.)  Since these defaults are not known to Tk
    # I have to force them. In those cases I call this routine from
    # ::menu_edit::set_menu_item_defaults in menus.tcl with the
    # 'user_param' set to the default that I want to use.  Since this
    # value has to into the configuration of the menu item, I pass the
    # non-blank 'index' argument.  Normally, when setting the default
    # one then does not need to set the value of the save variable
    # unless the user changes it.  However with the menu stuff Tk
    # would get the default wrong, so we always want to save it, so I
    # pass in the non-blank 'force_save'.

    # The strange variable defaults($opt) are set in
    # vTcl:widget:register_widget located in widget.tcl
    global vTcl
    upvar #0 $varName var
    vTcl:WidgetVar $w options
    vTcl:WidgetVar $w defaults
    vTcl:WidgetVar $w save
    if {![info exists options($opt)]} { return }
    if {![info exists defaults($opt)]} { return }
    # only refresh the attribute editor if this is the
    # current widget, otherwise we'll get into trouble
    if {$defaults($opt) eq ""} { return }
    if {[string first ".bor" $w] > -1} {
        # This test because we may have selected a widget in borrowee.
        return
    }
    if {$w == $vTcl(w,widget)} {
        # Here is where var got changed.
        set var $defaults($opt)
    }
    # Really suspicious of the user_param if block.
    if {$user_param != ""} { ;# Rozen
        set defaults($opt) $user_param
    }
    if {$index != ""} {          # Added by Rozen to set options of menu entries.
        $w entryconfigure $index $opt $defaults($opt)
    } else {
        $w configure $opt $defaults($opt)
    }
    set options($opt) $defaults($opt)
    if {$force_save != ""} {  ;# Rozen
        set save($opt) 1
    } else {
        set save($opt) 0
    }
    vTcl:change
}

# This proc applies an option to a widget

proc vTcl:prop:set_opt {w opt varName value} {
    global vTcl
    upvar #0 $varName var
    set parent [winfo parent $w]
    set parent_class [vTcl:get_class $parent]
    if {$parent_class in {TNotebook PNotebook}} {
         if {$opt in {-x -y}} {
             return
         }
     }
    vTcl:WidgetVar $w options
    vTcl:WidgetVar $w defaults
    vTcl:WidgetVar $w save
    # if {$opt != "-y" && $opt != "-x"} { ... }
    if {$opt ni $vTcl(geom_option_list)} {
        if {![info exists options($opt)]} { return }
        if {![info exists defaults($opt)]} { return }
    }
    # Switch borrowed from vTcl:prop:geom_config_mgr in propmgr.tcl
    set option $opt
    set widget $w
    set target $widget
    set conf [place configure $target]
    vTcl:convert_for_geom_option $target $option
            switch -exact $option {
                -relx {
                    place configure $target $option $value -x 0
                }
                -rely {
                    place configure $target $option $value -y 0
                }
                -relwidth {
                    place configure $target $option $value -width 0
                }
                -relheight {
                    place configure $target $option $value -height 0
                }
                -width {
                    place configure $target $option $value -relwidth 0
                }
                -height {
                    place configure $target $option $value -relheight 0
                }
                -x {
                    place configure $target $option $value -relx 0
                }
                -y {
                    place configure $target $option $value -rely 0
                }
                default {
                    $widget configure $option $value
                }
            }
    update
    set t_mode [vTcl:get_mode $target]
    if {$t_mode ne $vTcl(mode)} {
        vTcl:convert_widget $target
    }
    # $w configure $opt "$value"
    set options($opt) "$value"

    # only refresh the attribute editor if this is the
    # current widget, otherwise we'll get into trouble

    if {$w == $vTcl(w,widget)} {
    set var $value
    }

    # if {$opt != "-x" && $opt != "-y"} { ... }
    if {$opt ni $vTcl(geom_option_list)} {
        if {$value == $defaults($opt)} {
            set save($opt) 0
        } else {
            set save($opt) 1
        }
    }
}

proc vTcl:prop:save_or_unsave_opt {w opt varName save_or_not} {
    vTcl:WidgetVar $w options
    vTcl:WidgetVar $w save

    if {![info exists options($opt)]} { return }

    set save($opt) $save_or_not
    vTcl:change
}

# Apply options settings to a range of widgets of the same
# class as w
#
# Parameters:
#   w         currently selected widget
#   opt       the option to change (eg. -background)
#   varName   name of variable for display in attributes editor
#   extent    which widgets to modify; can be one of
#         frame
#         apply to given widget and all in same parent
#             subwidgets
#                 apply to given widget and all its subwidgets
#             toplevel
#                 apply to all widgets in toplevel containing given widget
#             all
#                 apply to all widgets in the current project
#   action    name of proc to call for each widget
#             this callback proc should have the following parameters:
#                 w          widget to modify
#                 opt        option name (eg. -cursor)
#                 varName    name of variable in attributes editor
#                 user_param optional parameter
#   user_param
#             value of optional user parameter

proc vTcl:prop:apply_opt {w opt varName extent action {user_param {}}} {
    global vTcl
    set class [vTcl:get_class $w]
    switch $extent {
        subwidgets {
            # 0 because we don't want information for widget tree display
            set widgets [vTcl:complete_widget_tree $w 0]
        }
        toplevel {
            set top [winfo toplevel $w]
            # Changed below because there may be borrowing going on
            # and if so we want to get the widget in the primary tree.
            # We'll throw out the widgets in the borrowed tree below.
            # set widgets [vTcl:complete_widget_tree $top 0]
            set widgets [vTcl:complete_widget_tree . 0]
        }
        all {
            set widgets [vTcl:complete_widget_tree . 0]
        }
        frame {
            set widgets [list]
            set man  [winfo manager $w]
            set par  [winfo parent $w]
            if {$man == "grid" || $man == "pack" || $man == "place"} {
                set widgets [$man slaves $par]
            }
        }
        multi {
            set widgets $vTcl(multi_select_list)
        }
    }

    foreach widget $widgets {
        if {[string first ".bor" $widget] > -1} {
            continue
        }
        if {[string first "vTH" $widget] > -1} {
            continue
        }
        set parent [winfo parent $widget]
        set parent_class [vTcl:get_class $parent]
        # if {$parent_class eq "TNotebool" || $parent_class eq "TPanedwindow"} {
        #     continue
        # }
        if {$parent_class eq "TPanedwindow"} {
            continue
        }
        if {$extent == "all"} {
            if {[vTcl:get_class $widget] != "Toplevel"} {
                $action $widget $opt $varName $user_param
            }
        } elseif {$extent == "subwidgets"} {
            if {$widget != $w} {
                $action $widget $opt $varName $user_param
            }
        } elseif {$extent == "multi"} {
            $action $widget $opt $varName $user_param
            # update multi select handles.
            vTcl:multi_destroy_handles $widget
            vTcl:multi_create_handles $widget
        } else {
            if {[vTcl:get_class $widget] == $class} {
                $action $widget $opt $varName $user_param
            }
        }
    }
    vTcl:create_handles $vTcl(w,widget)
}

proc vTcl:propmgr:scrollWheelMouse {delta label} {
    if {$delta > 0} {
        vTcl:propmgr:focusPrev $label
    } else {
        vTcl:propmgr:focusNext $label
    }
}

namespace eval ::vTcl::properties {

    proc setAlias {target aliasVar entryWidget} {
        global vTcl
        if {![winfo exists $target]} return

        set alias [set $aliasVar]
        if {[info exists ::widget(rev,$target)]} {
            set old_alias $::widget(rev,$target)
        }

        ## has the alias changed ? no, really, just asking
        if {[info exists ::widget(rev,$target)] &&
            $::widget(rev,$target) == $alias} {
            return
        }
        set valid [vTcl:valid_alias $target $alias]
        if {!$valid} {
            ## disable focusOut binding before showing message box
            set oldBind [bind $entryWidget <FocusOut>]

            ## now we can show the message box
            #if {$alias == 0} {
                # ::vTcl::MessageBox -message "Alias '$alias' already exists." \
                #     -title "Invalid Alias" \
                #     -icon error
                #     -type ok
            #}
            #if {$alias == -1} {
                # ::vTcl::MessageBox -icon error \
                #     -title "Invalid Alias" \
                #     -message "Selected Alias is a Tcl/Tk command name." \
                #     -type ok
            #}
            ## restore focusOut binding after message box is dismissed
            bind $entryWidget <FocusOut> $oldBind
            set vTcl(w,alias) $old_alias
            return
        }
        ## user wants to unset alias?
        if {$alias == ""} {
            vTcl:unset_alias $target
        } else {
            # Set the alias but first get rid of the old alias
            # set toplevel [vTcl:get_top_level_or_alias $target]
            # if {[info exists widget(toplevel,$old_alias)]} {
            #     unset  widget(toplevel,$old_alias)
            # }
            vTcl:set_alias $target $alias
        }
    }
}

proc vTcl:prop:create_dummy_function {cmd} {
    if {[string first " " $cmd] > -1} {
        # Parameters present, want just the command.
        set split_cmd [split $cmd]
        set piece [lindex $split_cmd 0]
    } else {
        set piece $cmd
    }
    lappend vTcl(validate_functions) $piece
    proc $piece {args} {
        return 1
   }
}

proc vTcl:propmgr:check_and_update {top option} {
    global vTcl
return
    set class [vTcl:get_class $vTcl(w,widget)]
    set lc_class [string tolower $class]
    set old_value [$vTcl(w,widget) cget $option]
    set new_value [$top get]
}


# Bottom
#######################################################

#      Bone Pile from vTcl:propmgr:show_rightclick_menu

#######################################################

# #        $base.menu_rightclk add separator

# #        $base.menu_rightclk add cascade \
#             -menu "$base.menu_rightclk.men24" -accelerator {} -command {} \
#             -font {} \
#             -label {Do not save option for}





# #        menu $base.menu_rightclk.men24 -tearoff 0

# #        $base.menu_rightclk.men24 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           subwidgets vTcl:prop:save_or_unsave_opt \
#                           0} \
#             -label {Same Class Subwidgets}

# #        $base.menu_rightclk.men24 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           frame vTcl:prop:save_or_unsave_opt \
#                           0} \
#             -label {All Same Class Widgets in same Parent}

# #        $base.menu_rightclk.men24 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           toplevel vTcl:prop:save_or_unsave_opt \
#                           0} \
#             -label {All Same Class Widgets in toplevel}

# #    $base.menu_rightclk.men24 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           all vTcl:prop:save_or_unsave_opt \
#                           0} \
#             -label {All Same Class Widgets in this project}

# #        $base.menu_rightclk add cascade \
#             -menu "$base.menu_rightclk.men25" -accelerator {} -command {} \
#             -font {} \
#             -label {Save option for}

# Save for stuff.

# #        menu $base.menu_rightclk.men25 -tearoff 0

# #        $base.menu_rightclk.men25 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           subwidgets vTcl:prop:save_or_unsave_opt \
#                           1} \
#             -label {Same Class Subwidgets}

# #        $base.menu_rightclk.men25 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           frame vTcl:prop:save_or_unsave_opt \
#                           1} \
#             -label {All Same Class Widgets in same Parent}

# #        $base.menu_rightclk.men25 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           toplevel vTcl:prop:save_or_unsave_opt \
#                           1} \
#             -label {All Same Class Widgets in toplevel}

# #        $base.menu_rightclk.men25 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           all vTcl:prop:save_or_unsave_opt \
#                           1} \
#             -label {All Same Class Widgets in this project}






# #        $base.menu_rightclk.men26 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           all vTcl:prop:set_opt \
#                           [set $::vTcl::_rclick_variable]} \
#             -label {All Same Class Widgets in this project}





# #        $base.menu_rightclk.men22 add command \
#             -accelerator {} \
#             -command {vTcl:prop:apply_opt $vTcl(w,widget) \
#                           $::vTcl::_rclick_option $::vTcl::_rclick_variable \
#                           all vTcl:prop:default_opt} \
#             -label {All Same Class Widgets in this project}

