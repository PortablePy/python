import tkinter as tk
import threading


class MainWindow(tk.Tk):
    def __init__(self):
        super().__init__()

    def __close(self):
        self.destroy()


class AppThread(threading.Thread):

    def __init__(self):
        threading.Thread.__init__(self)
        self.start()

    def stop_cb(self):
        self.root.quit()

    def run(self):
        self.root = MainWindow()  #  tk.Tk()
        self.root.protocol("WM_DELETE_WINDOW", self.stop_cb)

        label = tk.Label(self.root, text="Hello World")
        label.pack()

        self.root.mainloop()


app = AppThread()
app2 = AppThread()
app3 = AppThread()
print('Now we can continue running code while mainloop runs!')
