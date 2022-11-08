
import re
dev = [x for x in range(100) if x%3==0 if x%5 ==0]
print(dev)
test = [dev, dev, [45]]
print( test)

flist = [x for y in test for x in y]
print(flist)

tpls =[(x,y) for x in range (3) for y in range (3)]
print( tpls)

pattern = r"\d+"
if re.search(pattern, "cew232343testad"):
    print("Found")
    
a= {2,3,4}
a.add(6)
print(a)

c= {x**2 for x in [1,2,3,4,-2,-1]}
print(c)




from abc import ABC, abstractclassmethod




class Person:
    name = "John"
    age = 23

asdfg = Person()
print(asdfg)

class eng(Person):
    def __init__(self):
        super().__init__()

    @staticmethod
    def test(self):
        pass
    
    

testw=isinstance( asdfg, Person)
print(type(testw).__dict__)



        

