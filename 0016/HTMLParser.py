# HTML Parser Module
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

from html.parser import HTMLParser

class HTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        print("Start tag: ", tag)
        for attr in attrs:
            print("attr:", attr)
    def handle_endtag(self, tag):
        print("End tag: ", tag)
    def handle_comment(self, data):
        print("Comment: ", data)
    def handle_data(self, data):
        print("Data: ", data)

parser = HTMLParser()
parser.feed("<html><head><title>Coder</title></head><body><h1><!--hi-->I am a coder</h1></body></html>")
print()

input = input("Put in HTML Code")
parser.feed(input)
print()

htmlFile = open("sampleHTML.html", "r")
s = ""
for line in htmlFile:
    s += line
parser.feed(s)
