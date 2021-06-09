#
# கணிதத்துடன் பணிபுரியும் அம்சங்களைக் கொண்ட கணித தொகுதியை import(இறக்குமதி ()) செய்க
#

# அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்):
    print(*வாதங்கள்)

import platform as நடைமேடை
பதிப்பு = நடைமேடை.python_version()
அச்சிடு ('இது பைத்தான் பதிப்பு :{}'.format(பதிப்பு))

import math as கணிதம்
import cmath

# கணித தொகுதி முன்பே கட்டப்பட்ட செயல்பாடுகளை கொண்டுள்ளது
அச்சிடு ("16 இன் சதுர வேர் ",கணிதம்.sqrt(16))

# செயல்பாடுகளுக்கு கூடுதலாக, சில தொகுதிகள் பயனுள்ள மாறிலிகளைக் கொண்டுள்ளன
அச்சிடு("பை இன் மதிப்பு ",கணிதம்.pi)

# உங்களுக்காக சில கணித செயல்பாடுகளை இங்கே முயற்சிக்கவும்:
அச்சிடு(கணிதம்.ceil(45.1))
அச்சிடு(கணிதம்.comb(5,3))
அச்சிடு(கணிதம்.copysign(4,-5))
அச்சிடு(கணிதம்.fabs(-4.51))
அச்சிடு(கணிதம்.factorial(5))
அச்சிடு(கணிதம்.floor(4.8))
அச்சிடு(கணிதம்.fmod(21,5))
அச்சிடு(கணிதம்.frexp(4.5))
அச்சிடு(sum([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1]))
அச்சிடு(கணிதம்.fsum([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1]))
அச்சிடு(கணிதம்.gcd(45,110))
அச்சிடு(கணிதம்.lcm(45,110))
அச்சிடு("சமம்?")
அச்சிடு(கணிதம்.isclose(1,.9999,rel_tol=1e-4))
அச்சிடு(கணிதம்.isinf(கணிதம்.inf))
அச்சிடு(கணிதம்.isnan(கணிதம்.nan))
அச்சிடு(கணிதம்.ldexp(3,5))
அச்சிடு(கணிதம்.modf(4.5))
அச்சிடு(கணிதம்.trunc(4.5))
# அடுக்கு செயல்பாடுகள்
அச்சிடு(கணிதம்.exp(4))
அச்சிடு(cmath.exp(4))
அச்சிடு(கணிதம்.expm1(4))
அச்சிடு(கணிதம்.log(4,2))
அச்சிடு(cmath.log(4,2))
அச்சிடு(கணிதம்.log1p(4))
அச்சிடு(கணிதம்.log2(4))
அச்சிடு(கணிதம்.log10(100))
அச்சிடு(cmath.log10(100))
அச்சிடு(கணிதம்.pow(4,2))
அச்சிடு(கணிதம்.sqrt(16))
அச்சிடு(cmath.sqrt(-16))
அச்சிடு(cmath.phase(-1+1j))
அச்சிடு(cmath.polar(-1+1j))
அச்சிடு(cmath.rect(1,கணிதம்.pi/4))

from math import *
# அனைத்து கணித செயல்பாடுகளும் நிறுவப்பட்டது. செயல்பாடுகளை அப்படியே அழைக்கலம்
அச்சிடு(sqrt(16))
அச்சிடு(acos(1))
அச்சிடு(asin(1)*180/pi)
அச்சிடு(atan(1)*180/pi)
அச்சிடு(cmath.acos(1))
அச்சிடு(cmath.asin(1)*180/pi)
அச்சிடு(cmath.atan(1)*180/pi)
அச்சிடு(atan2(1,2)*180/pi)
அச்சிடு(cos(pi/4))
அச்சிடு(sin(pi/2))
அச்சிடு(tan(pi/4))
அச்சிடு(cmath.cos(pi/4))
அச்சிடு(cmath.sin(pi/2))
அச்சிடு(cmath.tan(pi/4))
அச்சிடு(hypot(4,3))
அச்சிடு (dist((0,4),(3,0)))
# ஆரம் செயல்பாடுகள்
அச்சிடு(degrees(pi/4))
அச்சிடு(radians(180))
#hyrbolic செயல்பாடுகள்
அச்சிடு(cmath.tau)
அச்சிடு(tau)
அச்சிடு(cmath.pi)
அச்சிடு(pi)
அச்சிடு(cmath.e)
அச்சிடு(e)

அச்சிடு(acosh(1))
அச்சிடு(asinh(1))
அச்சிடு(atanh(.5))
அச்சிடு(cosh(0))
அச்சிடு(sinh(.88))
அச்சிடு(tanh(.54))
அச்சிடு(cmath.acosh(1))
அச்சிடு(cmath.asinh(1))
அச்சிடு(cmath.atanh(.5))
அச்சிடு(cmath.cosh(0))
அச்சிடு(cmath.sinh(.88))
அச்சிடு(cmath.tanh(.54))
அச்சிடு(gamma(4))
அச்சிடு(lgamma(4))
அச்சிடு(erf(4))
அச்சிடு(erf(4))
அச்சிடு(ulp(4))
