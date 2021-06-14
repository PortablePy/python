# Calculating Length

# len() --> returns length

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

def நீளம்(*arg):
    return len(*arg)

firstName = "Taylor"
அச்சிடு(நீளம்(firstName))
lastName = "Swift"
 அச்சிடு(நீளம்(lastName))
firstName.__len__()

ages = [0, 11, 43, 12, 10]
அச்சிடு(நீளம்(ages))
அச்சிடு(ages)

i = 0
for i in range(0, len(ages)):
    அச்சிடு(ages[i])

அச்சிடு(நீளம்(["bob", "mary", "sam"]))

candyCollection = {"bob" : 10, "mary" : 7, "sam" : 18}
அச்சிடு(நீளம்(candyCollection))

அச்சிடு(candyCollection)
