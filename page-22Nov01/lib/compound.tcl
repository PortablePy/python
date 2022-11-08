##############################################################################
# $Id: compound.tcl,v 1.43 2003/05/05 03:46:35 cgavin Exp $
#
# compound.tcl - procedures for creating and inserting compound-widgets
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

##########################################################################
# Compound Widgets
#
# compound   = type options mgr-info bind-info children
# mgr-info   = geom-manager-name geom-info
# bind-info  = list of: {event} {command}
# menu-info  = list of: {type} {options}
# children   = list-of-compound-widgets (recursive)
#

# createCompound              Where Copy is handled.
# autoPlaceCompound           Where Paste is handled.
# insertCompound              Paste workhorse.

proc vTcl:save_compounds {} {
    set file [vTcl:get_file save "Save Compound Library"]
    if {$file == ""} {return}
    set f [open $file w]
    set ixwndex 0
    set all [vTcl::compounds::enumerateCompounds user]
    set num [llength $all]
    puts $f [subst $::vTcl(head,compounds)]
    foreach i $all {
        puts $f [vTcl:dump_namespace vTcl::compounds::user::$i]
        incr index
        vTcl:statbar [expr {($index * 100) / $num}]
    }
    close $f
    vTcl:statbar 0
}

proc vTcl:load_compounds {{file ""}} {
    global vTcl

    ## if a file is given in file parameter, use it,
    ## otherwise prompts for a file
    if {$file == ""} {
        set file [vTcl:get_file open "Load Compound Library"]
    }

    if {$file == ""} {return ""}
    if {![file exists $file]} {return ""}
    vTcl:statbar 10
    source $file
    vTcl:statbar 80
    vTcl:cmp_user_menu
    vTcl:statbar 0

    return $file
}

proc vTcl:name_replace {name s} {
    global vTcl
    foreach i $vTcl(cmp,alias) {
        set s [vTcl:replace [lindex $i 0] $name[lindex $i 1] $s]
    }
    return $s
}

proc vTcl:name_replace_list {name list} {
    global vTcl
    set result ""
    foreach s $list {
        foreach i $vTcl(cmp,alias) {
            set s [vTcl:replace [lindex $i 0] $name[lindex $i 1] $s]
        }
        lappend result $s
    }
    return $result
}

proc vTcl:put_compound {text compound} {
    global vTcl

    set rootclass [lindex [lindex $compound 0] 0]

    if {$vTcl(pr,autoplace) || $rootclass == "Toplevel"} {
        vTcl:auto_place_compound $compound $vTcl(w,def_mgr) {}
    return
    }

    vTcl:status "Insert $text"

    # because the bind commands does % substitution
    regsub -all % $compound %% compound

    bind vTcl(b) <Button-1> \
        "vTcl:store_cursor %W
         vTcl:place_compound [list $compound] $vTcl(w,def_mgr) %X %Y %x %y"
}

proc vTcl:auto_place_compound {compound gmgr gopt} {
    global vTcl
    set rootclass [lindex [lindex $compound 0] 0]
    if {$rootclass == "Toplevel"} {
        set class $rootclass
    } else {
        set class cpd
    }

    set name [vTcl:new_widget_name $class $vTcl(w,insert)]

    vTcl:insert_compound $name $compound $gmgr $gopt
    vTcl:setup_bind_widget $name
    vTcl:active_widget $name
    vTcl:update_proc_list

    # when new compound inserted into window, automatically
    # refresh widget tree

    vTcl:init_wtree
}

proc vTcl:place_compound {compound gmgr rx ry x y} {
    global vTcl

    vTcl:status Status

    vTcl:rebind_button_1

    set vTcl(w,insert) [winfo containing $rx $ry]

    set gopt {}
    if {$gmgr == "place"} { append gopt "-x $x -y $y" }

    vTcl:auto_place_compound $compound $gmgr $gopt
}

proc vTcl:insert_compound {name compound {gmgr pack} {gopt ""}} {
    global vTcl

    set cpd \{[lindex $compound 0]\}
    set alias [lindex $compound 1]
    set vTcl(cmp,alias) [lsort -decreasing -command vTcl:sort_cmd $alias]
    set cmd [vTcl:extract_compound $name $name $cpd 0 $gmgr $gopt]
    set do "$cmd"
    set undo "destroy $name"
    vTcl:push_action $do $undo
    lappend vTcl(widgets,[winfo toplevel $name]) $name

    # moved to widget creation inside compound
    # vTcl:widget:register_all_widgets $name
}

