import tkinter.messagebox as tkmb
import sys

தலைப்பு = __name__
if தலைப்பு == "__main__":
    தலைப்பு = 'தமிழ் நேரம்'
    தலைப்பு = sys.argv[0]
    
k = tkmb.showinfo(title=தலைப்பு, message= 'வணக்கம்')
print(k, தலைப்பு)
k = tkmb.showwarning(title=தலைப்பு, message= 'வணக்கம்')
print(k)
k = tkmb.showerror(title=தலைப்பு, message= 'வணக்கம்')
print(k)
k = tkmb.askquestion(title=தலைப்பு, message= 'வணக்கம்')
print(k)
k = tkmb.askokcancel(title=தலைப்பு, message= 'வணக்கம்')
print(k)
k = tkmb.askretrycancel(title=தலைப்பு, message= 'வணக்கம்')
print(k)
k = tkmb.askyesno(title=தலைப்பு, message= 'வணக்கம்')
print(k)
k = tkmb.askyesnocancel(title=தலைப்பு, message= 'வணக்கம்')
print(k, தலைப்பு)
