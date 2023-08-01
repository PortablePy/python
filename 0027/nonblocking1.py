from tkinter import *

ws = Tk()
ws.title('PythonGuides')
ws.geometry('300x200')
ws.config(bg='#4a7a8c')

def greet_user():
    name = input('Enter your name ')
    print('Good Morning ',name)   

Button(
    ws,
    text='Exit',
    command=lambda:ws.destroy()
).pack(expand=True)

ws.after(0, greet_user)
ws.mainloop()
print ("last line of the code")