## -background #dcdcdc -text {foobar} ...
## =>
## -background -text ...

proc vTcl:options_only {opts} {

    set result ""

    set l [llength $opts]
    set i 0
    while {$i < $l} {
        lappend result [lindex $opts $i]
        incr i 2
    }

    return $result
}

proc vTcl:extract_compound {base name compound {level 0} {gmgr ""} {gopt ""}} {
    global vTcl widget classes
    set todo ""
    set childsiteproc ""
    foreach i $compound {
        set class [string trim [lindex $i 0]]
        set opts  [string trim [lindex $i 1]]
        set mgr   [string trim [lindex $i 2]]
        set mgrt  [string trim [lindex $mgr 0]]
        set mgri  [string trim [lindex $mgr 1]]
        set bind  [string trim [lindex $i 3]]
        set menu  [string trim [lindex $i 4]]
        set chld  [string trim [lindex $i 5]]
        set wdgt  [string trim [lindex $i 6]]
        set alis  [string trim [lindex $i 7]]
        set grid  [string trim [lindex $i 8]]
        set proc  [string trim [lindex $i 9]]
        set cmpdname [string trim [lindex $i 10]]
        set topopt   [string trim [lindex $i 11]]

        ## process procs first in case there are dependencies (init)
        foreach j $proc {
            set nme [lindex $j 0]
            set arg [lindex $j 1]
            set bdy [lindex $j 2]

            ## if the proc name is in a namespace, make sure namespace exists
        if {[string match ::${cmpdname}::* $nme]} {
                namespace eval ::${cmpdname} [list proc $nme $arg $bdy]
            } else {
                proc $nme $arg $bdy
            }

            ## there is a special procedure to paste a megawidget
            if {[string match __insert* $nme]} {
                set childsiteproc $nme
            } else {
                vTcl:list add "{$nme}" vTcl(procs)
            }
        }
        if {[lsearch -exact $vTcl(procs) "::${cmpdname}::init"] >= 0 } {
            eval [list ::${cmpdname}::init] $name
        }
        if {$mgrt == "wm" || $base == "."} {
            set base $name
        } elseif {$level == 0 && $gmgr != ""} {
            if {$gmgr != $mgrt || $gopt != ""}  {
                set mgrt $gmgr
                set mgri $gopt
            }
            if {$mgrt != "place"} {
                set mgri [lrange $mgri 2 end]
            }
        }
        if {$level > 0} {
            set name "$base$wdgt"
        } elseif {$class == "Toplevel"} {
            set vTcl(w,insert) $name
            lappend vTcl(tops) $name
            vTcl:update_top_list
        }

        ## for megawidgets, we insert the compound into an already existing
        ## frame, so if the base already exists, we skip it and insert children

        set was_existing  [winfo exists $name]
        if {!$was_existing} {
            set replaced_opts [vTcl:name_replace $base $opts]
            append todo "$classes($class,createCmd) $name $replaced_opts; "
        }
        if {$mgrt != "" && $mgrt != "wm"} {
            if {$mgrt == "place" && $mgri == ""} {
                set mgri "-x 5 -y 5"
            }
            if {!$was_existing} {
                append todo "$mgrt $name [vTcl:name_replace $base $mgri]; "
            }
        } elseif {$mgrt == "wm"} {
        } else {
            set ret $name
        }
        foreach j $topopt {
            set opt [lindex $j 0]
            set val [lindex $j 1]
            switch $opt {
                {} {}
                state {
                }
                title {
                    append todo "wm $opt $name \"$val\"; "
                }
                default {
                    append todo "wm $opt $name $val; "
                }
            }
        }

        ## megawidget childsites
        if {$childsiteproc != ""} {
            append todo "$childsiteproc $name; "
            append toto "rename $childsiteproc {}; "
        }

        if {!$was_existing} {

            ## widget registration
            append todo "vTcl:widget:register_widget $name; "

            ## restore default values
            set opts_only [vTcl:options_only $replaced_opts]
            foreach def $classes($class,defaultValues) {
                ## only replace the options not specified in the compound
                if {[lsearch -exact $opts_only $def] == -1} {
                    append todo "vTcl:prop:default_opt $name $def vTcl(w,opt,$def); "
                }
            }

            ## options not to save
            foreach def $classes($class,dontSaveOptions) {
                append todo "vTcl:prop:save_or_unsave_opt $name $def vTcl(w,opt,$def) 0; "
            }

            ## bindings
            foreach j $bind {
                # see if it is a list of bindtags, a binding for
                # the target, or a binding for a bindtag (ya follow me?)
                switch -exact -- [llength $j] {
                1 {
                    append todo "bindtags $name \[vTcl:unnormalize_bindtags $name [vTcl:name_replace $base $j]\];"
                }
                2 {
                    set e [lindex $j 0]
                    set c [vTcl:name_replace $base [lindex $j 1]]
                    append todo "bind $name $e \{$c\}; "
                }
                3 {
                    set bindtag [lindex $j 0]
                    set event   [lindex $j 1]
                    if {[lsearch -exact $::widgets_bindings::tagslist $bindtag] == -1} {
                        lappend ::widgets_bindings::tagslist $bindtag
                    }
                    append todo "if \{\[bind $bindtag $event] == \"\"\} \{bind $bindtag $event \{[lindex $j 2]\}\}; "
                }
                default {
                    oops "Internal error"
                        }
                }
            }
            foreach j $menu {
                set t [lindex $j 0]
                set o [lindex $j 1]
                if {$t != "tearoff"} {
                        append todo "$name add $t [vTcl:name_replace $base $o]; "
                }
            }
        }; ## if {!$was_existing} ...
        incr level
    if {$classes($class,dumpChildren)} {
        foreach j $chld {
           append todo "[vTcl:extract_compound $base $name \{$j\} $level]; "
        }
    }
        if {!$was_existing} {
            if {$alis != ""} {
                append todo "vTcl:set_alias $name \[vTcl:next_widget_name $class $name $alis\] -noupdate; "
            } elseif {$alis == "" && $vTcl(actual_autoalias)} {
                append todo "vTcl:set_alias $name \[vTcl:next_widget_name $class $name\] -noupdate; "
            }
        }; ## if {!$was_existing} ...

        foreach j $grid {
            set cmd  [lindex $j 0]
            set num  [lindex $j 1]
            set prop [lindex $j 2]
            set val  [lindex $j 3]
            append todo "grid $cmd $name $num $prop $val; "
        }

        if {[lsearch -exact $vTcl(procs) "::${cmpdname}::main"] >= 0 } {
        append todo "[list ::${cmpdname}::main] $name"
        }
    }

    return $todo
}

