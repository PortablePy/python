# சீரற்ற தொகுதி
# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)

from random import  *

# Random Numbers
print(random.random())
decider = random.randrange(2)
if decider == 0:
    print("HEADS")
else:
    print("TAILS")
print(decider)

print("You rolled a " + str(random.randrange(1, 7)))

# Random Choices
lotteryWinners = random.sample(range(100), 5)
print(lotteryWinners)

possiblePets = ["cat", "dog", "fish"]
print(random.choice(possiblePets))

cards = ["Jack", "Queen", "King", "Ace"]
random.shuffle(cards)
print(cards)


அச்சிடு (choice ([71,12,31,54,15,62]))
அச்சிடு (randrange (7,22,3))
அச்சிடு (random())
அ = [71,12,31,54,15,62]
அச்சிடு (அ)
shuffle (அ)
அச்சிடு (அ)
அச்சிடு (uniform (3,4))
