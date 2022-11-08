##############################################################################
# $Id: lib_user.tcl,v 1.7 2005/12/05 06:58:31 kenparkerjr Exp $
#
# lib_user.tcl - User-defined tcl/tk widget support library
#
# Copyright (C) 1996-1998 Damon Courtney
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

# Rozen. I am trying to figure out how to add a widget.  This file
# started from lib_user and the interesting namespace stuff started
# from lib_bwidget.tcl since I also start from Widgets/bwidgets to
# build the ttk widgets.  vTcl Documentation strikes again.

proc vTcl:lib_ttk:init {} {
    return 1
}

proc vTcl:widget:lib:lib_ttk {args} {
    global vTcl widgets classes

    #   TMenubutton

    set order {
        TButton
        TCheckbutton
        TCombobox
        TEntry
        TFrame
        TLabel
        TLabelframe
        TNotebook
        TPanedwindow
        TProgressbar
        TRadiobutton
        TScale
        TSeparator
        TSizegrip
        TSpinbox
    }

    #if {![info exists vTcl(lib_user,classes)]} { return }

    #vTcl:lib:add_widgets_to_toolbar $vTcl(lib_user, classes) $vTcl(lib_user,classes)
    vTcl:lib:add_widgets_to_toolbar $order ttk "Themed widgets"
return
    kpwidgets::SBands::Expand .vTcl.toolbar.sbands.sw.sff.frame.bfrmttk
}

namespace eval vTcl::widgets::ttk {

    proc update_pages {target var} {
        ## there is a trace on var to update the combobox
        ## first item in the list is the current index
        set sites [$target tabs]
        set current [$target index [$target select]]
        set num_pages [llength $sites]
        set values $current
        for {set i 0} {$i < $num_pages} {incr i} {
            #set label_opt [$target itemconfigure [lindex $sites $i] -text]
            set txt [$target tab $i -text]
            #lappend values [lindex $label_opt 4]
            lappend values $txt
        }
        ## this will trigger the trace
        set ::$var $values
    }

    proc config_pages {target var} {
    }

    proc get_pages {target} {
    }

    proc select_page {target index} {
        global vTcl
        $vTcl(w,widget) select $index
        set tab [$vTcl(w,widget) select]
        vTcl:active_widget $tab
        #$target raise [$target pages $index]
    }

    ## Utility proc.  Dump a megawidget's children, but not those that are
    ## part of the megawidget itself.  Differs from vTcl:dump:widgets in that
    ## it dumps the geometry of $subwidget, but it doesn't dump $subwidget
    ## itself (`vTcl:dump:widgets $subwidget' doesn't do the right thing if
    ## the grid geometry manager is used to manage children of $subwidget.
    proc dump_subwidgets {subwidget {sitebasename {}}} {
        global vTcl basenames classes
        set output ""
        set geometry ""
        set widget_tree [vTcl:get_children $subwidget]
        set length      [string length $subwidget]
        set basenames($subwidget) $sitebasename
        foreach i $widget_tree {
            set basename [vTcl:base_name $i]
            ## don't try to dump subwidget itself
            if {"$i" != "$subwidget"} {
                set basenames($i) $basename
                set class [vTcl:get_class $i]
                append output [$classes($class,dumpCmd) $i $basename]
                if {[info exists ::widgets::${i}::locked] &&
                    [set ::widgets::${i}::locked]} {
                    append output "$vTcl(tab)vTcl:copy_lock $basename\n"
                }
                # This seems to be where we get the place statement.
                append geometry [vTcl:dump_widget_geom $i $basename]
                catch {unset basenames($i)}
            }
        }

        ## don't forget to dump grid geometry though
        append geometry [vTcl:dump_grid_geom $subwidget $sitebasename]
        append output $geometry
        catch {unset basenames($subwidget)}
        return $output
    }
}


