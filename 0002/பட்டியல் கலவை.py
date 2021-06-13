#!/usr/bin/env python3
# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)



# globals
dlevel = 0 # manage nesting level

def main():
    r = range(11)
    l = [ 1, 'இரண்டு', 3, {'4': 'நான்கு' }, 5 ]
    t = ( 'ஒன்று', 'இரண்டு', None, 'நான்கு', 'ஐந்து' )
    s = set("It's a bird! It's a plane! It's Superman!")
    d = dict( one = r, two = l, three = s )
    கலவை = [ l, r, s, d, t ]
    disp(கலவை)

def disp(o):
    global dlevel

    dlevel += 1
    if   isinstance(o, list):  அச்சிடு_படியல்(o)
    elif isinstance(o, range): அச்சிடு_படியல்(o)
    elif isinstance(o, tuple): அச்சிடு_tuple(o)
    elif isinstance(o, set):   அச்சிடு_set(o)
    elif isinstance(o, dict):  அச்சிடு_dict(o)
    elif o is None: அச்சிடு('Nada', முடி=' ', பறிப்பு=True)
    else: அச்சிடு(repr(o), முடி=' ', பறிப்பு=True)
    dlevel -= 1

    if dlevel <= 1: அச்சிடு() # newline after outer

def அச்சிடு_படியல்(o):
    அச்சிடு('[', முடி=' ')
    for x in o: disp(x)
    அச்சிடு(']', முடி=' ', பறிப்பு=True)

def அச்சிடு_tuple(o):
    அச்சிடு('(', முடி=' ')
    for x in o: disp(x)
    அச்சிடு(')', முடி=' ', பறிப்பு=True)

def அச்சிடு_set(o):
    அச்சிடு('{', முடி=' ')
    for x in sorted(o): disp(x)
    அச்சிடு('}', முடி=' ', பறிப்பு=True)

def அச்சிடு_dict(o):
    அச்சிடு('{', முடி=' ')
    for k, v in o.items():
        அச்சிடு(k, முடி=': ' )
        disp(v)
    அச்சிடு('}', முடி=' ', பறிப்பு=True)

if __name__ == '__main__': main()
