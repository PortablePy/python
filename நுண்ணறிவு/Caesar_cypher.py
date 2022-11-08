from string import ascii_lowercase, ascii_uppercase
a = ord('a')
A = ord('A')

def caesar_cypher_encrypt(s, key):
    l1 =[]
    for c in s:
        if c in ascii_lowercase:
            d = chr(((ord(c)-a+key)%26)+ a)
        elif c in ascii_uppercase:
            d = chr(((ord(c)-A+key)%26)+ A)
        else :
            d = c
        l1.append(d)    
    return "".join(l1)    



def caesar_cypher_decrypt(s, key):
    l1 =[]
    for c in s:
        if c in ascii_lowercase:
            d = chr(((ord(c)-a-key)%26)+ a)
        elif c in ascii_uppercase:
            d = chr(((ord(c)-A-key)%26)+ A)
        else :
            d = c
        l1.append(d)    
    return "".join(l1)    


print( caesar_cypher_encrypt("a", 2) == 'c')
print( caesar_cypher_decrypt("c", 2) == 'a')
print( caesar_cypher_encrypt("Python is super disco !", 31) =='Udymts nx xzujw inxht !')
print( caesar_cypher_decrypt("Udymts nx xzujw inxht !", 31) == 'Python is super disco !')


"""

a with key == 2 gives c

a with key == 28 gives c

 caesar_cypher_encrypt(s, key) and caesar_cypher_decrypt(s, key) where:

    s is a string (letter, word, sentence, etc).
    key is a positive integer, the key of the caesar cypher.

"""