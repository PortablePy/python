# Usage: vTcl:withBusyCursor { script ... }
#

# Borrowed from:
#
# http://code.activestate.com/recipes/68377-with-busy-cursor/
#
# Got a section of code in a GUI that takes a few seconds to execute?
# Wrap it in a call to [withBusyCursor] to give the user feedback.
#
# Known problems: Only tested on Unix; it doesn't seem to always work on
# Windows. I'm not sure if it should use [update] or [update idletasks].
#
# Notes: Unlike the BLT [busy] command, this doesn't block user
# input. In practice this doesn't seem to be a problem -- when the
# cursor changes, users tend to stop clicking until it changes back.
#
# The code also illustrates a useful idiom for breadth-first traversal,
# the correct way to pass exceptional return conditions up the call
# stack, and one of Tcl's neatest features -- the ability to define new
# control structures.



proc vTcl:withBusyCursor {body} {
    global errorInfo errorCode
    global vTcl  ;# Added by Rozen to exclude the toplevel window from
                  # busy cursor.
    set busy {}
    set list {.}
    # Traverse the widget hierarchy to locate widgets with
    # a nondefault -cursor setting.
    #
    while {$list != ""} {
        set next {}
        foreach w $list {
            catch {set cursor [$w cget -cursor]}
            if {[winfo toplevel $w] == $w || $cursor != ""} {
                # Added to allow using function in loading project.
                #if {$w != $vTcl(real_top)} {
                #if {$w != $vTcl(real_top) && $w !=  "."} { ;# }
                    lappend busy $w $cursor
                    set cursor {}
                #}
            }
            set next [concat $next [winfo children $w]]
        }
        set list $next
    }
    # Change the cursor:
    #
    foreach {w _} $busy {
        catch {$w configure -cursor watch}
    }
    update idletasks

    # Execute the script body.
    #
    set rc [catch {uplevel 1 $body} result]
    set ei $errorInfo
    set ec $errorCode

    # Restore the original cursor settings.
    #
    foreach {w cursor} $busy {
        catch {$w configure -cursor $cursor}
    }

    # Return script result to caller.
    #
    return -code $rc -errorinfo $ei -errorcode $ec $result
}

# proc vTcl:withBusyCursor {body} {
#     # Since I could not make the above work in 7.4, I put this nearly
#     # null version in to replace it.
#     set rc [catch {uplevel 1 $body} result]
#     return
# }
