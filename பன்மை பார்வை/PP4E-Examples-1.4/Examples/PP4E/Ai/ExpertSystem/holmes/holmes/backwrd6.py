#
# module backwrd6.py
#
# backward chaining inference engine;
# 
# this is a variant of backwrd4.py, which uses 
# explicit 'remaining goal' stacks to route 
# forward execution (rather than passing on the
# Python call stack;  the 'generate and test'
# paradigm is clearer here;  again, no level 
# returns until it needs to backtrack;
#
# could be slightly faster if used '(x,y)' tree
# representation for the how/why and goals stack
# lists;
####################################################################




from match import *
from backwrd4 import report, ask_user, stop_proof
import backward; backwrd1 = backward



print_mode = ('terms', 'one')
negation   = 'negation'

positive = ['y','Y','yes','YES']
negative = ['n','N','no','NO']




def backward(rules, query, *pmode):
    global known, kbase                               # avoid an extra args
    backwrd1.kbase = rules
    known, kbase = [['true']], rules
    topenv = {}
    finish = (report, (topenv, query, pmode))
    try:
        TEST(pushgoals(query, topenv, [finish]), [], [])  
        print 'no (more) solutions  [backwrd6.py]'
    except stop_proof:
        return




def TEST(goals, why, how):                             # rule 'if' part
    if len(goals) == 1:                                # or top-level query 
        apply(goals[0][0], goals[0][1] + (how,))       # report() or fail()
 
    elif goals[0] == ():
        TEST(goals[1:], why[:len(why)-1], how + [()])
    
    else:
        (head, dict), tail = goals[0], goals[1:]
        if head[0] == 'ask': 
            head = head[1:]

        if head[0] == 'not':
            try:
                GEN(head[1:], dict, [(fail, ())], why, how)
            except negation: 
                return
            TEST(tail, why, how + [(head, 'not')])
        
        else:            
            GEN(head, dict, tail, why, how)
        



def GEN(goal, dict, goals, why, how):                           # match 'then'
    ask = 1
    for rule in kbase:                                          # select rule
        for then in rule['then']:                               # and descend
            dict2 = {}
            matched, changes = match(goal, then, dict, dict2)
            if matched:
                ask   = 0
                why2  = [(goal, dict, rule['rule'])] + why
                how2  = how + [(goal, (rule['rule'], dict2))]
                TEST(pushgoals(rule['if'], dict2, goals), why2, how2)
            for (var, env) in changes:
                env[var] = '?'    

    if ask and ask_user(goal, dict, known, why):
        TEST(goals, why, how + [(goal, 'told')])



 
def fail(how):  
    raise negation




def pushgoals(goals, dict, old):
    new = [()] + old
    for i in range(len(goals)-1,-1,-1):
        new = [(goals[i], dict)] + new
    return new




