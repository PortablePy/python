import random

def gen_colors(code_size):
    colours = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    s = min (26, code_size)
    return colours[0:s]

def gen_code(code_size, colors):
    code = [random.choice(colors) for i in range(code_size)]
    out = "".join(code)
    return out


def check_guess(guess, code_size, colors):
    if len(guess) != code_size:
        return False 
    for c in guess:
        if c not in colors:
            return False
    return True     

def score_guess(code, guess):
    p_c = 0
    c_c = abs(len(code)-len(guess))
    for c, g in zip (code, guess):
        if c == g:
            p_c += 1
        elif g in code:
            c_c += 1
        else:
            pass
    return p_c, c_c

def play_cli(code_size, nb_colors):
    pos_col = gen_colors(code_size)
    print("Possible colors are", pos_col)
    print("Code is size", code_size)
    colors = gen_colors(code_size)
    code = gen_code(code_size, colors)
    found = False
    attempt = 0
    while not found:
        guess = input(f"{attempt} -->")
        l_c = len(guess) != code_size
        for g in guess:
            if g not in colors:
                l_c = False 
        if not l_c:
            print("Wrong size or color !")
        else :
            found = check_guess(guess,code_size,colors)
            score = score_guess(code,guess)
            attempt += 1
            if not found:
                print(score)
            else:
                print(f"Congrats, you won after {attempt} attempts !")

if __name__ == "__main__":
    play_cli(4,6)

"""
0 --> FFRJ

0 --> FFFFF
Wrong size or color !
0 --> ABCD
(0, 0)
1 --> FFEE
(3, 0)
2 --> FFFE

"""

"""
print(score_guess('ABCD', 'ABCD') == (4, 0))
print(score_guess('AAAA', 'ABCD') == (1, 0))
print(score_guess('AADA', 'ABCD') == (1, 1))
print(score_guess('ADDA', 'ABCD') == (1, 1))
print(score_guess('ADDB', 'ABCD') == (1, 2))
print(not check_guess('ZZZZ', 4, 'ABCDEF')) 
print(not check_guess('EEBBAA', 4, 'ABCDEF'))
print(check_guess('AABB', 4, 'ABCDEF'))
print(gen_colors(6) == 'ABCDEF')
print(gen_colors(295) == 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
print(gen_code(4, 'ABCDEF'))
print(gen_code(5, 'ABCD'))
"""
