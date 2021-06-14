#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ


# Zipfile Module
import zipfile

# Open and List
zip = zipfile.ZipFile('Archive.zip', 'r')
print(zip.namelist())

# Metadata in the zip folder
for meta in zip.infolist():
    print(meta)

info = zip.getinfo("purchased.txt")
print(info)

# Access to files in zip folder
print(zip.read("wishlist.txt"))
with zip.open('wishlist.txt') as f:
    print(f.read())

# Extracting files
#zip.extract("purchased.txt")
zip.extractall()

# Closing the zip
zip.close()

