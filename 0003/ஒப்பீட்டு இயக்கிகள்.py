# பைதான் ஒப்பீட்டு இயக்கிகள்

#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

# உதவிக்குறிப்புகள்:
# ==    -->  சமம்மா?
# !=     -->  சமம்மில்லையா?
# <=    --> குறைவாகவோ அல்லது சமமாகவோ உள்ளதா?
# > =   --> அதிகமாகவோ அல்லது சமமாகவோ உள்ளதா?
# <      --> ஐ விட குறைவா?
# >      --> ஐ விட பெரியதா?
# <      --> ஐ விட குறைவா?
அச்சிடு(10 != 75)
அச்சிடு(75 < 10)

if 10 < 75:
    அச்சிடு("எண் 75 10 ஐ விட பெரியது")
else:
    அச்சிடு('ஒப்பீடு தவறானது')

# ==    --> சமம்மா?
பூனைக்குட்டி = 10
புலி = 75

if பூனைக்குட்டி  < புலி:
    அச்சிடு("பூனைக்குட்டியை புலியை விட குறைவான எடை")

# <     --> ஐ விட குறைவாக உள்ளதா?
எலி = 1
if எலி < பூனைக்குட்டி  and எலி  < புலி:
    அச்சிடு("எலி மிகக் குறைந்த எடையைக் கொண்டுள்ளது")

#False --> 0
#True --> 1
# >     --> விட பெரியதா?
அச்சிடு(False > True)

# பொருந்தாத முதல் எழுத்தைத் தேடுகிறது
# A - Z -> 65 - 90
# >     --> விட பெரியது
அச்சிடு("அண்ணா" > "அருண்")


# <=    --> குறைவாகவோ அல்லது சமமாகவோ உள்ளது 
அச்சிடு('அ' <= 'ஆ')

print('abc' == 'abc')
# True

print('abc' == 'xyz')
# False

print('abc' == 'ABC')
# False

print('abc' != 'xyz')
# True

print('abc' != 'abc')
# False
print('bbb' in 'aaa-bbb-ccc')
# True

print('xxx' in 'aaa-bbb-ccc')
# False

print('abc' in 'aaa-bbb-ccc')
# False
not in returns True if it is not included, False if it is included.

print('xxx' not in 'aaa-bbb-ccc')
# True

print('bbb' not in 'aaa-bbb-ccc')
# False
print(s.startswith('aaa'))
# True

print(s.startswith('bbb'))
# False
 'bbb', 'ccc')))
# True

print(s.startswith(('xxx', 'yyy', 'zzz')))
# False

# print(s.startswith(['a', 'b', 'c']))
# TypeError: startswith first arg must be str or a tuple of str, not list

print(s.endswith('ccc'))
# True

print(s.endswith('bbb'))
# False

print(s.endswith(('aaa', 'bbb', 'ccc')))
# True

print('a' < 'b')
# True

print('aa' < 'ab')
# True

print('abc' < 'abcd')
# True

print(ord('a'))
# 97

print(ord('b'))
# 98
print('Z' < 'a')
# True

print(ord('Z'))
# 90

print(sorted(['aaa', 'abc', 'Abc', 'ABC']))
# ['ABC', 'Abc', 'aaa', 'abc']

s1 = 'abc'
s2 = 'ABC'

print(s1 == s2)
# False

print(s1.lower() == s2.lower())
# True

import re

s = 'aaa-AAA-123'

print(re.search('aaa', s))
# <re.Match object; span=(0, 3), match='aaa'>

print(re.search('xxx', s))
# None

print(re.search('^aaa', s))
# <re.Match object; span=(0, 3), match='aaa'>

print(re.search('^123', s))
# None

print(re.search('aaa$', s))
# None

print(re.search('123$', s))
# <re.Match object; span=(8, 11), match='123'>

print(re.search('[A-Z]+', s))
# <re.Match object; span=(4, 7), match='AAA'>

s = '012-3456-7890'

print(re.fullmatch(r'\d{3}-\d{4}-\d{4}', s))
# <re.Match object; span=(0, 13), match='012-3456-7890'>

s = 'tel: 012-3456-7890'

print(re.fullmatch(r'\d{3}-\d{4}-\d{4}', s))
# None


s = '012-3456-7890'

print(re.search(r'^\d{3}-\d{4}-\d{4}$', s))
# <re.Match object; span=(0, 13), match='012-3456-7890'>

s = 'tel: 012-3456-7890'

print(re.search('^\d{3}-\d{4}-\d{4}$', s))
# None

s = 'ABC'

print(re.search('abc', s))
# None

print(re.search('abc', s, re.IGNORECASE))
# <re.Match object; span=(0, 3), match='ABC'>
