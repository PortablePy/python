#import tkinter, sys
#root=tkinter.Tk()

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk
import sys
import os, os.path

root = tk.Tk()

root.tk.eval('set argv {}; set argc 0')
p = os.path.abspath(sys.argv[0])
cmd = "source {" + os.path.join(os.path.dirname(p), 'page.tcl') + "}"

#root.tk.eval('puts "tcl_version = $tcl_version"')

for a in sys.argv[1:]: # Skip argv[0] (the filename of this script)
    # root.tk.eval(f'lappend argv {{{a}}}; incr argc')
    root.tk.eval("lappend argv {%s}; incr argc" % a)

try:
    root.tk.eval(cmd)
    sys.exit()
except:
    pass

root.mainloop()

