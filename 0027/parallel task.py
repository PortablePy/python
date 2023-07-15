import threading
import time
import tkinter as tk
import tkinter.ttk as ttk

# --- functions ---

def long_script():
    global progress_value
    
    for i in range(20):
        print('loop:', i)
        
        # update global variable
        progress_value += 5
        
        time.sleep(.5)

def run_long_script():
    global progress_value
    global t
    
    if t is None: # run only one thread
        # set start value
        progress_value = 0
        # start updating progressbar
        update_progressbar()
        # start thread
        t = threading.Thread(target=long_script)
        t.start()
    else:
        print('Already running')
        
def update_progressbar():
    global t
    
    # update progressbar
    pb['value'] = progress_value
    
    if progress_value < 100:
        # run it again after 100ms
        root.after(100, update_progressbar)
    else:
        # set None so it can run thread again
        t = None
        
# --- main ---

# default value at start
progress_value = 0  
t = None

# - gui -

root = tk.Tk()

pb = ttk.Progressbar(root, mode="determinate")
pb.pack()

b = tk.Button(root, text="start", command=run_long_script)
b.pack()

root.mainloop()
