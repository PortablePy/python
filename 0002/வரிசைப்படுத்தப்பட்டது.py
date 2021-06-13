#வரிசைப்படுத்தப்பட்டது
# உள்ளீடு, அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# Least to Greatest
pointsInaGame = [0, -10, 15, -2, 1, 12]
sortedGame = sorted(pointsInaGame)
அச்சிடு(sortedGame)

# Alphabetically
children = ["Sue", "Jerry", "Linda"]
அச்சிடு(sorted(children))
அச்சிடு(sorted(["Sue", "jerry", "linda"]))

# Key Parameters
அச்சிடு(sorted("My favorite child is புகழ்".split(), key=str.upper))
அச்சிடு(sorted(pointsInaGame, reverse=True))

leaderBoard = {231: "வர்மன்", 123:"அருள்", 432:"மொழி"}
அச்சிடு(sorted(leaderBoard, reverse=True))
அச்சிடு(leaderBoard.get(432))

மாணவர்கள் = [ ('தேன்', 'ஆ', 12), ('புகழ்', 'அ', 16), ('அருள்', 'இ', 15)]
அச்சிடு(sorted(மாணவர்கள், key=lambda student:student[0]))
அச்சிடு(sorted(மாணவர்கள், key=lambda student:student[1]))
அச்சிடு(sorted(மாணவர்கள், key=lambda student:student[2]))

