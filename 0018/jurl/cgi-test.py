#!/usr/bin/env python3
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import sys, os, cgi
version = "5.3.1py cgi/{}".format(cgi.__version__)

for s in (
    "Content-type: text/plain", '',
    "BW Test version: {}".format(version),
    "Copyright 1995-2010 The BearHeart Group, LLC",
    "\nVersions:\n=================",
    "Python: {}".format(sys.version.split(' ')[0])
) :
    print(s)

form = cgi.FieldStorage()
if form :
    print("\nQuery Variables:\n=================")
    for k in sorted(form):
        v = ']['.join(form.getlist(k))  # multiple items as [a][b][c]...
        print("{} [{}]".format(k, v))

print("\nEnvironment Variables:\n=================")
for k in sorted(os.environ.keys()):
    v = os.environ[k]
    print("{} [{}]".format(k, v))

