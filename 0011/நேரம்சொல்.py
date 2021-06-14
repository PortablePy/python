#!/usr/bin/env python3

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import sys
import time

__version__ = '1.3.0'

class எண்சொற்கள்():
    '''
        return a number as words,
        e.g., 42 becomes 'forty-two'
    '''
    _words = {
        'ones': (
            'ஓ', 'ஒன்று', 'இரண்டு', 'மூன்று', 'நான்கு', 'ஐந்து', 'ஆறு', 'ஏழு', 'எட்டு', 'ஒன்பது'
        ), 'tens': (
            '', 'பத்து', 'இருபது', 'முப்பது', 'நாற்பது', 'ஐம்பது', 'அறுபது', 'எழுபது', 'எண்பது', 'தொண்ணூறு'
        ), 'teens': (
            'பத்து', 'பதினொரு', 'பன்னிரண்டு', 'பதின்மூன்று', 'பதினான்கு', 'பதினைந்து', 'பதினாறு', 'பதினேழு', 'பதினெட்டு', 'பத்தொன்பது' 
        ), 'quarters': (
            'o\'clock', ' கால் ',' பாதி '
        ), 'range': {
            'நூறு': 'நூறு'
        }, 'misc': {
            'கழித்தல்': 'கழித்தல்'
        }
    }
    _oor = 'OOR'    # வரம்பிற்கு வெளியே

    def __init__(சுய, n):
        சுய._number = n;

    def எண்சொற்கள்(சுய, num = None):
        'Return the number as words'
        n = சுய._number if num is None else num
        s = ''
        if n < 0:           # negative numbers
            s += சுய._words['misc']['minus'] + ' '
            n = abs(n)
        if n < 10:          # single-digit numbers
            s += சுய._words['ones'][n]  
        elif n < 20:        # teens
            s += சுய._words['teens'][n - 10]
        elif n < 100:       # tens
            m = n % 10
            t = n // 10
            s += சுய._words['tens'][t]
            if m: s += '-' + எண்சொற்கள்(m).எண்சொற்கள்()    # recurse for remainder
        elif n < 1000:      # hundreds
            m = n % 100
            t = n // 100
            s += சுய._words['ones'][t] + ' ' + சுய._words['range']['hundred']
            if m: s += ' ' + எண்சொற்கள்(m).எண்சொற்கள்()    # recurse for remainder
        else:
            s += சுய._oor
        return s

    def number(சுய, n = None):
        'setter/getter'
        if n is not None:
            சுய._number = n
        return str(சுய._number);

class நேரம்சொல்(எண்சொற்கள்):
    '''
        return the time (from two parameters) as words,
        e.g., fourteen til noon, quarter past one, etc.
    '''

    _specials = {
        'நண்பகல்': 'நண்பகல்',
        'நள்ளிரவு': 'நள்ளிரவு',
        'til': 'til',
        'கடந்து': 'கடந்து'
    }

    def __init__(சுய, h = None, m = None):
        சுய.time(h, m)

    def time(சுய, h = None, m = None):
        if h is not None:
            சுய._hour = abs(int(h))
        if m is not None:
            சுய._min = abs(int(m))
        return (h, m)

    def time_t(சுய, t = None):
        if t is None:
            t = time.localtime()
        சுய._hour = t.tm_hour
        சுய._min = t.tm_min

    def words(சுய):
        h = சுய._hour
        m = சுய._min
        
        if h > 23: return சுய._oor     # OOR errors
        if m > 59: return சுய._oor

        sign = சுய._specials['கடந்து']        
        if சுய._min > 30:
            sign = சுய._specials['til']
            h += 1
            m = 60 - m
        if h > 23: h -= 24
        elif h > 12: h -= 12

        # hword is the hours word)
        if h == 0: hword = சுய._specials['midnight']
        elif h == 12: hword = சுய._specials['noon']
        else: hword = சுய.எண்சொற்கள்(h)

        if m == 0:
            if h in (0, 12): return hword   # for noon and midnight
            else: return "{} {}".format(சுய.எண்சொற்கள்(h), சுய._words['quarters'][m])
        if m % 15 == 0:
            return "{} {} {}".format(சுய._words['quarters'][m // 15], sign, hword) 
        return "{} {} {}".format(சுய.எண்சொற்கள்(m), sign, hword) 

    def digits(சுய):
        'return the traditionl time, e.g., 13:42'
        return f'{சுய._hour:02}:{சுய._min:02}'

class நேரம்சொல்_t(நேரம்சொல்):   # wrapper for நேரம்சொல் to use time object
    '''
        set the time from a time object
    '''
    def __init__(சுய, t = None):
        சுய.time_t()

def main():
    if len(sys.argv) > 1:
        if sys.argv[1] == 'test':
            test()
        else:
            try: print(நேரம்சொல்(*(sys.argv[1].split(':'))).words())
            except TypeError: print('Invalid time ({})'.format(sys.argv[1]))
    else:
        print(நேரம்சொல்_t().words())

def test():
    st = நேரம்சொல்()
    print('\nnumbers test:')
    list = (
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 19, 20, 30, 
        50, 51, 52, 55, 59, 99, 100, 101, 112, 900, 999, 1000 
    )
    for l in list:
        st.number(l)
        print(l, st.எண்சொற்கள்())

    print('\ntime test:')
    list = (
        (0, 0), (0, 1), (11, 0), (12, 0), (13, 0), (12, 29), (12, 30),
        (12, 31), (12, 15), (12, 30), (12, 45), (11, 59), (23, 15), 
        (23, 59), (12, 59), (13, 59), (1, 60), (24, 0)
    )
    for l in list:
        st.time(*l)
        print(st.digits(), st.words())
    
    st.time_t() # set time to now
    print('\nlocal time is ' + st.words())

if __name__ == '__main__': main()
