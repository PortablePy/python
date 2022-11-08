"""


Your program will display a 79×40 table filled with # for ones (1s) and . for zeroes (0s), as a result of running an elementary automata for the given rule number (the int parameter).

The first line will always be filled with zeroes except for a single cell with a 1 right in the middle.

The "board" is a cylinder: on the left of the leftmost column is the rightmost column, and vice-versa.


"""
import sys

def next_bit(rule,l,c,r):
    if 0<=rule<=255:
        bitpos = 4*l+2*c+r
        binval = format(rule, '08b')
        binrev = binval[::-1]
        ystr = binrev[bitpos]
        y = int(ystr)
        return y
    else:
        raise ValueError("rule must be any valure in the range - 0 to 255")
        return None

def gen_next_row(cur_row, rule):
    size = len(cur_row)
    next_row = []
    for i in range(size):
        c = cur_row[i]
        l = cur_row[i-1]
        r = cur_row[(i+1)%size]
        next_row.append(next_bit(rule,l,c,r))
    return next_row    

def n_times(rule, n=39, width = 79):
    data = [0]*width
    data[width//2] = 1
    out = [data]
    for i in range(n):
        data = gen_next_row(data, rule)
        out.append(data)
    return out

def print_img(data, on ='#', off = '.'):
    strdata = [[on if c ==1 else off for c in r ] for r in data]
    msg = ""
    for s in strdata:
        msg += "".join(s) + "\n"
    print(msg)


if __name__ == '__main__':
    try:
        rule = int(sys.argv[1])
    except Exception:
        print("please provide an integer argument between 0 to 255")
    else:
        data = n_times(rule)
        print_img(data)
