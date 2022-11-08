#!/usr/bin/wish --



if {[regexp {^[0-9a-fA-F]{6}$} $argv]} {
    set color \#$argv
    set hex 1
} else {
    set color $argv
    set hex 0
}

if {$color in {"-h" "--h"} || $color eq ""} {
    puts "show-color argument should be color_name or hex with no \#"
    exit
}

set font "-font {family {DejaVu Sans} 16 bold}"

message .m -text $color -font {Helvetica -18 bold} -width 100
pack .m

lassign [winfo rgb . $color] r g b
set r [expr {$r/256}]
set g [expr {$g/256}]
set b [expr {$b/256}]

if {!$hex} {
    set msg [format "#%02x%02x%02x" $r $g $b]
    message .m0 -text $msg -font {Helvetica -18 bold} -width 100
    pack .m0
}

frame .f -bg $color -relief ridge -borderwidth 8 -padx 10 -pady 10 \
      -height 100 -width 150
pack .f

set h \
    [expr { sqrt(0.299 * ($r * $r) + 0.587 * ($g * $g)+ 0.114 * ($b * $b))}]
if {$h > 127.5} {
    set l_or_d Light
} else {
    set l_or_d Dark
}

message .mc -text $l_or_d -font {Helvetica -18 bold} -width 75
pack .mc
button .b -text Quit -command exit -fg black -font {Helvetica -18 bold}
pack .b