# in a list of bindtags, replace a toplevel bindtag by %top
# for example:
#    target   = ".top18.cpd19"
#    bindtags = "Frame .top18.cpd19 .top18 all"
# =>
#    returns    "Frame .top18.cpd19 %top all"

proc vTcl:normalize_bindtags {target bindtags} {

    set result ""
    foreach bindtag $bindtags {
        if {[winfo exists $bindtag] &&
            $bindtag == [winfo toplevel $target]} {
            lappend result %top
        } else {
            lappend result $bindtag
        }
    }

    return $result
}

# in a list of bindtags, replace %top by the toplevel of
# the given target, for example:
#    target = .top19.cpd20
#    bindtags = "Frame .top18.cpd19 %top all"
# =>
#    returns    "Frame .top18.cpd19 .top19 all"

proc vTcl:unnormalize_bindtags {target bindtags} {

    set result ""
    foreach bindtag $bindtags {
        if {$bindtag == "%top"} {
            lappend result [winfo toplevel $target]
        } else {
            lappend result $bindtag
        }
    }

    return $result
}

proc vTcl:append_alias {name alias} {

    global vTcl
    lappend vTcl(cmp,alias) "$name $alias"
}

proc vTcl:sort_cmd {el1 el2} {
    set l1 [string length [lindex $el1 0]]
    set l2 [string length [lindex $el2 0]]
    return [expr {$l1 - $l2}]
}

proc vTcl:replace {target replace source} {
    set ret ""
    set where [string first $target $source]
    if {$where < 0} {return $source}
    set len [string length $target]
    set before [string range $source 0 [expr {$where - 1}]]
    set after [string range $source [expr {$where + $len}] end]
    return "$before$replace$after"
}

