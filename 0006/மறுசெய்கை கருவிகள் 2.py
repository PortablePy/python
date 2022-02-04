# மறு செய்கை கருவிகள் பகுதி 2

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import itertools as மறுசெய்கருவிகள்

# வரிசைமாற்றங்கள்: ஒழுங்கு விஷயங்கள் - சில பிரதிகள் ஒரே உள்ளீடுகளுடன் ஆனால் வெவ்வேறு வரிசையில் 
தேர்தல் = {1: "சீமான்", 2:"ச்டாலின்", 3:"பழனிசாமி"}
for வ in மறுசெய்கருவிகள்.permutations(தேர்தல்):
    print(வ)

for மா in மறுசெய்கருவிகள்.permutations(தேர்தல்.values()):
    print(மா)

# சேர்க்கைகள்: ஒழுங்கு ஒரு பொருட்டல்ல - ஒரே உள்ளீடுகளுடன் நகல்கள் இல்லை 
ஓவியவண்ணங்கள் = ["சிவப்பு", "நீலம்", "ஊதா", "ஆரஞ்சு", "மஞ்சள்", "இளஞ்சிவப்பு"]
for வண்ணம் in மறுசெய்கருவிகள்.combinations(ஓவியவண்ணங்கள், 3):
    print(வண்ணம்)
 
