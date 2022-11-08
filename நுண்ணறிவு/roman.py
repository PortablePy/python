def to_roman_numeral(n):
    out = ""
    while not  n ==0: 
        if n>=1000:
            q = n//1000
            n = n%1000
            out += q*'M'
        elif 800<n<1000:
            out = out + to_roman_numeral(1000-n) + "M"
            n = 0
        elif n >= 500:
            q = n//500
            n = n%500
            out += q*'D'
        elif 300<n<500:
            out = out + to_roman_numeral(500-n) + "D"
            n = 0
        elif n >= 100:
            q = n//100
            n = n%100
            out += q*'C'
        elif 89<n<100:
            t = (n//10)*10
            q = (100-t)//10
            out = out + to_roman_numeral(10*q) + "C"
            n = n%10
        elif n >= 50:
            q = n//50
            n = n%50
            out += q*'L'
        elif 39<n<50:
            t = (n//10)*10
            q = (50-t)//10
            out = out + to_roman_numeral(q*10) + "L"
            n = n%10
        elif n >= 10:
            q = n//10
            n = n%10
            out += q*'X'
        elif 8<n<10:
            out = out + to_roman_numeral(10-n) + "X"
            n = 0
        elif n >= 5:
            q = n//5
            n = n%5
            out += q*'V'
        elif 3<n<5:
            out = out + to_roman_numeral(5-n) + "V"
            n = 0
        else :
            out += n*'I'
            n = 0
    return out

for i in range(100):
    print(to_roman_numeral(i))