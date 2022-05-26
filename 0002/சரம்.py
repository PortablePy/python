print("xudsttadxyy".endswith("xyy"))
print("xudsttadxyy".startswith("xyy"))
print("ab\tcd\tef".expandtabs())
print("xyyzxyzxzxyy".count('xyy',0,100))
print(("fun" in "this is fun"),("this is fun".index("fun")))
print("\t".isspace())
print("23234".isdigit())
print("for".isidentifier())
print("abcdef".center(7,"1"))
print(" ".join([x.capitalize() for x in "yo yo yo".split()]))

i =5
k = 4
print("%d"% k)
print(f"{k}")
print("{abc}".format(abc=k))
print('அஉ'.find('உ'))



import random
print(random.uniform(6,7))
import sys
a= sys.argv
print(a)