proc vTcl:name_compound {t {name ""}} {
    global vTcl
    if {$t == "" || ![winfo exists $t]} {return ""}
    set ask_name 1
    while {$ask_name} {
        set name [vTcl:get_string "Name Compound" $t $name]
        if {$name == ""} {return ""}
        set ask_name 0
        if {[regexp \{|\}|\\\[|\\\] $name]} {
            ::vTcl::MessageBox -icon error \
              -title "Invalid Compound Name" \
              -message "A compound name cannot contain the following characters:\n\[\]\{\}"
            set ask_name 1
        }
    }

    ## selection of list of procs to include
    set proposedProcs ""
    foreach item $vTcl(procs) {
        if {[vTcl:valid_procname $item] &&
            ($item != "main") &&
            ($item != "init")} {
            lappend proposedProcs $item
        }
    }

    ## if there are no procs to include well just don't ask (duh)
    set includedProcs ""
    if {![lempty $proposedProcs]} {
        ## be nice and grab the list of procs if the compound exists
        set selectedProcs ""
        if {[::vTcl::compounds::existsCompound user $name]} {
            set selectedProcs [::vTcl::compounds::getProcs user $name]
        }
        set includedProcs [::vTcl::input::listboxSelect::select \
          $proposedProcs "Select Code for Compound" extended \
          -canceltext "No Code" \
          -headertext "Choose procedures to include with the compound.\nSelect 'No Code' if the compound doesn't contain code." \
          -selecteditems $selectedProcs]
    }

    ## if any of the included procs is in a namespace and ends with init
    ## or main, it is a special proc
    set initCmd ""
    set mainCmd ""
    foreach includedProc $includedProcs {
        if {[string match *::init $includedProc]} {
            set initCmd $includedProc
        }
        if {[string match *::main $includedProc]} {
            set mainCmd $includedProc
        }
    }

    eval [vTcl::compounds::createCompound $t user $name $includedProcs $initCmd $mainCmd]
    vTcl:cmp_user_menu

    ## return the name of the created compound for future use
    return [list user $name]
}

##########################################################################
## New Compound Widgets Technology Here

namespace eval ::vTcl::compounds {

    namespace eval system    {}
    namespace eval user      {}
    namespace eval clipboard {}

    proc existsCompound {type compoundName} {
        set spc ${type}::[list $compoundName]
        if {[info proc ${spc}::compoundCmd] != ""} {
            return 1
        }
        return 0
    }

    proc defineCompoundImages {target} {
        # This routine generates the code necessary to create the
        # image object that will be used after the "paste"
        # operation. The first thing it does is to determine just
        # which images are used by the widgets to be copied.
        # This has been extensively modified.
        global vTcl
        if {$target in $vTcl(multi_select_list)} {
            foreach w $vTcl(multi_select_list) {
                lappend used [::vTcl::widgets::usedResources $w image]
            }
        } else {
            lappend used [::vTcl::widgets::usedResources $target image]
        }
        if {[info exists vTcl(dump,userImages)]} {
            lappend used $vTcl(dump,userImages)
        }
        if {[lempty $used]} {
            return ""
        }
        append result [vTcl:image:dump_create_image_header $used]
        return $result
    }

    proc defineCompoundFonts {target} {
        set used [::vTcl::widgets::usedResources $target font]
        if {[lempty $used]} {
            return ""
        }

        set result "set fonts \{\n"
        foreach item $used {
            append result [vTcl:font:dump_create_font $item]
            append result "\n"
        }
        append result "\}\n\n"

        append result "proc fontsCmd \{target\} \{\n"
        append result "    variable fonts\n"
        append result "    foreach font \$fonts \{\n"
        append result "        vTcl:font:add_font "
        append result "\[lindex \$font  0\] \[lindex \$font  1\]\n\}\n"
        append result "\}\n\n"

        return $result
    }
        # Since I am not supporting compound widgets, I want to modify
        # this routine to simplify it to the extent that I can to
        # support only copy of copy-and-paste.


