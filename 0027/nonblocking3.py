from tkinter import *
import random

ws = Tk()
ws.title('PythonGuides')
ws.config(bg='#5f734c')
ws.geometry('400x300')

def generate_password():
    digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] 
    lc = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
                     'i', 'j', 'k', 'm', 'n', 'o', 'p', 'q',
                     'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
                     'z']
 
    uc = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                     'I', 'J', 'K', 'M', 'N', 'O', 'p', 'Q',
                     'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
                     'Z']
 
    spch = ['@', '#', '$', '%', '=', ':', '?', '.', '/', '|', '~', '>',
           '*', '(', ')', '<']

    pwd = random.choice(digits) + random.choice(lc) + random.choice(uc) + random.choice(spch)
    password = pwd+pwd
    lbl.config(text=password)

lbl = Label(
    ws,
    bg='#5f734c', 
    font=(18)
    )
lbl.pack(expand=True)

btn = Button(
    ws,
    text='Generate Password',
    padx=10, 
    pady=5,
    command=generate_password
)
btn.pack(expand=True)

def message():
    print('Keep yourself hyderated.')
    ws.after(7000, message) 

ws.after(5000, message)
ws.mainloop()
