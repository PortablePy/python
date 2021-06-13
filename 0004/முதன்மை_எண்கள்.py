#!/usr/bin/env python3
#முதன்மை_எண்கள்

def isprime(n):
    if n <= 1:
        return False
    for x in range(2, n):
        if n % x == 0:
            return False
    else:
        return True

n = 5
if isprime(n):
    print(f'{n} முதன்மை எண்')
else:
    print(f'{n} முதன்மை எண் அல்ல')

