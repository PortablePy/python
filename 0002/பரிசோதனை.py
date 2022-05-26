import sys
அ = [[0], [1]]
ஆ=map(str,அ)
இ=list(ஆ)
print((' '.join(இ),))
ஈ=1234
உ ='integers:..%d...%-6d...%06d'%(ஈ,ஈ,ஈ)
print (உ)

my_list = [1,2,3]
try:
    # raise ValueError()
    my_list[5] = 0
except IndexError as e:
    print(e)
else :
    print("else")
finally :
    print("Finally")


t ='%(a)s, %(b)s, %(c)s'
print(t%dict(a='hello', b='world', c='universe'))

