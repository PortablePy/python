#import tkinter, sys
#வேர்=tkinter.Tk()

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk
import sys
import os, os.path

வேர் = tk.Tk()

வேர்.tk.eval('set argv {}; set argc 0')
p = os.path.abspath(sys.argv[0])
cmd = "source {" + os.path.join(os.path.dirname(p), 'page.tcl') + "}"

#வேர்.tk.eval('puts "tcl_version = $tcl_version"')

for a in sys.argv[1:]: # Skip argv[0] (the filename of this script)
    # வேர்.tk.eval(f'lappend argv {{{a}}}; incr argc')
    வேர்.tk.eval("lappend argv {%s}; incr argc" % a)

try:
    வேர்.tk.eval(cmd)
    sys.exit()
except:
    pass

வேர்.mainloop()

