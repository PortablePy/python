#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ


# Text Wrap Module
import textwrap

websiteText = """   உங்கள் கணினி, மொபைல் சாதனம் மற்றும் தொலைக்காட்சியில் உள்ள
எங்கள் பயன்பாடுகளுடன் கற்றல் எங்கும் நிகழலாம், இதில் மேம்பட்ட வழிசெலுத்தல்
மற்றும் எந்த நேரத்திலும் கற்றலுக்கான வேகமான ஓடை இடம்பெறும்.
வரம்பற்ற கற்றல், வரம்பற்ற சாத்தியங்கள்."""

அச்சிடு("No Dedent:")
அச்சிடு(textwrap.fill(websiteText))

அச்சிடு("Dedent")
dedent_text = textwrap.dedent(websiteText).strip()
அச்சிடு(dedent_text)

அச்சிடு("Fill")
அச்சிடு()
அச்சிடு(textwrap.fill(dedent_text, width=50))
அச்சிடு(textwrap.fill(dedent_text, width=100))

அச்சிடு("Controlling Indent")
அச்சிடு(textwrap.fill(dedent_text, initial_indent="   ", subsequent_indent="          "))

அச்சிடு("Shortening Text")
short = textwrap.shorten("LinkedIn.com is great!", width=15, placeholder="...")
அச்சிடு(short)
