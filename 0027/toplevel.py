from tkinter import *

lay = []
root = Tk()
root.geometry('300x400+100+50')


def exit_btn():
    top = lay[0]
    top.destroy()
    top.update()
    del lay[0]


def create():
    top = Toplevel()
    lay.append(top)
    top.title("Main Panel")
    top.geometry('500x500+100+450')
    msg = Message(top, text="Show on New-panel", width=100)
    msg.pack()
    btn = Button(top, text='EXIT', command=exit_btn)
    btn.pack()


Button(root, text="Click me,Create a sub-panel", command=create).pack()
mainloop()
