# I found this on the web and decided to incorporate it as part of PAGE.
# Found at http://wiki.tcl.tk/15925 via google search.

proc vTcl:relTo {targetfile currentpath} {
  # Get relative path to target file from current path
  # First argument is a file name, second a directory name (not checked)
    
  # Example: set file_name [vTcl:relTo $file_name [pwd]]
  global vTcl
  set vTcl(file_in_subdir) 1
  set cc [file split [file normalize $currentpath]]
  set tt [file split [file normalize $targetfile]]
  if {![string equal [lindex $cc 0] [lindex $tt 0]]} {
      # not on *n*x then
      return "."
      #return -code error "$targetfile not on same volume as $currentpath"
  }
  while {[string equal [lindex $cc 0] [lindex $tt 0]] && [llength $cc] > 0} {
      # discard matching components from the front
      set cc [lreplace $cc 0 0]
      set tt [lreplace $tt 0 0]
  }
  set prefix ""
  if {[llength $cc] == 0} {
      # just the file name, so targetfile is lower down (or in same place)
      set prefix "."
  }
  # step up the tree
  for {set i 0} {$i < [llength $cc]} {incr i} {
      append prefix " .."
      set vTcl(file_in_subdir) 0        ;# Rozen
  }
  # stick it all together (the eval is to flatten the targetfile list)
  set ret [eval file join $prefix $tt]
  return $ret
}
