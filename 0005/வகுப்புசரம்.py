#!/usr/bin/env python3

# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)



class RevStr(str):
    def __str__(self):
        return self[::-1]

def முதன்மை():
    hello = RevStr('வணக்கம் வருக.')
    அச்சிடு(hello)

if __name__ == '__main__': முதன்மை()
