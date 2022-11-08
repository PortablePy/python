def caesar_cypher_encrypt(s, key):
    l1 =[]
    for c in s:
        l1.append(chr(ord(c)+key))
    return "".join(l1)    



def caesar_cypher_decrypt(s, key):
    l1 =[]
    for c in s:
        l1.append(chr(ord(c)-key))
    return "".join(l1)    

            