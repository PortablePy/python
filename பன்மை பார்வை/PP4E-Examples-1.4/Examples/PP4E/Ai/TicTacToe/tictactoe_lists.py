# this file has been updated for Python 3.X 
# at least enough to run--I'd probably change more given time and need

import random, sys, time
from tkinter import *
from tkinter.messagebox import showinfo, askyesno
from PP4E.Gui.Tools.guimaker import GuiMakerWindowMenu

User, Machine = 'user', 'machine'        # players
X, O, Empty   = 'X', 'O', ' '            # board cell states
Fontsz = 50                              # defaults if no constructor args
Degree = 3                               # default=3 rows/cols=tic-tac-toe
Mode   = 'Expert2'                       # default machine move strategy

Debug = True
trace = print
def traceif(*args):
    if Debug:
        trace(*args)

def pp(board):
    if Debug:
        rows = (('\n\t' + str(row)) for row in board)    # 3.x: was map/lambda in prior
        return ''.join(rows)

helptext = """PyToe 1.1
Programming Python 4E
A Tic-tac-toe board game
written in Python with tkinter\n
Version 1.1: April 2010, Python 3.X port
Version 1.0: July  1999, developed for 2E\n
Click in cells to move.
Command-line arguments:\n
-degree N sets board size
 N=number rows/columns\n
-mode M sets machine skill
 M=Minimax, Expert1|2,...\n
-fg F, -bg B 
 F,B=color name\n
-fontsz N 
 N=marks size\n
-goesFirst user|machine
-userMark X|O"""

class Record:
    def __init__(self):
        self.win = self.loss = self.draw = 0

class TicTacToeBase(GuiMakerWindowMenu):                    # a kind of Frame
    def __init__(self, parent=None,                         # with a menu bar
                       fg='black', bg='white', fontsz=Fontsz,
                       goesFirst=User, userMark=X, 
                       degree=Degree):
        self.nextMove    = goesFirst
        self.userMark    = userMark
        self.machineMark = (userMark==X and O) or X         # or if/else expr
        self.degree      = degree
        self.record      = Record()
        self.makeWidgets = lambda: self.drawBoard(fg, bg, fontsz)     # no defaults
        GuiMakerWindowMenu.__init__(self, parent=parent)
        self.master.title('PyToe 1.1')
        if goesFirst == Machine: self.machineMove()   # else wait for click
        
    def start(self):
        self.helpButton = None
        self.toolBar    = None
        self.menuBar    = [ ('File', 0, [('Stats', 0, self.onStats),
                                         ('Quit',  0, self.quit)]),
                            ('Help', 0, [('About', 0, self.onAbout)]) ]

    def drawBoard(self, fg, bg, fontsz):
        self.coord = {}
        self.label = {}
        self.board = []              
        for i in range(self.degree):
            self.board.append([0] * self.degree)
            frm = Frame(self)
            frm.pack(expand=YES, fill=BOTH)
            for j in range(self.degree):
                widget = Label(frm, fg=fg, bg=bg, 
                                    text=' ', font=('courier', fontsz, 'bold'),
                                    relief=SUNKEN, bd=4, padx=10, pady=10)
                widget.pack(side=LEFT, expand=YES, fill=BOTH)
                widget.bind('<Button-1>', self.onLeftClick)
                self.coord[widget] = (i, j)
                self.label[(i, j)] = widget
                self.board[i][j]   = Empty

    def onLeftClick(self, event):
        label    = event.widget
        row, col = self.coord[label]
        if self.nextMove == User and self.board[row][col] == Empty:
            label.config(text=self.userMark)
            self.board[row][col] = self.userMark
            self.nextMove = Machine
            self.checkFinish()
            self.machineMove()

    def machineMove(self):
        row, col = self.pickMove()
        self.board[row][col] = self.machineMark
        label = self.label[(row, col)]
        label.config(text=self.machineMark)
        self.checkFinish()
        self.nextMove = User      # wait for next left click or quit

    def clearBoard(self):
         for row, col in self.label.keys():
            self.label[(row, col)].config(text=' ')
            self.board[row][col] = Empty

    #
    # end test
    #

    def checkDraw(self, board=None):
        board = board or self.board
        for row in board:
            if Empty in row:  
                return 0                                   # 3.x: True/False better
        return 1  # none empty = draw or win
 
    def checkWin(self, mark, board=None):
        board = board or self.board
        for row in board:
            if row.count(mark) == self.degree:             # check across
                return 1                                   # row=all mark?
        for col in range(self.degree): 
            for row in board:                              # check down
                if row[col] != mark:                       # break to next col
                    break
            else: 
                return 1 
        for row in range(self.degree):                     # check diag1
            col = row                                      # row == col
            if board[row][col] != mark: break 
        else:
            return 1
        for row in range(self.degree):                     # check diag2
            col = (self.degree-1) - row                    # row+col = degree-1
            if board[row][col] != mark: break
        else:
            return 1

    def checkFinish(self):
        outcome = None
        if self.checkWin(self.userMark):
            outcome = "You've won!"
            self.record.win += 1                     # 3.x: changed to use += globally
        elif self.checkWin(self.machineMark):        # for both style and performance
            outcome = 'I win again :-)'
            self.record.loss += 1
        elif self.checkDraw():
            outcome = 'Looks like a draw'
            self.record.draw += 1
        if outcome:
            result = 'Game Over: ' + outcome 
            if not askyesno('PyToe', result + '\n\nPlay another game?'):
                self.onStats()
                self.quit()
                sys.exit()          # don't return to caller
            else:
                self.clearBoard()   # return and make move or wait for click
                                    # player who moved last moves second next
    #
    # miscellaneous
    #

    def onAbout(self):
        showinfo('PyToe 1.0', helptext)

    def onStats(self):
        showinfo('PyToe Stats',
                 'Your results:\n'
                 'wins: %(win)d,  losses: %(loss)d,  draws: %(draw)d'
                  % self.record.__dict__)


