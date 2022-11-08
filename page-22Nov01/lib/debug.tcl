# Rozen. Debugging procs. Started with PrintByName and Call_Trace from
# the Welch book and went from there.

# Functions provided here.
# dpr <-s> variable ...        Prints out the variable names and values.
#                              -s causes line skip.
# dmsg <-s> words in a message Prints out a message. -s causes line skip.
#                              args are text strings, can be $var or calls.
# dtrace                       Prints out call trace.
# dpl <-s> list_variable            Prints out list - one element per line.
# dskip <number>               Provide blank lines.
# stop                         Try do divide 1 by 0 forcing error and trace back.
# dconf widget                 Prints configuration of the widget.
# pconf conf_variable          Prints configuration variable in nice format.
# dargs <-s>                   Prints the arguments with names of containing proc

proc PrintByName { args } {

    # Takes a list of variable names and prints the name and the
    # corresponding value for each name along with the enclosing proc.
    # Example usage: dpr <-s> x y z

    set pre_skip ""
    if {[llength $args] > 0 && [lindex $args 0] eq "-s"} {
        set args [lrange $args 1 end]
        set pre_skip "\n"
    }

    set x [expr [info level]-1]
    set y [lindex [info level $x] 0]

    set str "${pre_skip}dpr: $y: "
    foreach var_name $args {
        upvar 1 $var_name dvar
        if {[info exists dvar]} {
            append str "$var_name = $dvar, "
        } else {
            append str "$var_name: nonexistent,"
        }
    }
    puts stdout $str
}

rename PrintByName dpr

# Prints a trace of the Tcl call stack.
# Example usage: dtrace

proc Call_Trace {{file stdout}} {
    puts $file "Tcl Call Trace"
    for {set x [expr [info level]-1]} {$x > 0} {incr x -1} {
        puts $file "$x: [info level $x]"
    }
}
rename Call_Trace dtrace

proc dmsg {args} {
    # Takes zero or more arguments. If there are no argumenst, it
    # prints the name of the encolsing procedure and the string
    # "Starting" If there are arguments present they are printed as
    # strings with separated with " ".  It saves having to put quotes
    # around the message printed.
    # If the first arg is "-s" then skip a line
    # Example usage: dmsg -s inside frame clause of switch

    set pre_skip ""
    if {[llength $args] > 0 && [lindex $args 0] eq "-s"} {
        set args [lrange $args 1 end]
        set pre_skip "\n"
    }
    if {[llength $args] == 0} {
        set msg Starting
    } else {
        foreach w $args {
            append msg $w " "
        }
    }
    set x [expr [info level]-1]
    set y [lindex [info level $x] 0]
    if {$msg == "Starting"} {
        # set msg "Starting."
        set msg "Starting: [lrange [info level $x] 1 end]"
    }
    set msg [string trimright $msg]
    set str "${pre_skip}dmsg: $y: $msg."
    puts stdout $str
}

proc dargs {args } {
    # Prints out the name of the enclosing proc and the arguments to
    # the proc.
    # Example usage dargs.
    set pre_skip ""
    if {[llength $args] > 0 && [lindex $args 0] eq "-s"} {
        set args [lrange $args 1 end]
        set pre_skip "\n"
    }
    set x [expr [info level]-1]
    set y [lindex [info level $x] 0]
    if {$pre_skip ne ""} { puts $pre_skip }
    puts "-----------"
    #puts "x = $x, info level =  [info level $x]"
    puts "dargs [info level $x]"
    set a [info args [lrange [info level $x] 0 0]]
    puts "args: $a"
    for {set i 0} {$i < [expr [llength [info level $x]] - 1]} {incr i} {
        set ii [expr $i + 1]
        puts "[lrange $a $i $i] = [lrange [info level $x] $ii $ii]"
    } ;# end for loop
    puts "-----------"

}

proc pargs { widget } {
    # Prints out complete list of configuration.
    set conf [join [$widget configure] \n]
    puts $conf
}

