# பைத்தான் முழுமையாக்குதல், முழுமையான மதிப்பு மற்றும் அடுக்கு 

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# round()
எண் = 3.6
அச்சிடு(round(எண்))
உப்பு= 1.4
அச்சிடு(round(உப்பு))

மா = -1.2
அச்சிடு(round(மா ))
பலா = -1.6
அச்சிடு(round(பலா ))

# abs()
தூரம் = -13
அச்சிடு(abs(தூரம்))
வேர்நீளம் = -2.5
அச்சிடு(abs(வேர்நீளம்))

# pow()
பூவின்_வாய்ப்பு = 0.5
அடுத்தடுத்து = 3
அச்சிடு(pow(பூவின்_வாய்ப்பு , அடுத்தடுத்து))

ஐந்தின்_வாய்ப்பு = .167
தொடர்ந்து = 2
அச்சிடு(pow(ஐந்தின்_வாய்ப்பு, தொடர்ந்து))
