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
அச்சிடு(round(myGPA))
amountOfSalt = 1.4
அச்சிடு(round(amountOfSalt))

apple = -1.2
அச்சிடு(round(apple))
google = -1.6
அச்சிடு(round(google))

# abs()
distanceAway = -13
அச்சிடு(abs(distanceAway))
lengthOfRootInGround = -2.5
அச்சிடு(abs(lengthOfRootInGround))

# pow()
chanceOfTails = 0.5
inARowTails = 3
அச்சிடு(pow(chanceOfTails, inARowTails))

chanceOfOne = .167
inARowOne = 2
அச்சிடு(pow(chanceOfOne, inARowOne))
