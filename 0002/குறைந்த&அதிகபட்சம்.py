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
அச்சிடு(min(playerOneScore, playerTwoScore))
அச்சிடு(min(0, 12, -19))

அச்சிடு(min("Kathryn", "Katie"))
அச்சிடு(min("Angela", "Bob"))

அச்சிடு(max(playerOneScore, playerTwoScore))
playerThreeScore = 14
அச்சிடு(max(playerThreeScore, playerTwoScore, playerOneScore))
அச்சிடு(max("Kathryn", "Katie"))
