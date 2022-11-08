import unicodedata

def is_anagram(left, right):
    left = unicodedata.normalize('NFKD', left.lower())
    right = unicodedata.normalize('NFKD', right.lower())
    llist = sorted(list(left))
    rlist = sorted(list(right))
    llist = [c for c in llist if c >= 'a' and c<='z']
    rlist = [c for c in rlist if c >= 'a' and c<='z']
    left = "".join(llist)
    right = "".join(rlist)
    left = left.strip()
    right = right.strip()
    msize = max(len(left), len (right))
    print(left,right)
    for i in range(msize):
        try:
            a = left[i]
        except:
            a = " "
        try:
            b = right[i]
        except:
            b = " "
        if a == " " or a == "-" or a == "'" or a == '"':
            missing = False
        else:
            missing = (a != b)
        if missing:
            return False
    return True

print(is_anagram("juste", "sujet"))
print(is_anagram("aba", "ba"))
print(is_anagram("paître", "pirate"))

"""

Superfluous (or missing) spaces, quotes, dashes, ... are allowed:
funeral is an anagram of real fun.

Diactirics of any language are ignored: crâné is an anagram of crane.
"""