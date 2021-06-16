#!/usr/bin/env python3
# உள்ளீடு, அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
 
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ


ச = 'இன்பத்தமிழில் பைத்தான் '
க='கற்பது எளிது '
கசடற = ச+க
அச்சிடு (கசடற)

அ = க*4
அச்சிடு (அ)

அச்சிடு (ச[0:4])
அச்சிடு (ச[6:])
அச்சிடு (ச[9])
அச்சிடு (("ழ" in ச), ("அ" not in ச))
அச்சிடு ("சரம் :"+ச)

ச = 'இது மாற்றப்பட்ட சரம்'

அச்சிடு (ச)
அச்சிடு (ச[0:3])

அற = r'raw\nstring\t-எந்த சிறப்பு பொருளும் கிடையாது' # R'\n\t etc' -இப்படியும் எழுதலாம் 
அச்சிடு (அற)
அச்சிடு ('%%')
# Builtin string functions. சரம்.செயல்பாடு()
அச்சிடு (அற.capitalize())
அச்சிடு (அற.center(80, '*'))
அச்சிடு (அற.count('த'))
#encode('UTF-16')
#decode('UTF-16')
#
அச்சிடு (அற.endswith('து'))

#expandtabs()
#find
#index
#isalnum
#isalpha
#isdigit
#isdecimal
#islower
#isnumeric
#isspace
#istitle
#isupper
#join(seq)
#len(string)
#ljust(10)
#lower
#lstrip
#maketrans
#max
#min
#replace
#rfind
#rindex
#rjust
#rstrip
#split
#splitlines
#startswith
#strip
#swapcase()
#title
#translate()
#upper
#zfill

