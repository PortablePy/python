import random
def pwgen (length, with_digits, with_uppercase):
    symbols = []
    for i in range (26):
        symbols.append(chr(ord('a') + i))
    if with_digits:
        for i in range(10):
            symbols.append(chr(ord('0')+i))
    if with_uppercase:
        for i in range(26):
            symbols.append(chr(ord('A')+i))
    pwd_s = []
    s_len = len(symbols)
    print(s_len)
    for i in range(length):
        pwd_s.append(symbols[int(random.random()*s_len)])
    pwd = "".join(pwd_s)
    return pwd

print(pwgen(8, True, True ))