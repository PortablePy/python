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
    def handle_starttag(சுயம், குறிச்சொல், பண்புக்கூறுகள்):
        print("தொடக்க குறிச்சொல்: ", குறிச்சொல்)
        for பண்புக்கூறு in பண்புக்கூறுகள்:
            print("பண்புக்கூறு:", பண்புக்கூறு)
    def handle_endtag(சுயம், குறிச்சொல்):
        print("இறுதி குறிச்சொல்: ", குறிச்சொல்)
    def handle_comment(சுயம், தரவு):
        print("கருத்து: ", தரவு)
    def handle_data(சுயம், தரவு):
        print("தரவு: ", தரவு)

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
