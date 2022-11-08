import collections

def deform (obj=None):
    o_t = type(obj)
    if o_t == type(''):
        out = str(len(obj))+":"+obj
    elif o_t == type(0):
        out="i"+str(obj)+"e"
    elif o_t == type(list()):
        temp = []
        for i in obj:
            temp.append(deform(i))
        test = "".join(temp)
        out = "l"+test+"e"
    elif o_t == type(dict()):
        temp = []
        obj = collections.OrderedDict(sorted(obj.items()))
        for k, v in obj.items():
            temp.append(deform(k))
            temp.append(deform(v))
        test = "".join(temp)
        out = "d"+test+"e"
    else:
        out = deform(str(obj))
    return out
    

def form(inp:str):
    obj = inp
    s2 = None
    if inp[0] == "i":
        s1, s2 = inp.split("e",1)
        obj = int (s1[1:]) 
    elif inp[0].isdigit():
        li = inp.split(":", 1)
        obj = li[1][0:int(li[0])]
        s2 = li[1][int(li[0]):]
    elif inp[0] == "l":
        obj = []
        s2 = inp[1:]
        while (not s2[0] == 'e'):
            e1, s2 = form (s2)
            obj.append(e1)
        s2 = s2[1:]     
    elif inp[0] == "d":
        obj = dict()
        s2 = inp[1:]
        while ( not s2[0] == 'e' ):
            k1, s2 = form (s2)
            v1, s2 = form (s2)
            obj[k1]= v1
        s2 = s2[1:]        
    return obj, s2

def bencode (obj = None):
    out = None 
    if not obj == None :
        out = deform (obj)
        out = bytes(out,"utf-8")
    return out

def bdecode (bytes_in = None):
    obj = None
    inp = bytes_in.decode("utf-8")
    if bytes_in :
        obj, _ = form (inp)
    return obj


src = {"bar": "spam", "foo": 42}
src = []
src ={'t': 'aa', 'y': 'q', 'q': 'ping', 'a': {'id': '01234567890897653412'}}
print(src)
test = bencode(src)
print(test)
out = bdecode(test)
print(out)