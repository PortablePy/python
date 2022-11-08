#!/usr/local/bin/python
"""
################################################################################
PyCalc 3.0+: a Python/tkinter calculator program and GUI component.

Evaluates expressions as they are entered, catches keyboard keys for
expression entry; 2.0 added integrated command-line popups, a recent
calculations history display popup, fonts and colors configuration,
help and about popups, preimported math/random constants, and more;

3.0+ (PP4E, version number retained):
-port to run under Python 3.X (only)
-drop 'L' keypress (the long type is now dead in earnest)

3.0 changes (PP3E):
-use 'readonly' entry state, not 'disabled', else field is greyed
 out (fix for 2.3 Tkinter change);
-avoid extended display precision for floats by using str(), instead
 of `x`/repr() (fix for Python change);
-apply font to input field to make it larger;
-use justify=right for input field so it displays on right, not left;
-add 'E+' and 'E-' buttons (and 'E' keypress) for float exponents;
 'E' keypress must generally be followed digits, not + or - optr key;
-remove 'L' button (but still allow 'L' keypress): superfluous now,
 because Python auto converts up if too big ('L' forced this in past);
-use smaller font size overall;
-auto scroll to the end in the history window

to do: add a commas-insertion mode (see str.format and LP4E example);
allow '**' as an operator key; allow '+' and 'J' inputs for complex 
Numbers; use new decimal type for fixed precision floats; as is, can 
use 'cmd' popup windows to input and evaluate things like complex, but 
can't be input via main window; caveat: PyCalc's precision, accuracy,
and some of its behaviour, is currently bound by result of str() call;
################################################################################
"""

from tkinter import *                                            # widgets, consts
from PP4E.Gui.Tools.guimixin import GuiMixin                     # quit method
from PP4E.Gui.Tools.widgets import label, entry, button, frame   # widget builders
Fg, Bg, Font = 'black', 'skyblue', ('courier', 14, 'bold')       # default config

debugme = True
def trace(*args):
    if debugme: print(args)


################################################################################
# the main class - handles user interface;
# an extended Frame, on new Toplevel, orembedded in another container widget
################################################################################

