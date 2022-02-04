# முக்கியசொல் தொகுதி
# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)


import keyword as முக்கியசொல்

சொற்கள்= list("""False      await      else       import     pass
None       break      except     in         raise
True       class      finally    is         return
and        continue   for        lambda     try
as         def        from       nonlocal   while
assert     del        global     not        with
async      elif       if         or         yield""".split())

#அச்சிடு(சொற்கள்)

for சொல் in சொற்கள்:
    அச்சிடு(சொல்,"-முக்கியசொல்? ",முக்கியசொல்.iskeyword(சொல்))
