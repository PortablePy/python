##############################################################################
# $Id: bgerror.tcl,v 1.26 2005/11/11 07:42:44 kenparkerjr Exp $
#
# bgerror.tcl - a replacement for the standard bgerror message box
#
# Copyright (C) 2000 Christian Gavin
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
#
##############################################################################

namespace eval ::stack_trace {
    variable boxIndex 0
}


proc bgerror {error} {
    global vTcl
    global widget errorInfo
    if {[regexp {vTcl:exit} $errorInfo]} {
        return
    }
    # if {$errorInfo eq ""} {
    #     set exitvar 1
    #     update
    #     update idletasks
    #     tkwait variable exitvar
    #     vTcl:exit
    # }
    vTcl:display_error $errorInfo
}

proc vTcl:save_err_msg {} {
    global errorInfo
    set o $errorInfo
    set file [vTcl:get_file err "Save Error Information"]
    set fileId [open $file w]
    puts $fileId $o
    close $fileId
}

proc vTcl:display_error {msg} {
    set WIDTH 80
    global exit_flag
    set txt [split $msg "\n"]
    set height [llength $txt]
    foreach s $txt {
        set len [string length $s]
        set extra [expr {$len / $WIDTH}]
        incr height $extra
    }
    #set max [tcl::mathfunc::max {*}$lengths]
    set exit_flag 0
    set exitvar 0
    toplevel .err_top
    wm title .err_top "Error Information"
    frame .err_top.f
    button .err_top.f.b1 -text "Close and Exit" -command {
        set exit_flag 1
        set exitvar 1
    } -foreground $::vTcl(pr,fgcolor)      ;# NEEDS WORK dark
    button .err_top.f.b2 -text "Save Error Msg and Exit" -command {
        vTcl:save_err_msg
        set exit_flag 1
        set exitvar 1
    } -foreground $::vTcl(pr,fgcolor)      ;# NEEDS WORK dark
    button .err_top.f.b3 -text "Dismiss" -command {
        destroy .err_top
       set exit_flag 0
        set exitvar 1
    } -foreground $::vTcl(pr,fgcolor)      ;# NEEDS WORK dark
    pack .err_top.f -fill x
    pack .err_top.f.b1 -side right -expand 1
    pack .err_top.f.b2 -side left -expand 1
    pack .err_top.f.b3 -side left -expand 1

    text .err_top.t -width $WIDTH -height $height \
        -background $::vTcl(area_bg) -foreground black ;# NEEDS WORK dark
        # -foreground $::vTcl(pr,fgcolor)
    pack .err_top.t
    .err_top.t insert 1.0 $msg

    tkwait variable exitvar
    if {$exit_flag} {
        vTcl:exit
    }
}

# Not called part of old error handling.
# proc vTclWindow.vTcl.bgerror {base} {
# flush stdout
#     if {$base == ""} {
#         set base .vTcl.bgerror
#     }
#     if {[winfo exists $base]} {
#         wm deiconify $base; return
#     }

#     global [vTcl:rename $base.error]
#     global [vTcl:rename $base.errorInfo]

#     eval set error     $[vTcl:rename $base.error]
#     eval set errorInfo $[vTcl:rename $base.errorInfo]
#     global widget
#     vTcl:DefineAlias $base error_box vTcl:Toplevel:WidgetProc "" 0
#     vTcl:DefineAlias $base.fra20.cpd23.03 error_box_text vTcl:WidgetProc $base 0
#     ###################
#     # CREATING WIDGETS
#     ###################vTcl:prop:config_cmd
#     toplevel $base -class Toplevel
#     wm focusmodel $base passive
#     wm geometry $base 333x248+196+396
#     wm maxsize $base 1009 738
#     wm minsize $base 1 1
#     wm overrideredirect $base 0
#     wm resizable $base 1 1
#     wm deiconify $base
#     wm title $base "Error"
#     wm protocol $base WM_DELETE_WINDOW "
#             set [vTcl:rename $base.dialogStatus] ok
#             destroy $base"

#     frame $base.fra20 \
#         -borderwidth 2
#     label $base.fra20.lab21 \
#         -bitmap error -borderwidth 0 \
#         -padx 0 -pady 0 -relief raised -text label
#     ScrolledWindow $base.fra20.cpd23
#     text $base.fra20.cpd23.03 \
#         -background #dcdcdc -font [vTcl:font:get_font "vTcl:font8"] \
#         -foreground #000000 -height 1 -highlightbackground #ffffff \
#         -highlightcolor #000000 -selectbackground #008080 \
#         -selectforeground #ffffff \
#     -width 8 -wrap word
#     $base.fra20.cpd23 setwidget $base.fra20.cpd23.03;# NEEDS WORK dark