proc dpl { args } {
    # Print out list with each element in a list printed on a separate line..
    set x [expr [info level]-1]
    set y [lindex [info level $x] 0]

    set pre_skip ""
    if {[llength $args] > 0 && [lindex $args 0] eq "-s"} {
        set args [lrange $args 1 end]
        set pre_skip "\n"
    }

    set str "${pre_skip}dpl: $y: "
    upvar 1 $args var
    append str "$args:"
    foreach element $var {
        append str "\n $element"
    }
    puts stdout $str
}

proc dskip { {lines 1} } {
    # Skips one or more lines in the output for easier spotting of the
    # following lines of debugging output.
    for {set x 0} {$x<$lines} {incr x} {
        puts "\n"
    }
}

proc stop {} {
    # Kills the execution and gives an error message with optional
    # traceback.
    [expr 1 / 0]
}

#proc tracer {varname args} {
#    upvar #0 $varname var
#    puts "$varname was updated to be \"$var\""
#}

# Example of trace statement to be put in the code.
# trace add variable foo write "tracer foo"

proc vTcl:show_config {target} {
    set cfg [$target configure]
    puts "config = $cfg"
}

# This command prints out a procedure suitable for saving in a Tcl
# script. It was found in the tcl info man page.
proc printProc {procName} {
    # Modified from example in tcl documentation.
    if {[llength [info commands $procName]] == 0} {
        puts "\"$procName\" does not exist"
        return
    }
    set result [list proc $procName]
    set formals {}
    foreach var [info args $procName] {
        if {[info default $procName $var def]} {
            lappend formals [list $var $def]
        } else {
            # Still need the list-quoting because variable
            # names may properly contain spaces.
            lappend formals [list $var]
        }
    }
    puts [lappend result $formals [info body $procName]]
}

rename printProc printproc

# proc prettyRec { l i } {
#   #puts "pretty Rec $l : $i"
#   set next ""
#   set indent ""
#   set space "  "
#   for { set j 0} {$j < $i} {incr j} {
#     append indent $space
#   }
#   set result "$indent\[\n"
#   foreach x $l {
#     if {[llength $x] == 1} {
#       append result "$indent$space$x\n"
#     } else {
#       set next [prettyRec $x [expr $i + 1]]
#       append result "\n$next"
#     }
#   }
#   append result "${indent}]\n"
#   return $result
# }

# proc pretty { l } {
#   return [prettyRec $l 0]
# }

# Example 21-2 from Welch's book. Useful for debugging tk routines.
proc Widget_Attributes {w {out stdout}} {
    # Call: dconf $w
    puts "widget = $w"
    #set w $w_name
    set x [expr [info level]-1]
    puts "dconf [info level $x]"
    puts $out [format "%-20s %-10s %s" Attribute Default Value]
    foreach item [$w configure] {
        puts $out [format "%-20s %-10s %s" \
            [lindex $item 0] [lindex $item 3] \
            [lindex $item 4]]
    }
}

rename Widget_Attributes dconf

proc  pconf {conf {out stdout}} {
    # Called with "pconf $conf" It doesn't create conf it just prints it.
    puts "\nPrinting '$conf'"
    puts $out [format "%-20s %-10s %s" Attribute Default Value]
    upvar 1  $conf conf_stuff
    foreach item $conf_stuff {
        puts $out [format "%-20s %-10s %s" \
                       [lindex $item 0] [lindex $item 3] \
                       [lindex $item 4]]
    }
} ;# end pconf

proc dpr_options {widget} {
    global vTcl
    puts "Dumping array 'options' for $widget."
    if {![info exists ::widgets::${widget}::options]} {
        puts "Array 'option' does not exist for $widget"
        return
    }
    vTcl:WidgetVar $widget options
    parray options
} ;# end dpr_options

proc dpr_check_configure {w} {
    set conf [$w configure]
    set sought "-variable"
    foreach opt $conf {
        foreach {op x y d val} $opt {}
        if {$op eq $sought} {
            dpr op def val
        }
    }

}