######################################
# subclass to customize move selection
######################################


#
# pick empty slot at random
#

class TicTacToeRandom(TicTacToeBase):
    def pickMove(self):
        empties = []
        for row in self.degree:                      # 3.x: could be a comprehension
            for col in self.degree:
                if self.board[row][col] == Empty:
                    empties.append((row, col))
        return random.choice(empties)


#
# pick imminent win or loss, else static score
#

class TicTacToeSmart(TicTacToeBase):
    def pickMove(self):
        self.update(); time.sleep(1)  # too fast!
        countMarks = self.countAcrossDown(), self.countDiagonal()
        for row in range(self.degree):
            for col in range(self.degree):
                move = (row, col)
                if self.board[row][col] == Empty:
                    if self.isWin(move, countMarks):
                        return move
        for row in range(self.degree):
            for col in range(self.degree):
                move = (row, col)
                if self.board[row][col] == Empty:
                    if self.isBlock(move, countMarks):
                        return move
        best = 0
        for row in range(self.degree):
            for col in range(self.degree):
                move = (row, col)
                if self.board[row][col] == Empty:
                    score = self.scoreMove(move, countMarks)
                    if score >= best:
                        pick = move
                        best = score
        trace('Picked', pick, 'score', best)
        return pick

    def countAcrossDown(self):
        countRows  = {}                        # sparse data structure
        countCols  = {}                        # zero counts aren't added 
        for row in range(self.degree):
            for col in range(self.degree):
                mark = self.board[row][col]
                try:
                    countRows[(row, mark)] += 1
                except KeyError:
                    countRows[(row, mark)] = 1
                try: 
                    countCols[(col, mark)] += 1
                except KeyError:
                    countCols[(col, mark)] = 1
        return countRows, countCols

    def countDiagonal(self):
        tally = {'X':0, 'O':0, ' ':0}
        countDiag1 = tally.copy()
        for row in range(self.degree): 
            col  = row
            mark = self.board[row][col]
            countDiag1[mark] += 1                      # 3.x: use += 1, globally
        countDiag2 = tally.copy()
        for row in range(self.degree):
            col  = (self.degree-1) - row
            mark = self.board[row][col]
            countDiag2[mark] += 1
        return countDiag1, countDiag2

    def isWin(self, T, countMarks):         # 3.X drops tuple matching in arg lists
        (row, col) = T
        self.board[row][col] = self.machineMark
        isWin = self.checkWin(self.machineMark)
        self.board[row][col] = Empty
        return isWin

    def isBlock(self, T, countMarks): 
        (row, col) = T
        self.board[row][col] = self.userMark
        isLoss = self.checkWin(self.userMark)
        self.board[row][col] = Empty
        return isLoss

    def scoreMove(self, T1, T2):
       (row, col) = T1 
       ((countRows, countCols), (countDiag1, countDiag2)) = T2     # 3.x: no arg tuples
       return (
           countCols.get((col, self.machineMark), 0) * 11 +
           countRows.get((row, self.machineMark), 0) * 11 + 
           countDiag1[self.machineMark] * 11 + 
           countDiag1[self.machineMark] * 11 
           +
           countCols.get((col, self.userMark), 0) * 10 +
           countRows.get((row, self.userMark), 0) * 10 + 
           countDiag1[self.userMark] * 10 + 
           countDiag1[self.userMark] * 10 
           +
           countCols.get((col, Empty), 0) * 11 +
           countRows.get((row, Empty), 0) * 11 + 
           countDiag1[Empty] * 11 + 
           countDiag1[Empty] * 11)


