# சீரற்ற தொகுதி
# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)

import random as சீரற்ற

# Random Numbers
சீரற்றஎண் = சீரற்ற.randint(1,52)
அச்சிடு ('சீரற்றஎண் : ',(சீரற்றஎண்))

அச்சிடு(சீரற்ற.random())
decider = சீரற்ற.randrange(2)
if decider == 0:
    அச்சிடு("HEADS")
else:
    அச்சிடு("TAILS")
அச்சிடு(decider)

அச்சிடு("You rolled a " + str(சீரற்ற.randrange(1, 7)))

# Random Choices
lotteryWinners = சீரற்ற.sample(range(100), 5)
அச்சிடு(lotteryWinners)

possiblePets = ["cat", "dog", "fish"]
அச்சிடு(சீரற்ற.choice(possiblePets))

cards = ["Jack", "Queen", "King", "Ace"]
சீரற்ற.shuffle(cards)
அச்சிடு(cards)


அச்சிடு (சீரற்ற.choice ([71,12,31,54,15,62]))
அச்சிடு (சீரற்ற.randrange (7,22,3))
அச்சிடு (சீரற்ற.random())
அ = [71,12,31,54,15,62]
அச்சிடு (அ)
சீரற்ற.shuffle (அ)
அச்சிடு (அ)
அச்சிடு (சீரற்ற.uniform (3,4))
