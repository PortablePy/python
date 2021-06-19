##############################################################################
# $Id: balloon.tcl,v 1.7 2001/08/09 04:36:42 cgavin Exp $
#
# balloon.tcl - procedures used by balloon help
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

# This file required to allow balloon help when running PAGE.

bind _vTclBalloon <Enter> {
    namespace eval ::vTcl::balloon {
        ## self defining balloon
        if {![info exists %W]} {
            vTcl:FireEvent %W <<SetBalloon>>
        }
        set set 0
        set first 1
        set id [after 500 {vTcl:FireEvent %W <<vTclBalloon>>}]
    }
}

bind _vTclBalloon <Motion> {
    namespace eval ::vTcl::balloon {
        if {!$set} {
            after cancel $id
            set id [after 500 {vTcl:FireEvent %W <<vTclBalloon>>}]
        }
    }
}

bind _vTclBalloon <Button> {
    namespace eval ::vTcl::balloon {
        set first 0
    }
    vTcl:FireEvent %W <<KillBalloon>>
}

bind _vTclBalloon <Leave> {
    namespace eval ::vTcl::balloon {
        set first 0
    }
    vTcl:FireEvent %W <<KillBalloon>>
}

bind _vTclBalloon <<KillBalloon>> {
    namespace eval ::vTcl::balloon {
        after cancel $id
        if {[winfo exists .vTcl.balloon]} {
            destroy .vTcl.balloon
        }
        set set 0
    }
}

bind _vTclBalloon <<vTclBalloon>> {
    if {$::vTcl::balloon::first != 1} {break}
    namespace eval ::vTcl::balloon {
        set first 2
        if {![winfo exists .vTcl]} {
            toplevel .vTcl; wm withdraw .vTcl
        }
        if {![winfo exists .vTcl.balloon]} {
            toplevel .vTcl.balloon -bg black
        }
        wm overrideredirect .vTcl.balloon 1
        label .vTcl.balloon.l \
            -text ${%W} -relief flat \
            -bg #ffffaa -fg black -padx 2 -pady 0 -anchor w
        pack .vTcl.balloon.l -side left -padx 1 -pady 1
        wm geometry \
            .vTcl.balloon \
            +[expr {[winfo rootx %W]+[winfo width %W]/2}]\
            +[expr {[winfo rooty %W]+[winfo height %W]+4}]
        set set 1
    }
}

# proc vTcl:set_balloon {target message} {
#     ## Balloons disabled?
#     if {!$::vTcl(pr,balloon)} {return}

#     namespace eval ::vTcl::balloon "variable $target"
#     set ::vTcl::balloon::$target $message

#     ## Add tag to the widget
#     bindtags $target "[bindtags $target] _vTclBalloon"
# }

proc vTcl:set_balloon {target message} {
    #if {!$::vTcl(pr,balloon)} {return}
    vTcl:setTooltip $target $message
}

##################################
# Routines supporting balloon help
##################################

# I got these routines from https://wiki.tcl-lang.org/page/balloon+help

# proc vTcl:balloon {w help} {
#     bind $w <Any-Enter> "after 1000 [list vTcl:balloon_show %W [list $help]]"
#     bind $w <Any-Leave> "destroy %W.balloon"
# }

# proc vTcl:balloon_show {w arg} {
#     if {[eval winfo containing  [winfo pointerxy .]]!=$w} {return}
#     set top $w.balloon
#     catch {destroy $top}
#     toplevel $top -bd 1 -bg black
#     wm overrideredirect $top 1
#     if {[string equal [tk windowingsystem] aqua]}  {
#         ::tk::unsupported::MacWindowStyle style $top help none
#     }
#     pack [message $top.txt -aspect 10000 -bg lightyellow \
#         -font fixed -text $arg]
#     set wmx [winfo rootx $w]
#     set wmy [expr [winfo rooty $w]+[winfo height $w]]
#     wm geometry $top [winfo reqwidth $top.txt]x[
#         winfo reqheight $top.txt]+$wmx+$wmy
#     raise $top
# }

# # Example:
# #button       .b -text Exit -command exit
# #vTcl:balloon .b "Push me if you're done with this"
# #pack         .b

proc vTcl:setTooltip {widget text} {
    if { $text != "" } {
        # 2) Adjusted timings and added key and button bindings. These seem to
        # make artifacts tolerably rare.
        bind $widget <Any-Enter>    [list after 500 \
                                         [list vTcl:showTooltip %W $text]]
        bind $widget <Any-Leave>    [list after 500 [list destroy %W.tooltip]]
        bind $widget <Any-KeyPress> [list after 500 [list destroy %W.tooltip]]
        bind $widget <Any-Button>   [list after 500 [list destroy %W.tooltip]]
    }
}
proc vTcl:showTooltip {widget text} {
    global tcl_platform
    if { [string match $widget* [winfo containing  [winfo pointerx .] \
                                     [winfo pointery .]] ] == 0  } {
        return
    }

    catch { destroy $widget.tooltip }

    set scrh [winfo screenheight $widget]    ; # 1) flashing window fix
    set scrw [winfo screenwidth $widget]     ; # 1) flashing window fix
    set tooltip [toplevel $widget.tooltip -bd 1 -bg black]
    wm geometry $tooltip +$scrh+$scrw        ; # 1) flashing window fix
    wm overrideredirect $tooltip 1

    if {$tcl_platform(platform) == {windows}} { ; # 3) wm attributes...
        wm attributes $tooltip -topmost 1   ; # 3) assumes...
    }                                           ; # 3) Windows
    pack [label $tooltip.label -bg lightyellow -fg black -text $text \
              -justify left]

    set width [winfo reqwidth $tooltip.label]
    set height [winfo reqheight $tooltip.label]

    # b.) Is the pointer in the bottom half of the screen?
    # set pointer_below_midline [expr [winfo pointery .] > \
                                   [expr [winfo screenheight .] / 2.0]]
    set pointer_below_midline 1 ;# Don't want balloon on top of mouse pointer.
    # c.) Tooltip is centred horizontally on pointer.
    set positionX [expr [winfo pointerx .] - round($width / 2.0)]
    set positionY [expr [winfo pointery .] + 35 * \
                ($pointer_below_midline * -2 + 1) - round($height / 2.0)]
    # b.) Tooltip is displayed above or below depending on pointer Y position.

    # a.) Ad-hockery: Set positionX so the entire tooltip widget will
    # be displayed.

    #c.) Simplified slightly and modified to handle
    # horizontally-centred tooltips and the left screen edge.

    if  {[expr $positionX + $width] > [winfo screenwidth .]} {
        set positionX [expr [winfo screenwidth .] - $width]
    } elseif {$positionX < 0} {
        set positionX 0
    }

    wm geometry $tooltip [join  "$width x $height + $positionX + $positionY" {}]
    raise $tooltip

    # 2) Kludge: defeat rare artifact by passing mouse over a tooltip
    # to destroy it.
    bind $widget.tooltip <Any-Enter> {destroy %W}
    bind $widget.tooltip <Any-Leave> {destroy %W}
}


#pack [button .b -text hello]
#setTooltip .b "Hello World!"
