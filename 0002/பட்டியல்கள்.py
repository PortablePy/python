#!/usr/bin/env python3
# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள், பிரி=" ", முடி="\n", கோப்பு=None, பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி, end=முடி, file=கோப்பு, flush=பறிப்பு)


def முதன்மை():
    விலங்குகள் = ["ஆடு", "புலி", "சிங்கம்", "மாடு", "பூனை"]
    படியல்_அச்சிடு(விலங்குகள்)
    அச்சிடு(விலங்குகள்[1])
    அச்சிடு(விலங்குகள்[2:4])
    அச்சிடு(விலங்குகள்[1:5:2])
    ஐ = விலங்குகள்.index("பூனை")
    அச்சிடு(விலங்குகள்[ஐ])
    விலங்குகள்.append("கரடி")
    விலங்குகள்.insert(0, "மயில்")
    படியல்_அச்சிடு(விலங்குகள்)
    விலங்குகள்.sort()
    விலங்குகள்.remove("கரடி")
    படியல்_அச்சிடு(விலங்குகள்)
    விலங்கு = விலங்குகள்.pop()
    படியல்_அச்சிடு(விலங்குகள்)
    அச்சிடு(விலங்கு)
    விலங்கு = விலங்குகள்.pop(1)
    விலங்குகள்.remove("புலி")
    படியல்_அச்சிடு(விலங்குகள்)
    reversed(விலங்குகள்)
    அச்சிடு(விலங்கு)
    del விலங்குகள்[0]
    படியல்_அச்சிடு(விலங்குகள்)
    விலங்குகள் = ["ஆடு", "புலி", "சிங்கம்", "மாடு", "பூனை"]
    படியல்_அச்சிடு(விலங்குகள்)
    del விலங்குகள்[0:2]
    படியல்_அச்சிடு(விலங்குகள்)
    அச்சிடு(", ".join(விலங்குகள்))
    அச்சிடு(len(விலங்குகள்))


def படியல்_அச்சிடு(ஒ):
    for ஐ in ஒ:
        அச்சிடு(ஐ, முடி=" ", பறிப்பு=True)  # உணர்வாற்றல்
    அச்சிடு()


if __name__ == "__main__":
    முதன்மை()

# Range -> range instance that holds all nums counting by one between 0 and first input
# List -> lists numbers from the inputted tuple

பங்கேற்பாளர்கள் = range(20)

அச்சிடு(list(பங்கேற்பாளர்கள்))

for பங்கேற்பாளர் in list(பங்கேற்பாளர்கள்):
    அச்சிடு("பங்கேற்பாளர் " + str(பங்கேற்பாளர்) + " இங்கே ")

வெற்றிபெற்றவர்கள் = range(7, 20, 5)
அச்சிடு("வெற்றிபெற்றவர்கள் : ", list(வெற்றிபெற்றவர்கள்))
