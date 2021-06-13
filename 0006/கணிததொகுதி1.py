# கணித தொகுதி பகுதி 1
# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)

import math as கணிதம்

# மாறிலிகள்
அச்சிடு('பையின் மதிப்பு : ', கணிதம்.pi)
அச்சிடு('இயின் மதிப்பு : ',கணிதம்.e)

அச்சிடு('இயின் மதிப்பு : ',கணிதம்.nan)
அச்சிடு('இயின் மதிப்பு : ',கணிதம்.inf)
அச்சிடு('இயின் மதிப்பு : ',-கணிதம்.inf)

# முக்கோணவியல் 
அ = கணிதம்.cos(கணிதம்.pi / 4)
அச்சிடு('இயின் மதிப்பு : ',அ)
அச்சிடு('இயின் மதிப்பு : ',கணிதம்.sin(கணிதம்.pi / 4))

# உச்சவரம்பு மற்றும் தரை 
அச்சிடு(கணிதம்.ceil(10.3))
அச்சிடு(கணிதம்.ceil(7.8))

அச்சிடு(கணிதம்.floor(47.9))
அச்சிடு(கணிதம்.floor(48.1))