class CalcGui(GuiMixin, Frame):
    Operators = "+-*/="                              # button lists
    Operands  = ["abcd", "0123", "4567", "89()"]     # customizable

    def __init__(self, parent=None, fg=Fg, bg=Bg, font=Font):
        Frame.__init__(self, parent)
        self.pack(expand=YES, fill=BOTH)             # all parts expandable
        self.eval = Evaluator()                      # embed a stack handler
        self.text = StringVar()                      # make a linked variable
        self.text.set("0")
        self.erase = 1                               # clear "0" text next
        self.makeWidgets(fg, bg, font)               # build the GUI itself
        if not parent or not isinstance(parent, Frame):
            self.master.title('PyCalc 3.0')          # title iff owns window
            self.master.iconname("PyCalc")           # ditto for key bindings
            self.master.bind('<KeyPress>', self.onKeyboard)
            self.entry.config(state='readonly')      # 3.0: not 'disabled'=grey
        else:
            self.entry.config(state='normal')
            self.entry.focus()

    def makeWidgets(self, fg, bg, font):             # 7 frames plus text-entry
        self.entry = entry(self, TOP, self.text)     # font, color configurable
        self.entry.config(font=font)                 # 3.0: make display larger
        self.entry.config(justify=RIGHT)             # 3.0: on right, not left
        for row in self.Operands:
            frm = frame(self, TOP)
            for char in row:
                button(frm, LEFT, char,
                            lambda op=char: self.onOperand(op),
                            fg=fg, bg=bg, font=font)

        frm = frame(self, TOP)
        for char in self.Operators:
            button(frm, LEFT, char,
                        lambda op=char: self.onOperator(op),
                        fg=bg, bg=fg, font=font)

        frm = frame(self, TOP)
        button(frm, LEFT, 'dot ', lambda: self.onOperand('.'))
        button(frm, LEFT, ' E+ ', lambda: self.text.set(self.text.get()+'E+'))
        button(frm, LEFT, ' E- ', lambda: self.text.set(self.text.get()+'E-'))
        button(frm, LEFT, 'cmd ', self.onMakeCmdline)
        button(frm, LEFT, 'help', self.help)
        button(frm, LEFT, 'quit', self.quit)       # from guimixin

        frm = frame(self, BOTTOM)
        button(frm, LEFT, 'eval ', self.onEval)
        button(frm, LEFT, 'hist ', self.onHist)
        button(frm, LEFT, 'clear', self.onClear)

    def onClear(self):
        self.eval.clear()
        self.text.set('0')
        self.erase = 1

    def onEval(self):
        self.eval.shiftOpnd(self.text.get())     # last or only opnd
        self.eval.closeall()                     # apply all optrs left
        self.text.set(self.eval.popOpnd())       # need to pop: optr next?
        self.erase = 1

    def onOperand(self, char):
        if char == '(':
            self.eval.open()
            self.text.set('(')                      # clear text next
            self.erase = 1
        elif char == ')':
            self.eval.shiftOpnd(self.text.get())    # last or only nested opnd
            self.eval.close()                       # pop here too: optr next?
            self.text.set(self.eval.popOpnd())
            self.erase = 1
        else:
            if self.erase:
                self.text.set(char)                     # clears last value
            else:
                self.text.set(self.text.get() + char)   # else append to opnd
            self.erase = 0

    def onOperator(self, char):
        self.eval.shiftOpnd(self.text.get())    # push opnd on left
        self.eval.shiftOptr(char)               # eval exprs to left?
        self.text.set(self.eval.topOpnd())      # push optr, show opnd|result
        self.erase = 1                          # erased on next opnd|'('

    def onMakeCmdline(self):
        new = Toplevel()                            # new top-level window
        new.title('PyCalc command line')            # arbitrary Python code
        frm = frame(new, TOP)                       # only the Entry expands
        label(frm, LEFT, '>>>').pack(expand=NO)
        var = StringVar()
        ent = entry(frm, LEFT, var, width=40)
        onButton = (lambda: self.onCmdline(var, ent))
        onReturn = (lambda event: self.onCmdline(var, ent))
        button(frm, RIGHT, 'Run', onButton).pack(expand=NO)
        ent.bind('<Return>', onReturn)
        var.set(self.text.get())

    def onCmdline(self, var, ent):            # eval cmdline pop-up input
        try:
            value = self.eval.runstring(var.get())
            var.set('OKAY')
            if value != None:                 # run in eval namespace dict
                self.text.set(value)          # expression or statement
                self.erase = 1
                var.set('OKAY => '+ value)
        except:                               # result in calc field
            var.set('ERROR')                  # status in pop-up field
        ent.icursor(END)                      # insert point after text
        ent.select_range(0, END)              # select msg so next key deletes

    def onKeyboard(self, event):
        pressed = event.char                  # on keyboard press event
        if pressed != '':                     # pretend button was pressed
            if pressed in self.Operators:
                self.onOperator(pressed)
            else:
                for row in self.Operands:
                    if pressed in row:
                        self.onOperand(pressed)
                        break
                else:                                          # 4E: drop 'Ll'
                    if pressed == '.':
                        self.onOperand(pressed)                # can start opnd
                    if pressed in 'Ee':  # 2e10, no +/-
                        self.text.set(self.text.get()+pressed) # can't: no erase
                    elif pressed == '\r':
                        self.onEval()                          # enter key=eval
                    elif pressed == ' ':
                        self.onClear()                         # spacebar=clear
                    elif pressed == '\b':
                        self.text.set(self.text.get()[:-1])    # backspace
                    elif pressed == '?':
                        self.help()

    def onHist(self):
        # show recent calcs log popup
        from tkinter.scrolledtext import ScrolledText     # or PP4E.Gui.Tour
        new = Toplevel()                                  # make new window
        ok = Button(new, text="OK", command=new.destroy)
        ok.pack(pady=1, side=BOTTOM)                      # pack first=clip last
        text = ScrolledText(new, bg='beige')              # add Text + scrollbar
        text.insert('0.0', self.eval.getHist())           # get Evaluator text
        text.see(END)                                     # 3.0: scroll to end
        text.pack(expand=YES, fill=BOTH)

        # new window goes away on ok press or enter key
        new.title("PyCalc History")
        new.bind("<Return>", (lambda event: new.destroy()))
        ok.focus_set()                      # make new window modal:
        new.grab_set()                      # get keyboard focus, grab app
        new.wait_window()                   # don't return till new.destroy

    def help(self):
        self.infobox('PyCalc', 'PyCalc 3.0+\n'
                               'A Python/tkinter calculator\n'
                               'Programming Python 4E\n'
                               'May, 2010\n'
                               '(3.0 2005, 2.0 1999, 1.0 1996)\n\n'
                               'Use mouse or keyboard to\n'
                               'input numbers and operators,\n'
                               'or type code in cmd popup')


