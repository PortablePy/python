def get_pascal(n):
    if n<1:
        return []
    elif n == 1:
        return [[1]]
    else:
        base = get_pascal(n-1)
        ref = base[-1]
        new_row =[]
        size = len(ref)
        for i in range(size):
            if i == 0:
                new_row.append(ref[0])
            else:
                new_row.append(ref[i-1]+ref[i])
        new_row.append(ref[-1])
        base.append(new_row)
        return base

def print_pascal_triangle(height):
    t=get_pascal(height)
    last = t[-1]
    size = len(last)
    n_width = len(str(max(last)))
    for i in range (len(t)):
        if i%2 == 1:
            print(1*" ", sep="", end="")
        print(n_width*" "*((size-i)//2), sep="", end="")
        for e in t[i]:
            print(e, n_width*" ", sep="", end="")
            
        print("")        
    
sorted(list,key=)
 
print_pascal_triangle(10)