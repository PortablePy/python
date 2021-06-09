# 
# மாறிகளுக்கான எடுத்துக்காட்டு கோப்பு
#

# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்):
    print(*வாதங்கள்)

# ஒரு மாறி அறிவித்து அதை துவக்க
அ=1
ஆ=1330
இ = f'{அ:>04}/{ஆ}' # வடிவமைக்கபட்ட சரம். பைத்தான் 3யில் அறிமுகப்படுத்தியது.
அச்சிடு (அ) # எண் வகுப்பை அச்சிடுகிறது
அச்சிடு (இ) # சரம்  வகுப்பை அச்சிடுகிறது
அச்சிடு(அ,ஆ,இ) # டுப்பில்(,வால் பிரிக்கப்பட்ட ) உள்ள மாறிகளை அச்சிடுகிறது

# மாறியை மறுவடிவமைத்தல்  வேலை செய்கிறது 
அ="அகர முதல "
அச்சிடு(அ)


# பிழை: வெவ்வேறு வகைகளின் மாறிகள் ஒன்றிணைக்க முடியாது.
#அச்சிடு(அ+"எழுத்தெல்லம் ஆதி பகவன் முதற்றே உலகு"+1)

#சரமாக மாற்றி இணைக்கவும்.
அச்சிடு(அ+"எழுத்தெல்லம் ஆதி பகவன் முதற்றே உலகு"+str(1))

அச்சிடு("{} எழுத்தெல்லம் ஆதி பகவன் முதற்றே உலகு {:>04}/{}".format(அ,1,1330))
# {} - இதை மாற்றுவதற்கு format இல் உள்ள வாதங்கள் பயன்படும்.


# {ஐ} - ஐ என்பது வாதங்களின் குறிஎண்
அச்சிடு("{0} எழுத்தெல்லம் ஆதி பகவன் முதற்றே உலகு {2:>04}/{1:>04}".format(அ,1,1330))

# {} - இது எந்த வாதத்தையும் மாற்றும்  
அச்சிடு("{} எழுத்தெல்லம் ஆதி பகவன் முதற்றே உலகு {}".format(அ,இ))

ஈ = [ 1, 2, 3  ] # ஈ என்பது வரிசை வகை மாறி
# குறிப்பாக பட்டியல் வகை மாறி
ஈ[0] = 42
# பட்டியல் மாறக்குடியது    

உ={1,2,3,4} # உ என்பது வரிசை வகை மாறி
# குறிப்பாக தொகுப்பு வகை மாறி

ஊ =(1,2,3,4,5) # ஊ என்பது வரிசை வகை மாறி
# குறிப்பாக பல தகவல் தொகுப்பு வகை மாறி
#ஊ[1]=45 # மாறதது

எ = {"ஞாயிறு":0, "திங்கள்":1, 'செவ்வாய்':2,'அறிவன்':3 } # எ என்பது வரிசை வகை மாறி
# குறிப்பாக அகராதி வகை மாறி

for ஐ in ஈ:
   அச்சிடு ('ஐ இன் மதிப்பு  {}'.format(ஐ))
   #பட்டியலிலிருந்து ஒவ்வொன்றாக அணுகவும்

for ஐ in உ:
   அச்சிடு ('ஐ இன் மதிப்பு  {}'.format(ஐ))
   #பட்டியலிலிருந்து ஒவ்வொன்றாக அணுகவும்
   
for ஐ in எ:
   அச்சிடு ('ஐ இன் மதிப்பு  {}'.format(ஐ))
   #பட்டியலிலிருந்து ஒவ்வொன்றாக அணுகவும்
   
for ஐ in எ.values():
   அச்சிடு ('ஐ இன் மதிப்பு  {}'.format(ஐ))
   #பட்டியலிலிருந்து ஒவ்வொன்றாக அணுகவும்

for ஐ in எ.keys():
   அச்சிடு ('ஐ இன் மதிப்பு  {}'.format(ஐ))
   #பட்டியலிலிருந்து ஒவ்வொன்றாக அணுகவும்

அச்சிடு (எ["அறிவன்"])

#செயல்பாடுகளில் உலகளாவிய எதிராக உள்ளூர் மாறிகள்
def செயல்பாடு():
    #global அ
    அ= "தலை"
    அச்சிடு (அ)

செயல்பாடு()
அச்சிடு (அ)

#del அ
#அச்சிடு(அ)