    proc createCompound {target type compoundName \
                             {procs {}} {initCmd {}} {mainCmd {}}} {
        # This function generates an internal function
        # "CompoundCmd" used by copy and paste.
        global vTcl
        set vTcl(copy_target) $target ;# Rozen
        ## we don't want handles to be enumerated with the widget
        vTcl:destroy_handles
        vTcl:multi_destroy_handles
        set output "\n"
        append output \
      "namespace eval \{::vTcl::compounds::${type}::[list $compoundName]\} \{\n"
        ## basic compound information
        set class [vTcl:get_class $target]
        set vTcl(copy_class) $class  ;# Rozen
        append output "\nset class $class\n"
        #append output "\nset source $target\n\n"

        ## append of version of vTcl:DefineAlias that is local to this namespace
        # NEEDS WORK - Rozen 2/27/18 dispensed with this.
        # append output "\n"
        # append output "proc vTcl:DefineAlias \{target alias args\} \{\n"
        # append output "    if \{!\[info exists ::vTcl(running)\]\} \{\n"
        # append output "        return \[eval ::vTcl:DefineAlias \$target \$alias \$args\]\n"
        # append output "    \}\n"
        # append output "    set class \[vTcl:get_class \$target\]\n"
        # append output "    vTcl:set_alias \$target \[vTcl:next_widget_name \$class \$target \$alias\] -noupdate\n"
        # append output "\}\n"
        # append output "\n"
        set ::vTcl(num,index) 0
        set ::vTcl(num,total) [llength [vTcl:list_widget_tree $target]]

        ## in addition, each toplevel has its own procedure
        if {$class == "Toplevel"} {
            append output [vTcl::widgets::core::toplevel::dumpTop $target]
            append output "\n"
        }

        ## a list of vTcl libraries which are used by the compound
        ;# NEEDS WORK tried removing 10/31.
        # set libraries [::vTcl::widgets::usedLibraries $target]
        # append output "    set libraries \{\n"
        # foreach library $libraries {
        #     append output "    $library\n"
        # }
        # append output "\}\n\n"

        ## a list of images/fonts used by the compound

        set tree [vTcl:complete_widget_tree]
        if {[info exists vTcl(dump,userImages)]} {
            unset vTcl(dump,userImages)
        }
        if {[info exists vTcl(dump,userFonts)]} {
            unset vTcl(dump,userFonts)
        }
        #        vTcl:dump:gather_widget_info
        foreach child $tree {
            if {[regexp {^\.pop} $child]} {
                    vTcl:get_images_and_fonts $child
            }
        }
        set imagesDef [defineCompoundImages $target]
        append output $imagesDef
        append output "\n\n"
        set fontsDef  [defineCompoundFonts $target]
        append output $fontsDef
        append output "\n"
        ## code to actually create the compound function
        append output "proc compoundCmd \{target\} \{\n"
        append output "$vTcl(tab)global vTcl\n"
        append output \
            "$vTcl(tab)regexp \{^\\.top\\d+\} \$target top_part\n"
        append output "$vTcl(tab)set top \$top_part\n"
        append output "$vTcl(tab)set base \$top_part\n"
#append output "dpr target top_part top base\n"
        if {$initCmd != ""} {
            append output "    $initCmd \$target\n\n"
        }
        # if {$imagesDef != ""} {
        #     append output "    imagesCmd \$target\n"
        # }
        if {$fontsDef != ""} {
            append output "    fontsCmd \$target\n"
        }
        if {$class == "Toplevel"} {
            append output "    vTclWindow$target \$target\n"
        } elseif {$class eq "Menu"} {
            append output "    # inserted by createCompound \n"
           append output "    set items \[split \$target .\]\n"
           append output "    set parent \[join \[lrange \$items 0 end-1\] .\]\n"
           append output "    set mod_target \[lindex \$items 1\]\n"
           # append output "    set menu \[lindex \$items 1\]\n"
           append output "    set menu \$vTcl(copy_menu)\n"
           # append output "    set top \[winfo toplevel \$parent\]\n"
           append output "    set top \$target\n"
            # This is where we do the actual output of the widget.
#append output "dpr target menu\n"
#append output "# spot Z\n"
            append output "[$::classes($class,dumpCmd) $target \$target]\n"
            append output_new "[$::classes($class,dumpCmd) $target \$target]\n"
        } else {
            append output "[$::classes($class,dumpCmd) $target \$target]\n"
            append output_new "[$::classes($class,dumpCmd) $target \$target]\n"
        }
        if {$mainCmd != ""} {
            append output "    $mainCmd \$target\n"
        }
        if {$vTcl(copy)} {
            set pieces [split $target "."]
            set last_piece [lrange $pieces end end]
            if {$class == "Menu"} {
                # This ties the menu to the toplevel.
                append output \
                    "$vTcl(tab)\$top configure -menu \$\{top\}\$\{menu\}\n"
                #append output "$vTcl(tab)\$top configure -menu \"\$top.m33\"\n"
            }
        }
        append output "\}\n\n"
        ## remembers which options to save/not save
        append output "proc infoCmd \{target\} \{\n"
        # if {!$vTcl(copy)} {
        # append output "[$::classes($class,dumpInfoCmd) $target \$target]\n"
        # #append output "[$::classes($class,dumpInfoCmd) $target \$\{top\}.m38]\n"
        # }
        # FIXME: Added following line 2/17/18
        append output "[$::classes($class,dumpInfoCmd) $target \$target]\n"
        append output "\}\n"
        ## optional list of procs to include with the compound
        if {![lempty $procs]} {
            append output "\nset procs \{\n"
            foreach procname $procs {
                append output "    $procname\n"
            }
            append output "\}\n"

            append output "\nproc procsCmd \{\} \{\n"
            foreach procname $procs {
                append output "[vTcl:dump_proc $procname]\n"
            }
            append output "\}\n"
        } else {
            append output "\nset procs \{\}\n"
            append output "\nproc procsCmd \{\} \{\}\n\n"
        }
        ## enumerate all the binding tags used
        set children [vTcl:complete_widget_tree $target 0]
        set used_tags ""
        set all_tags $::widgets_bindings::tagslist
        foreach child $children {
            # now, are bindtags non-standard ?
            set bindtags $::vTcl(bindtags,$child)
            if {$bindtags != [::widgets_bindings::get_standard_bindtags \
                              $child] } {
                foreach bindtag $bindtags {
                    if {[lsearch -exact $all_tags $bindtag] >= 0} {
                        lappend used_tags $bindtag
                    }
                }
            }
        }

        ## optional list of bindtags to include with the compound
        if {![lempty $used_tags]} {
            set used_tags [vTcl:lrmdups $used_tags]
            append output "\nset bindtags \{\n"
            foreach used_tag $used_tags {
                append output "    $used_tag\n"
            }
            append output "\}\n\n"

            append output "\nproc bindtagsCmd \{\} \{\n"
            foreach used_tag $used_tags {
                append output {#############################################################################}
                append output "\n\#\# Binding tag:  $used_tag\n\n"
                set bindlist [lsort [bind $used_tag]]
                foreach event $bindlist {
                   set command [bind $used_tag $event]
                   append output "bind \"$used_tag\" $event \{\n"
                   append output "$::vTcl(tab)[string trim $command]\n\}\n"
                }
            }
            append output "\}\n"
            append output "\n"
        } else {
            append output "\nset bindtags \{\}\n"
            append output "\nproc bindtagsCmd \{\} \{\}\n\n"
        }

        ## closing brace of namespace statement
        append output "# Putting out closing brace of namespace\n"
        append output "\}\n"
        ## we can put the handles back
            if {$target in $vTcl(multi_select_list)} {
                vTcl:replace_all_multi_handles
            } else {
                vTcl:place_handles $::vTcl(w,widget)
            }
        # set w_widget $::vTcl(w,widget)
        set w_widget $target
        set vTcl(copy_height)   [winfo height $w_widget]
        set vTcl(copy_width)    [winfo width $w_widget]
            #debugging statements. 
            #dskip 6
            #dpr output
            #dmsg final copy results
        return $output
    } ;# end of createCompound.


    proc mergeCompoundCode {type compoundName {mergeCode 0}} {
        set spc ${type}::[list $compoundName]
        if {![lempty [set ${spc}::procs]]} {
            ${spc}::procsCmd
            if {$mergeCode} {
                set ::vTcl(procs) [concat $::vTcl(procs) [set ${spc}::procs]]
                set ::vTcl(procs) [vTcl:lrmdups $::vTcl(procs)]
                vTcl:update_proc_list
            }
        }

        if {![lempty [set ${spc}::bindtags]]} {
            ${spc}::bindtagsCmd
            if {$mergeCode} {
                foreach tag [set ${spc}::bindtags] {
                    ::widgets_bindings::add_tag_to_tagslist $tag
                }
            }
        }
    }

    ## type should be "system" (predefined compounds) or "user"
    proc enumerateCompounds {type} {
        if {$type != "system" && $type != "user" && $type != "clipboard"} {
            return ""
        }

        set list [namespace children ${type}]
        regsub -all :: $list : list
        set result ""
        foreach item $list {
            lappend result [lindex [split $item :] end]
        }
        return $result
    }

    proc deleteCompounds {type} {
        # Attempt to clear out any pending copy, so that one only gets
        # one paste per copy.
        if {$type != "clipboard"} { return }
        set list [namespace children ${type}]
        namespace delete ${type}::scrap
    }
    ## inserts a compound
    proc putCompound {type compoundName} {
        set spc ${type}::[list $compoundName]
        set rootclass [set ${spc}::class]

        ## if no libs have been specified, we assume the default
        if {![info exists ${spc}::libraries]} {
            set ${spc}::libraries core
        }

        set missingLibs [vTcl::widgets::verifyLibraries [set ${spc}::libraries]]
        if {![lempty $missingLibs]} {
            ::vTcl::MessageBox -icon error -message \
"Cannot insert compound \'[join $compoundName]\' because the following libraries are not loaded:

[join $missingLibs]" -title "Missing Libraries"
            return
        }

        ## if it is a megawidget, insert it using the compound container
        if {$rootclass == "MegaWidget"} {
            vTcl:new_widget $::vTcl(pr,autoplace) CompoundContainer dummy \
               [list -compoundClass $compoundName]
            return
        }

        if {$::vTcl(pr,autoplace) || $rootclass == "Toplevel"} {
            autoPlaceCompound $type $compoundName wm {}
            return
        }

        vTcl:status "Insert [join $compoundName]"

        bind vTcl(b) <Button-1> \
            "vTcl:store_cursor %W
             vTcl::compounds::placeCompound $type [list $compoundName] $::vTcl(w,def_mgr) %X %Y %x %y"
    }
#"
    ## auto place a compound at insertion point
    ## This is where we come to do paste
    proc autoPlaceCompound {type compoundName gmgr gopt} {
        global vTcl
        set spc ${type}::[list $compoundName]
        set rootclass [set ${spc}::class]
        if {$rootclass == "Toplevel"} {
            set namePrefix $rootclass
            set target  [vTcl:new_widget_name Toplevel ""]
        } elseif {$rootclass == "Menu"} {
            set namePrefix "m"
            set target $vTcl(w,insert)
        } else {
            set namePrefix cpd
        # Moved closing brace from here.
        # Temporary trial 12/28/17
        set namePrefix [string range $rootclass 0 2]
            set namePrefix [string tolower $namePrefix 0 0]
           set target [vTcl:new_widget_name $namePrefix $::vTcl(w,insert)]
        } ;# new location
#         # Next line added in attempt to make copy of Menu work. Temp 1/14/18
#             if {$rootclass == "Menu"} {
#                 set namePrefix "m"
# dpr vTcl(w,insert)
# stop
#             } else {
#                 set target [vTcl:new_widget_name $namePrefix $::vTcl(w,insert)]#             }
        insertCompound $target $type $compoundName $gmgr $gopt
        vTcl:init_wtree
        set class [vTcl:get_class $target]
        if {[string range $class 0 0] != "T" || $class eq "Toplevel"} {
            # Do I want to preserve the background
            #$target configure -background $vTcl(actual_gui_bg)
        }
        if {[lsearch -exact $vTcl(tops) $target] > -1} {
            # So we can later tell if the toplevel was moved ad call it a change.
            set vTcl($target,top_geometry) [wm geometry $target]
        }
        vTcl:conform_widget_mode $target
        vTcl:active_widget $target
    }

proc insertCompound {target type compoundName {gmgr pack} {gopt ""}} {
    # Work horse of "paste". This builds a series of commands which
    # create the new widget similar to the way regular widgets are
    # created. Then the commands are executed by vTcl:push_action. As
    # part of that sequence, vTcl:DefineAlias, located in vtclib.tcl,
    # is executed which attempts to fix up the aliase for the pasted
    # widget.
    global vTcl
    set spc ${type}::[list $compoundName]
    set cmd ""              ;# "
    append cmd "vTcl::compounds::mergeCompoundCode $type [list $compoundName] 1"
    append cmd ";\n [list vTcl::compounds::${spc}::compoundCmd] $target"
    append cmd ";\n [list vTcl::compounds::${spc}::infoCmd] $target"
    if {$vTcl(copy_class) != "Menu" } {
        if {$gmgr != "wm"} {
            append cmd ";\n eval $gmgr $target $gopt -bordermode ignore"
            # if {[info exists vTcl(sash_pos)]} {
            #     append cmd "; update  idletasks"
            #     foreach pos $vTcl(sash_pos) {
            #        append cmd "; $target $pos"
            #     }
            # }
            #             if {[info exists vTcl(set_sash,target)]} {
            #                set  length_set_sash [llength $vTcl(set_sash,target)]
            #                append cmd "; update idletasks"
            #                foreach sash $vTcl(set_sash,target) {
            #                   append cmd "; $target $sash"
            #                }
            #             }
        } else {
            append cmd ";\n lappend ::vTcl(tops) $target"
            append cmd ";\n vTcl:update_top_list"
        }
    }
    append cmd ";\n vTcl:setup_bind_widget $target"
    append cmd ";\n vTcl:widget:register_all_widgets $target"
    set toplevel [regexp -inline {^\.top\d+} $target]
    append cmd ";\n vTcl:active_widget $toplevel \"from_paste\""
    append cmd ";\n after 500 {vTcl:init_wtree 0}"
    #Debugging Statement
    #dpr -s cmd
    set do "$cmd"
    set undo "destroy $target"
    vTcl:push_action $do $undo
    lappend ::vTcl(widgets,[winfo toplevel $target]) $target
    deleteCompounds clipboard ;# Want only one paste per copy.
    # If we copied a 'borrowed' toplevel widget change the background
    # to vTcl(actual_gui_bg) to make it more visible.
    if {$vTcl(copy_class) eq "Toplevel" \
           && [regexp {^\.bor} $vTcl(copy_widget)] } {
        $target configure -background $vTcl(actual_gui_bg)
    }
    # If we pasted a toplevel widget, move it to the side to make it visible.
    if {$vTcl(copy_class) eq "Toplevel"} {
        set geom [winfo geometry $target]
        set geom_split [split $geom "x+"]
        foreach {w h x y} $geom_split {}
        set new_x [expr {$x - 50}]
        set new_y [expr {$y + 50}]
        wm geometry $target ${w}x${h}+${new_x}+${new_y}
        vTcl:prop:update_attr
    }
}

    proc insertCompoundDirect {target type compoundName {gmgr pack} {gopt ""}} {
        set spc ${type}::[list $compoundName]
        vTcl::compounds::mergeCompoundCode $type $compoundName 1
        vTcl::compounds::${spc}::compoundCmd $target
        vTcl::compounds::${spc}::infoCmd $target
        if {[set ${spc}::class] == "Toplevel"} {
            set gmgr wm
            set gopt ""
        }
        if {$gmgr != "wm"} {
            eval $gmgr $target $gopt
        } else {
            lappend ::vTcl(tops) $target
            vTcl:update_top_list
        }
        vTcl:setup_bind_widget $target
        vTcl:widget:register_all_widgets $target
        lappend ::vTcl(widgets,[winfo toplevel $target]) $target
    }

    proc placeCompound {type compoundName gmgr rx ry x y} {
        vTcl:status Status
        vTcl:rebind_button_1

        set ::vTcl(w,insert) [winfo containing $rx $ry]

        set gopt {}
        if {$gmgr == "place"} {
             append gopt "-x $x -y $y"
        }

        autoPlaceCompound $type $compoundName $gmgr $gopt
    }

    proc getClass {type compoundName} {
        set spc ${type}::[list $compoundName]
        return [set ${spc}::class]
    }

    proc getLibraries {type compoundName} {
        set spc ${type}::[list $compoundName]

        ## if no libs have been specified, we assume the default
        if {![info exists ${spc}::libraries]} {
            set ${spc}::libraries core
        }

        return [set ${spc}::libraries]
    }

    proc getImages {type compoundName} {
        set spc ${type}::[list $compoundName]
        if {![info exists ${spc}::images]} {
            return ""
        }
        set result ""
        set images [set ${spc}::images]
        foreach img $images {
            eval set file [lindex $img 0]
            lappend result [vTcl:image:get_image $file]
        }
        return $result
    }

    proc getFonts {type compoundName} {
        set spc ${type}::[list $compoundName]
        if {![info exists ${spc}::fonts]} {
            return ""
        }
        set result ""
        set fonts [set ${spc}::fonts]
        foreach font $fonts {
            set fontDescr [lindex $font 0]
            lappend result [vTcl:font:getFontFromDescr $fontDescr]
        }
        return $result
    }


    proc getProcs {type compoundName} {
        set spc ${type}::[list $compoundName]
        return [set ${spc}::procs]
    }

    proc deleteCompound {type compoundName} {
        set spc ${type}::[list $compoundName]

        set procs [set ${spc}::procs]
        foreach procName $procs {
            if {[info procs $procName] == "$procName"} {
                rename $procName {}
            }
        }

        set tags [set ${spc}::bindtags]
        foreach tag $tags {
            foreach event [bind $tag] {
                bind $tag $event ""
            }
        }

        namespace delete $spc
    }
}