#     frame $base.fra25 \
#         -borderwidth 2
#     button $base.fra25.but26 \
#         -padx 9 -text OK \
#         -command "
#             set [vTcl:rename $base.dialogStatus] ok
#             destroy $base"
#     button $base.fra25.but27 \
#         -padx 9 -text {Skip messages} \
#         -command "set [vTcl:rename $base.dialogStatus] skip
#                   destroy $base"
#     button $base.fra25.but28 \
#         -padx 9 -text {Stack Trace...}  \
#         -command " vTcl:display_error $errorInfo"
#         # -command "::vTcl::InitTkcon
#         #       edit -attach \[::tkcon::Attach\] -type error -- [list $errorInfo]
#         #           set [vTcl:rename $base.dialogStatus] ok
#         #           after idle \{destroy $base\}"
#     ###################
#     # SETTING GEOMETRY
#     ###################
#     pack $base.fra20 \
#         -in $base -anchor center -expand 1 -fill both -pady 2 -side top
#     pack $base.fra20.lab21 \;# NEEDS WORK dark
#         -in $base.fra20 -anchor e -expand 0 -fill none -padx 5 -side left

#     pack $base.fra20.cpd23 \
#         -in $base.fra20 -anchor center -expand 1 -fill both -padx 2 -side top
#     #pack $base.fra20.cpd23.03      Rozen BWidget

#     pack $base.fra25 \
#         -in $base -anchor center -expand 0 -fill x -pady 4 -side top
#     pack $base.fra25.but26 \
#         -in $base.fra25 -anchor center -expand 1 -fill none -side left
#     pack $base.fra25.but27 \
#         -in $base.fra25 -anchor center -expand 1 -fill none -side left
#     pack $base.fra25.but28 \
#         -in $base.fra25 -anchor center -expand 1 -fill none -side left
#     $widget($base,error_box_text) insert 1.0 $error
#     #The box must be disabled after the error is inserted
#     $widget($base,error_box_text) configure -state disabled
# }

# proc bgerror {error} {
#     global vTcl
#     global widget errorInfo
#     incr ::stack_trace::boxIndex
#     set top ".vTcl.bgerror$::stack_trace::boxIndex"
#     global [vTcl:rename $top.error]
#     global [vTcl:rename $top.errorInfo]
#     global [vTcl:rename $top.dialogStatus]
#     if {[string length $error] > 50} {    ;# Rozen 11/5/14
#         set show_error [string range $error 0 49]
#     } else {
#         set show_error $error
#     }
#     set [vTcl:rename $top.error] $show_error
#     set [vTcl:rename $top.errorInfo] $errorInfo
#     set [vTcl:rename $top.dialogStatus] 0
#     vTclWindow.vTcl.bgerror $top
#     vwait [vTcl:rename $top.dialogStatus]
#     eval set status $[vTcl:rename $top.dialogStatus]

#     # don't leak memory, please !
#     unset [vTcl:rename $top.error]
#     unset [vTcl:rename $top.errorInfo]
#     unset [vTcl:rename $top.dialogStatus]

#     if {$status != "skip"} {

#         return
#     }

#     return -code break
# }


# proc vTcl:display_error {msg} {
#     set WIDTH 80
#     set txt [split $msg "\n"]
#     set height [llength $txt]
#     foreach s $txt {
#         set len [string length $s]
#         set extra [expr {$len / $WIDTH}]
#         incr height $extra
#     }
#     #set max [tcl::mathfunc::max {*}$lengths]

#     set exitvar 0
#     toplevel .err_top
#     wm title .err_top "Error Information"
#     frame .err_top.f
#     button .err_top.f.b1 -text "Close and Exit" -command {set exitvar 1}

#     button .err_top.f.b2 -text "Save Error Msg and Exit" -command {
#         vTcl:save_err_msg
#         set exitvar 1
#     }
#     pack .err_top.f -fill x
#     pack .err_top.f.b1 -side right -expand 1
#     pack .err_top.f.b2 -side left -expand 1
#     text .err_top.t -width $WIDTH -height $height
#     pack .err_top.t
#     .err_top.t insert 1.0 $msg

#     tkwait variable exitvar
#     vTcl:exit
# }
