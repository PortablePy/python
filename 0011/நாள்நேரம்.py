#
#தமிழ் நாள் நேரம் கணக்கிடுதல்
#
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# முழுஎண் வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def முழுஎண் (*வாதங்கள்):
    அ=int(*வாதங்கள்)
    return அ

from datetime import datetime

def முதன்மை():
    இப்போது = datetime.now () # தற்போதைய தேதி மற்றும் நேரத்தைப் பெறுங்கள்
    
    #தமிழ் வாரநாள் - கிழமை
    வாரநாள்= முழுஎண்(இப்போது.strftime("%w"))
    கிழமைகள்= ["ஞாயிறு","திங்கள்","செவ்வாய்","அறிவன்","வியாழன்","வெள்ளி","காரி"]
    கிழமை=கிழமைகள்[வாரநாள்]

    # நிலையானவைகள்
    பொழுதுகள்=['வைகறை', 'காலை', 'நண்பகல்', 'எற்பாடு', 'மாலை', 'யாமம்']
    மாதங்கள்=['மார்கழி','தை','மாசி','பங்குனி','சித்திரை','வைகாசி','ஆனி','ஆடி','ஆவணி','புரட்டாசி','ஐப்பசி','கார்த்திகை']
    மாதநாட்கள் = [29.35,29.45,29.8,30.35,30.92,31.40,31.61,30.47,32.03,30.47,29.9,29.5]
    காலங்கள் = ['முன்பனி','பின்பனி','இளவேனில்','முதுவேனில்','கார்','கூதிர்']
    ஆநாள்=sum(மாதநாட்கள் )
    அச்சிடு (ஆநாள்)
    #தற்போதைய மணி, நிமையம் மற்றும் நொடி பெறுங்கள்
    நொடி=முழுஎண்(இப்போது.strftime("%S"))
    நிமையம்=முழுஎண்(இப்போது.strftime("%M"))
    மணி=முழுஎண்(இப்போது.strftime("%H"))
    நாள் = முழுஎண்(இப்போது.strftime("%d"))
    மாதம் = முழுஎண்(இப்போது.strftime("%m"))
    ஆண்டு = முழுஎண்(இப்போது.strftime("%Y"))
    # print( ஆண்டு, மாதம், நாள்,மணி, நிமையம், நொடி  )
    
    #தமிழ் நாள்நேர மாற்றம்
    
    if (மணி<2):
        மணி=மணி+24
        நாள்=நாள் -1
    மணி=மணி-2
    நிமையம்=மணி*60+நிமையம்
    #print( மணி, நிமையம் )

    #1கணம் = 4 நிமையம்
    கணம்=நிமையம்//4
    நிமையம்=நிமையம்%4
    #print( கணம், நிமையம் )

    # 1நாழிகை = 6 கணம்
    நாழிகை=கணம்//6
    கணம்=கணம்%6
    #print( கணம், நிமையம் )

    #1பொழுது= 10 நாழிகை
    சிறுபொழுது=நாழிகை//10
    நாழிகை=நாழிகை%10
    #print(  சிறுபொழுது,கணம்)
    
    பொழுது=பொழுதுகள்[சிறுபொழுது]


    #அச்சிடு("கிழமை "+கிழமை,"பொழுது "+பொழுது, "நாழிகை "+str(நாழிகை), "கணம் "+str(கணம்), "நிமையம் "+str(நிமையம்), "நொடி "+str(நொடி), sep=":")
    அச்சிடு("கிழமை",கிழமை,": பொழுது", பொழுது, ": நாழிகை", நாழிகை, ": கணம்",கணம், ": நிமையம்",நிமையம், ": நொடி",நொடி )

    மாதநாள் = நாள் -15
    if மாதநாள்<1:
        மாதநாள் = மாதநாள் + 30
        மாதம் = மாதம் -1
    if மாதம் < 1:
        மாதம் = மாதம் +12
        ஆண்டு = ஆண்டு -1

    மிதம் = 0.25* (ஆண்டு %4)
    if மிதம் == 0:
        pass
        
    திருவள்ளுவர்ஆண்டு = ஆண்டு +31
    காலம் = காலங்கள்[மாதம்//2]
    திங்கள் = மாதங்கள்[மாதம்]
    அச்சிடு("திருவள்ளுவர்ஆண்டு",திருவள்ளுவர்ஆண்டு, ':காலம்',காலம்,":திங்கள்",திங்கள் , )


if __name__ == "__main__":
  முதன்மை();
