
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ


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