#
# static score based on 1 or 2 move lookahead
#

class TicTacToeExpert1(TicTacToeSmart):
    def pickMove(self):
        self.update(); time.sleep(1)
        countMarks = self.countAcrossDown(), self.countDiagonal()
        best = 0
        for row in range(self.degree):
            for col in range(self.degree):
                move = (row, col)
                if self.board[row][col] == Empty:
                    score = self.scoreMove(move, countMarks)
                    if score > best:
                        pick = move
                        best = score
        trace('Picked', pick, 'score', best)
        return pick

    def countAcrossDown(self):
        tally = {'X':0, 'O':0, ' ':0}              # uniform with diagonals
        countRows  = []                            # no entries missing 
        countCols  = []                            # tally * degree fails
        for row in range(self.degree):
            countRows.append(tally.copy())
            countCols.append(tally.copy())
        for row in range(self.degree):
            for col in range(self.degree):
                mark = self.board[row][col]
                countRows[row][mark] += 1             # 3.x: += 1
                countCols[col][mark] += 1
        return countRows, countCols
        
    def scoreMove(self, T1, T2):                      # 3.x: no arg tuples
        (row, col) = T1 
        ((countRows, countCols), (countDiag1, countDiag2)) = T2
        score  = 0
        mine   = self.machineMark  
        user   = self.userMark    
                                                      # for empty slot (r,c):
        partof = [countRows[row], countCols[col]]     # check move row and col
        if row == col:                                # plus diagonals, if any
            partof.append(countDiag1)
        if row+col == self.degree-1: 
            partof.append(countDiag2)

        for line in partof:                                     
            if line[mine] == self.degree-1 and line[Empty] == 1:
                score += 51                                   # 1 move to win
        for line in partof:
            if line[user] == self.degree-1 and line[Empty] == 1: 
                score += 25                                   # 1 move to loss
        for line in partof:
            if line[mine] == self.degree-2 and line[Empty] == 2: 
                score += 10                                   # 2 moves to win
        for line in partof:
            if line[user] == self.degree-2 and line[Empty] == 2:
                score += 8                                    # 2 moves to loss
        for line in partof:
            if line[Empty] == self.degree:                    # prefer openness
                score += 1

        if score:
            return score                         # detected pattern here?
        else:                                    # else use weighted scoring
            for line in partof:
                score += line[mine] * 3 + line[user] + line[Empty] * 2
            return score / float(self.degree)    # 3.x: float not really needed for /


