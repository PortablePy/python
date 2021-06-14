# Minimum and Maximum

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

playerOneScore = 10
playerTwoScore = 4
print(min(playerOneScore, playerTwoScore))
print(min(0, 12, -19))

print(min("Kathryn", "Katie"))
print(min("Angela", "Bob"))

print(max(playerOneScore, playerTwoScore))
playerThreeScore = 14
print(max(playerThreeScore, playerTwoScore, playerOneScore))
print(max("Kathryn", "Katie"))
