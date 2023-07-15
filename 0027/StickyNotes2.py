import tkinter as tk

class Notepad(tk.Frame):
    def __init__(self, parent):
        tk.Frame.__init__(self, parent)
        self.text = tk.Text(self, wrap="word")
        self.vsb = tk.Scrollbar(self, orient="vertical", comman=self.text.yview)
        self.text.configure(yscrollcommand=self.vsb.set)
        self.vsb.pack(side="right", fill="y")
        self.text.pack(side="left", fill="both", expand=True)

def main():
    root = tk.Tk()
    Notepad(root).pack(fill="both", expand=True)
    for i in range(5):
        top = tk.Toplevel(root)
        Notepad(top).pack(fill="both", expand=True)

    root.mainloop()

if __name__ == "__main__":
    main()