#
# static score based on win or loss N moves ahead
#

class TicTacToeExpert2(TicTacToeExpert1):
    def scoreMove(self, T1, T2):                      # 3.x: no arg tuples
        (row, col) = T1 
        ((countRows, countCols), (countDiag1, countDiag2)) = T2
        score  = 0
        mine   = self.machineMark  
        user   = self.userMark    
                                                      # for empty slot (r,c):
        partof = [countRows[row], countCols[col]]     # check move row and col
        if row == col:                                # plus diagonals, if any
            partof.append(countDiag1)
        if row+col == self.degree-1: 
            partof.append(countDiag2)

        weight = 3 ** (self.degree * 2)               # 3.x: not 3L, int does long
        for ahead in range(1, self.degree):
            for line in partof: 
                if line[mine] == self.degree - ahead and line[Empty] == ahead: 
                    score += weight

                if line[user] == self.degree - ahead and line[Empty] == ahead: 
                    score += weight // 3
            weight = weight // 9                 # 3.x: need // for int div

        if score:
            return score                         # detected pattern here?
        else:                                    # else use weighted scoring
            for line in partof:
                score += line[mine] * 3 + line[user] + line[Empty] * 2
            return score / float(self.degree)    # 3.x: float() not really needed


#
# search ahead through moves and countermoves
#

class TicTacToeMinimax(TicTacToeExpert2):
    def pickMove(self):
        self.update()
        numMarks = self.degree ** 2
        for row in self.board:
            numMarks -= row.count(Empty)
        if numMarks == 0:
            return (self.degree // 2, self.degree // 2)    # 3.x: need // for int div
        else:
            #traceif('\n\nPick move...')
            t1 = time.clock()
            maxdepth = numMarks + 4
            #traceif(maxdepth)
            score, pick = self.findMax(self.board, maxdepth)
            trace('Time to move:', time.clock() - t1)
            if score == -1:
                # lookahead can be too pessimistic
                # if best is a loss, use static score
                pick = TicTacToeExpert2.pickMove(self)                
            return pick

    def checkLeaf(self, board):
        if self.checkWin(self.machineMark, board):  # score from machine's view
            return +1                               # a win is good; a loss bad
        elif self.checkWin(self.userMark, board):
            return -1
        elif self.checkDraw(board):
            return 0
        else:
            return None

    def findMax(self, board, depth):        # machine move level
        #traceif('max start', depth, pp(board))
        if depth == 0:                      # find start of best move sequence
            return 0, None                  # could return static score here???
        else:
            term = self.checkLeaf(board)
            if term != None:                       # depth cutoff 
                #traceif('max term', term, pp(board))
                return term, None                  # or endgame detected
            else:                                  # or check countermoves
                best = -2
                for row in range(self.degree):
                    for col in range(self.degree):
                        if board[row][col] == Empty:
                            board[row][col] = self.machineMark
                            below, m = self.findMin(board, depth-1)
                            board[row][col] = Empty  
                            if below >= best:
                                best = below
                                pick = (row, col)
                #traceif('max best at', depth, best, pick)
                return best, pick

    def findMin(self, board, depth):        # user move level-find worst case
        #traceif('min start', depth, pp(board))
        if depth == 0:                      # assume she will do her best
            return 0, None
        else:
            term = self.checkLeaf(board)
            if term != None:                       # depth cutoff 
                #traceif('min term', term, pp(board))
                return term, None                  # or endgame detected
            else:                                  # or check countermoves
                best = +2
                for row in range(self.degree):
                    for col in range(self.degree):
                        if board[row][col] == Empty:
                            board[row][col] = self.userMark
                            below, m = self.findMax(board, depth-1)  
                            board[row][col] = Empty
                            if below < best:
                                best = below
                                pick = (row, col)
                #traceif('min best at', depth, best, pick)
                return best, pick


# moved to tictactoe.py:
# game object generator - external interface 
# command-line logic
