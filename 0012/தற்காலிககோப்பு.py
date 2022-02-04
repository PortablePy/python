# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
import tempfile as தற்காலிககோப்பு


def அச்சிடு(*வாதங்கள், பிரி=" ", முடி='\n', கோப்பு=None, பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி, end=முடி, file=கோப்பு, flush=பறிப்பு)

# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.


def உள்ளீடு(*வாதங்கள்):
    அ = input(*வாதங்கள்)
    return அ


# Tempfile Module

# Create a temporary file
தகோப்பு = தற்காலிககோப்பு.TemporaryFile()

# Write to a temporary file
தகோப்பு.write(
    bytearray("இந்த சிறப்பு எண்ணை எனக்காக சேமிக்கவும்: 5678309", "utf8"))
தகோப்பு.seek(0)

# Read the temporary file
print(தகோப்பு.read())

# Close the temporary file
தகோப்பு.close()