################################################################################
# the expression evaluator class
# embedded in and used by a CalcGui instance, to perform calculations
################################################################################

class Evaluator:
    def __init__(self):
        self.names = {}                         # a names-space for my vars
        self.opnd, self.optr = [], []           # two empty stacks
        self.hist = []                          # my prev calcs history log
        self.runstring("from math import *")    # preimport math modules
        self.runstring("from random import *")  # into calc's namespace

    def clear(self):
        self.opnd, self.optr = [], []           # leave names intact
        if len(self.hist) > 64:                 # don't let hist get too big
            self.hist = ['clear']
        else:
            self.hist.append('--clear--')

    def popOpnd(self):
        value = self.opnd[-1]                   # pop/return top|last opnd
        self.opnd[-1:] = []                     # to display and shift next
        return value                            # or x.pop(), or del x[-1]

    def topOpnd(self):
        return self.opnd[-1]                    # top operand (end of list)

    def open(self):
        self.optr.append('(')                   # treat '(' like an operator

    def close(self):                            # on ')' pop downto highest '('
        self.shiftOptr(')')                     # ok if empty: stays empty
        self.optr[-2:] = []                     # pop, or added again by optr

    def closeall(self):
        while self.optr:                        # force rest on 'eval'
            self.reduce()                       # last may be a var name
        try:
            self.opnd[0] = self.runstring(self.opnd[0])
        except:
            self.opnd[0] = '*ERROR*'            # pop else added again next:

    afterMe = {'*': ['+', '-', '(', '='],       # class member
               '/': ['+', '-', '(', '='],       # optrs to not pop for key
               '+': ['(', '='],                 # if prior optr is this: push
               '-': ['(', '='],                 # else: pop/eval prior optr
               ')': ['(', '='],                 # all left-associative as is
               '=': ['('] }

    def shiftOpnd(self, newopnd):               # push opnd at optr, ')', eval
        self.opnd.append(newopnd)

    def shiftOptr(self, newoptr):               # apply ops with <= priority
        while (self.optr and
               self.optr[-1] not in self.afterMe[newoptr]):
            self.reduce()
        self.optr.append(newoptr)               # push this op above result
                                                # optrs assume next opnd erases
    def reduce(self):
        trace(self.optr, self.opnd)
        try:                                    # collapse the top expr
            operator       = self.optr[-1]      # pop top optr (at end)
            [left, right]  = self.opnd[-2:]     # pop top 2 opnds (at end)
            self.optr[-1:] = []                 # delete slice in-place
            self.opnd[-2:] = []
            result = self.runstring(left + operator + right)
            if result == None:
                result = left                   # assignment? key var name
            self.opnd.append(result)            # push result string back
        except:
            self.opnd.append('*ERROR*')         # stack/number/name error

    def runstring(self, code):
        try:                                                  # 3.0: not `x`/repr
            result = str(eval(code, self.names, self.names))  # try expr: string
            self.hist.append(code + ' => ' + result)          # add to hist log
        except:
            exec(code, self.names, self.names)                # try stmt: None
            self.hist.append(code)
            result = None
        return result

    def getHist(self):
        return '\n'.join(self.hist)

def getCalcArgs():
    from sys import argv                   # get cmdline args in a dict
    config = {}                            # ex: -bg black -fg red
    for arg in argv[1:]:                   # font not yet supported
        if arg in ['-bg', '-fg']:          # -bg red' -> {'bg':'red'}
            try:
                config[arg[1:]] = argv[argv.index(arg) + 1]
            except:
                pass
    return config

if __name__ == '__main__':
    CalcGui(**getCalcArgs()).mainloop()    # in default toplevel window
