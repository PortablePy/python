#!/usr/bin/env python3

# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)

class தலைகீழ்சரம்(str):
    def __str__(சுயம்):
        return சுயம்[::-1]

def முதன்மை():
    வாழ்த்து = தலைகீழ்சரம்('வணக்கம் வருக.')
    அச்சிடு(வாழ்த்து)

if __name__ == '__main__': முதன்மை()
