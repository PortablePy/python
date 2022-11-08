from tkinter import *

root = Tk()
root.title('Codemy.com')
root.iconbitmap('c:/gui/codemy.ico')
root.geometry("400x600")

# Create frame and scrollbar
my_frame = Frame(root)
my_scrollbar = Scrollbar(my_frame, orient=VERTICAL)

# Listbox!
# SINGLE, BROWSE, MULTIPLE, EXTENDED
my_listbox = Listbox(my_frame, width=50, yscrollcommand=my_scrollbar.set, selectmode=MULTIPLE)

#configure scrollbar
my_scrollbar.config(command=my_listbox.yview)
my_scrollbar.pack(side=RIGHT, fill=Y)
my_frame.pack()

my_listbox.pack(pady=15)




#Add item to listbox
my_listbox.insert(END, "This is an item")
my_listbox.insert(END, "Second Item!")

# Add list of items
my_list = ["One", "Two", "Three", "One", "Two", "Three", "One", "Two", "Three", "One", "Two", "Three", "One", "Two", "Three", "One", "Two", "Three", "One", "Two", "Three", "One", "Two", "Three", ]

for item in my_list:
	my_listbox.insert(END, item)

def delete():
	my_listbox.delete(ANCHOR)
	my_label.config(text='')

def select():
	my_label.config(text=my_listbox.get(ANCHOR))

def delete_all():
	my_listbox.delete(0, END)

def select_all():
	result = ''

	for item in my_listbox.curselection():
		result = result + str(my_listbox.get(item)) + '\n'

	my_label.config(text=result)

def delete_multiple():
	for item in reversed(my_listbox.curselection()):
		my_listbox.delete(item)
		my_label.config(text='')

my_button = Button(root, text="Delete", command=delete)
my_button.pack(pady=10)

my_button2 = Button(root, text="Select", command=select)
my_button2.pack(pady=10)

global my_label
my_label = Label(root, text='')
my_label.pack(pady=5)

my_button3 = Button(root, text="Delete All", command=delete_all)
my_button3.pack(pady=10)

my_button4 = Button(root, text="Select All", command=select_all)
my_button4.pack(pady=10)

my_button5 = Button(root, text="Delete Multiple", command=delete_multiple)
my_button5.pack(pady=10)

root.mainloop()

