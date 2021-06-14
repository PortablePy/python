# Python Rounding, Absolute Value, and Exponents

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# round()
myGPA = 3.6
print(round(myGPA))
amountOfSalt = 1.4
print(round(amountOfSalt))

apple = -1.2
print(round(apple))
google = -1.6
print(round(google))

# abs()
distanceAway = -13
print(abs(distanceAway))
lengthOfRootInGround = -2.5
print(abs(lengthOfRootInGround))

# pow()
chanceOfTails = 0.5
inARowTails = 3
print(pow(chanceOfTails, inARowTails))

chanceOfOne = .167
inARowOne = 2
print(pow(chanceOfOne, inARowOne))
