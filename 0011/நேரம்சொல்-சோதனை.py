#!/usr/bin/env python3

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import TellTime as நேரம்சொல்

def முதன்மை():
    நே = நேரம்சொல்.நேரம்சொல்()
    அச்சிடு('\nஎண்கள் சோதனை:')
    பட்டியல்= (
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 19, 20, 30, 
        50, 51, 52, 55, 59, 99, 100, 101, 112, 900, 999, 1000 
    )
    for ஐ in பட்டியல்:
        நே.எண்(ஐ)
        அச்சிடு(ஐ, நே.எண்சொற்கள்())

    அச்சிடு('\nநேர சோதனை:')
    பட்டியல் = (
        (0, 0), (0, 1), (11, 0), (12, 0), (13, 0), (12, 29), (12, 30),
        (12, 31), (12, 15), (12, 30), (12, 45), (11, 59), (23, 15), 
        (23, 59), (12, 59), (13, 59), (1, 60), (24, 0)
    )
    for ஐ in பட்டியல்:
        நே.நேரம்(*ஐ)
        அச்சிடு(நே.digits(), நே.சொற்கள்())
    
    நே.நேரம்_t() # set time to now
    அச்சிடு('\nஉள்ளூர் நேரம் ' + நே.சொற்கள்())

if __name__ == '__main__': முதன்மை()
