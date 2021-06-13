r = range(0, 30)
print(type(r))
print(type(10))
print(type('a'))
print(type("Hi there"))

class Car:
    pass

class Truck():
    pass

c = Car()
convert = Car()
t = Truck()
print(type(c))
print(type(t))
print(type(c) == type(t))
print(type(c) == type(convert))

print(isinstance(c, Car))
print(isinstance(t, Car))

if isinstance(r, range):
    print(list(r))