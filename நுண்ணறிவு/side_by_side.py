import textwrap
import itertools


def sidebyside(left, right, width=79):
    w = (width -1)//2
    llist = textwrap.wrap(left,width=w)
    rlist = textwrap.wrap(right,width=w)
    out = ""
    for l,r in itertools.zip_longest(llist,rlist,fillvalue=" "*w):
        out += l+(w-len(l))*" "+'|'+ r +(w-len(r))*" "+ "\n"
    return out
                          
left = ("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
"Sed non risus. "
"Suspendisse lectus tortor, dignissim sit amet, "
"adipiscing nec, utilisez sed sin dolor."
)
right = (
"Morbi venenatis, felis nec pretium euismod, "
"est mauris finibus risus, consectetur laoreet "
"sem enim sed arcu. Maecenas sit amet eleifend sem. "
"Nullam ac libero metus. Praesent ac finibus nulla, vitae molestie dolor."
" Aliquam vestibulum viverra nisl, id porta mi viverra hendrerit."
" Ut et porta augue, et convallis ante."
)

print(sidebyside(left, right))
                          
"""
Lorem ipsum dolor sit amet, consectetur|Morbi venenatis, felis nec pretium     
adipiscing elit. Sed non risus.        |euismod, est mauris finibus risus,     
Suspendisse lectus tortor, dignissim   |consectetur laoreet sem enim sed arcu. 
sit amet, adipiscing nec, utilisez sed |Maecenas sit amet eleifend sem. Nullam 
sin dolor.                             |ac libero metus. Praesent ac finibus   
                                       |nulla, vitae molestie dolor. Aliquam   
                                       |vestibulum viverra nisl, id porta mi   
                                       |viverra hendrerit. Ut et porta augue,  
                                       |et convallis ante.
"""
print(sidebyside(left, right, 50))
"""
Lorem ipsum dolor sit   |Morbi venenatis, felis  
amet, consectetur       |nec pretium euismod, est
adipiscing elit. Sed non|mauris finibus risus,   
risus. Suspendisse      |consectetur laoreet sem 
lectus tortor, dignissim|enim sed arcu. Maecenas 
sit amet, adipiscing    |sit amet eleifend sem.  
nec, utilisez sed sin   |Nullam ac libero metus. 
dolor.                  |Praesent ac finibus     
                        |nulla, vitae molestie   
                        |dolor. Aliquam          
                        |vestibulum viverra nisl,
                        |id porta mi viverra     
                        |hendrerit. Ut et porta  
                        |augue, et convallis     
                        |ante.                   
"""
print(sidebyside(left, right, 100))
"""
Lorem ipsum dolor sit amet, consectetur          |Morbi venenatis, felis nec pretium euismod, est  
adipiscing elit. Sed non risus. Suspendisse      |mauris finibus risus, consectetur laoreet sem    
lectus tortor, dignissim sit amet, adipiscing    |enim sed arcu. Maecenas sit amet eleifend sem.   
nec, utilisez sed sin dolor.                     |Nullam ac libero metus. Praesent ac finibus      
                                                 |nulla, vitae molestie dolor. Aliquam vestibulum  
                                                 |viverra nisl, id porta mi viverra hendrerit. Ut  
                                                 |et porta augue, et convallis ante.               
"""
print(sidebyside(left, sidebyside(left, left, 50), 100))
"""
Lorem ipsum dolor sit amet, consectetur          |Lorem ipsum dolor sit   |Lorem ipsum dolor sit   
adipiscing elit. Sed non risus. Suspendisse      |amet, consectetur       |amet, consectetur       
lectus tortor, dignissim sit amet, adipiscing    |adipiscing elit. Sed non|adipiscing elit. Sed non
nec, utilisez sed sin dolor.                     |risus. Suspendisse      |risus. Suspendisse      
                                                 |lectus tortor, dignissim|lectus tortor, dignissim
                                                 |sit amet, adipiscing    |sit amet, adipiscing    
                                                 |nec, utilisez sed sin   |nec, utilisez sed sin   
                                                 |dolor.                  |dolor.                  
"""
print(sidebyside(left, right, width = 20))
"""
Lorem    |Morbi ven
ipsum    |enatis,  
dolor sit|felis nec
amet, con|pretium  
sectetur |euismod, 
adipiscin|est      
g elit.  |mauris   
Sed non  |finibus  
risus. Su|risus, co
spendisse|nsectetur
lectus   |laoreet  
tortor,  |sem enim 
dignissim|sed arcu.
sit amet,|Maecenas 
adipiscin|sit amet 
g nec,   |eleifend 
utilisez |sem.     
sed sin  |Nullam ac
dolor.   |libero   
         |metus.   
         |Praesent 
         |ac       
         |finibus  
         |nulla,   
         |vitae    
"""
