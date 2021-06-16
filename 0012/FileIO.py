# Files and File Writing
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# Open a file
myFile = open("scores.txt", "w")

# Show attributes and properties of that file
print("Name " + myFile.name)
print("Mode " + myFile.mode)

# Write to a file
myFile.write("GBJ : 100\nKHD : 99\nBBB : 89")
myFile.close()

# Read the file
myFile = open("scores.txt", "r")
print("Reading... : " + myFile.read(10))
print("Reading again : " + myFile.read(10))
myFile.close()
myFile = open("scores.txt", "r")
print("Reading... : " + myFile.read(10))
myFile.seek(0)
print("Reading again : " + myFile.read(10))
myFile.close()

# Iterative Files
myFile = open("scores.txt", "r")

# Read one line at a time
print("My one line: " + myFile.readline())
myFile.seek(0)

# Iterate through each line of a file
for line in myFile:
    newHighScorer = line.replace("BBB", "PDJ")
    print(newHighScorer)

myFile.close()
