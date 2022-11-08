#
# module forward.py
#
# forward chaining inference engine
# see holmes/forward.py and holmes.doc for more info;
#
# optimization: uses known fact and rule 'if' indexes to avoid: 
# a) exhaustive fact list search when matching an 'if'
# b) exhaustive fact list scan when seeing if fact redundant 
# c) exhaustive fact list scan when seeing if should ask user
# d) reselecting and refiring rule/binding on each iteration
#
# only tries rules suggested (triggered) by facts added
# during the last iteration (restarts from top again);
#
# could be made slightly faster by using '(x,y)' tree rep
# for lists (proof list, etc.), but the gain would be minor
# compared to the index tree improvement;
#
# known fact list is now an index tree (members() generates
# the old list, but it is no longer in deduction-order);
###########################################################################




from match import *
from index import Index
from kbase import external, internal
from time import time

stop_chaining = 'stop_chaining'




def forward(rules, facts, *pmode):
    time1 = time()
    global kbase                                # avoid extra args
    kbase = rules
    known = initialize(facts, kbase)

    try:
        chain(facts+[['true']], known, kbase)   # adds to 'known'
    except stop_chaining: pass                  # user can stop it
    return report(known, pmode, time1)
    




def chain(newfacts, known, kbase):
    global user_answers                         # avoid extra args
    while 1:
        user_answers = 0
        
        rules = triggered(newfacts, kbase)      # if part in new
        if not rules: 
            break
        
        solns = bindings(rules, known)          # all 'if's matched
        if not solns and not user_answers:
            break                             
        
        newfacts = fire(solns, known)           # add 'then' to known
        if not newfacts and not user_answers:
            break                               # no new facts added, or
                                                # ask_user added no facts




#######################################################
# create fact index and init iteration counts;
# store_unique would remove redundant initial facts;
#######################################################




def initialize(facts, kbase):
    known = Index().init()
    for fact in facts:
        known.store(fact, (fact, 'initial'))          # fact, proof
    known.store(['true'], (['true'], 'atomic'))       # if true then...

    for rule in kbase.rules:
        rule['trigger'] = 0 
    return known





#################################################
# add 'then' parts of matched rules/bindings
# store_unique() might speed finding duplicates;
#################################################




def fire(solns, known):
    added = []
    for (rule, dict, proof) in solns:
        for then in rule['then']:
            fact = substitute(then, dict)
            if fact[0] == 'delete': 
                if known.search_unique(fact[1:]):                
                    known.delete(fact[1:])
                    added.append(['not'] + fact)
            else:
                if not known.search_unique(fact):
                    known.store(fact, (fact, (rule['rule'], proof)) )
                    added.append(fact)
    return added





#############################################
# pick rules with matched 'if' parts;
# returns list with no redundant rules;
#############################################




trigger_id = 1


def triggered(newfacts, kbase):
    global trigger_id
    res = []
    for fact in newfacts:
        for rule in kbase.match_if(fact):
            if rule['trigger'] != trigger_id:
                res.append(rule)
                rule['trigger'] = trigger_id
    trigger_id = trigger_id + 1
    return res





#####################################################
# generate bindings for rule's 'if' conjunction,
# for all rules triggered by latest deductions; 
# note: 'not' goals must match explicitly asserted
# 'not' facts: we just match the whole 'not';
#####################################################




def bindings(triggered, known):
    solns = []
    for rule in triggered:
        for (dict, proof) in conjunct(rule['if'], known, {}, rule['rule']):
            solns.append((rule, dict, proof))
    return solns





def conjunct(ifs, known, dict, why):
    if ifs == []:
        return [(copy_dict(dict), [])]   
    
    res = []
    head, tail = ifs[0], ifs[1:]
    if head[0] == 'ask':
        term = substitute(head[1:], dict)
        if ask_user(term, known, why):
            for (dict2, proof2) in conjunct(tail, known, dict, why):
                res.append((dict2, [(term, 'told')] + proof2))

    else:
        for (fact, proof) in known.search(head, dict): 
            matched, changes = match(head, fact, dict, {})
            if matched:
                for (dict2, proof2) in conjunct(tail, known, dict, why):
                    res.append((dict2, [(fact, proof)] + proof2))
            for (var, env) in changes:
                env[var] = '?'                        
    return res





########################################################
# assorted stuff; dictionary copies should be built-in,
# since dictionary assignment 'shares' the same object; 
########################################################




def copy_dict(dict):
    res = {}
    for f in dict.keys(): res[f] = dict[f]
    return res





##########################################################
# the 'why' explanation in forward chaining just lists
# the rule containing the asked goal;
##########################################################




def ask_user(fact, known, why):
    global user_answers
    if known.search_unique(fact):
        return 1
    elif known.search_unique(['not'] + fact):
        return 0

    user_answers = 1
    while 1:
        ans = raw_input('is this true: ' + external([fact]) + ' ?') 
        if ans in ['y','Y','yes','YES']:
            known.store(fact, (fact, 'told'))
            return 1
        elif ans in ['n','N','no','NO']:
            known.store(['not']+fact, (['not']+fact, 'told'))
            return 0
        elif ans == 'why':
            print 'to see if rule', why, 'can be applied'
        elif ans == 'where':
            print_solns(known, None)
        elif ans == 'browse':
            kbase.browse_pattern(raw_input('enter browse pattern: '))
        elif ans == 'stop':
            raise stop_chaining
        else:
            print 'what? ',
            print '(expecting "y", "n", "why", "where", "browse", or "stop")'





######################################################
# 'how' explanations require us to construct proof 
# trees for each fact added to the known facts list; 
######################################################




def report(known, pmode, time1):
    filter = None
    if pmode:
        if pmode[0] == None:
            return known
        else:
            filter = pmode[0]
    time2 = time() - time1
    print_solns(known, filter)
    print 'time: ', time2
    show_proofs(known)





def print_solns(known, filter):
    sources = {'rule':[], 'told':[], 'init':[], 'atom':[]}

    for (fact, proof) in known.members():
        if not filter or match(filter, fact, {}, {})[0]:
            if type(proof) == type(()):
                sources['rule'].append((fact, proof))         # deduced
            elif proof == 'told' or proof == 'not':
                sources['told'].append(fact)        
            elif proof == 'initial':
                sources['init'].append(fact)        
            elif proof == 'atomic':
                sources['atom'].append(fact)
    
    if not sources['rule']:
        print 'I have not deduced any new facts.'
    else:
        print 'I deduced these facts...'
        for (fact, proof) in sources['rule']:
            print '  ', external([fact])              #, '(by rule',proof[0]+')'

    if sources['told']:
        print 'You told me these facts...'
        for fact in sources['told']: 
            print '  ', external([fact])

    if sources['init']:
        print 'I started with these facts...'
        for fact in sources['init']: 
            print '  ', external([fact])

    # ignore sources['atom']
   


                                                  

def show_proofs(known):
    while 1:
        print
        ans = raw_input('show proofs? ')

        if ans in ['y','Y','yes','YES']:
            [patt] = internal(raw_input('enter deductions pattern: '))
            for (fact, proof) in known.members():
                if match(patt, fact, {}, {})[0]:
                    trace_tree((fact, proof), 0)

        elif ans in ['n','N','no','NO']:
            break
        elif ans == 'where':
            print_solns(known, None)
        elif ans == 'browse':
            kbase.browse_pattern(raw_input('enter browse pattern: '))
        else:
            print 'what?  (expecting "y", "n", "where", or "browse")'





def trace_tree((fact, proof), level):
    print ' ' * level,
    print '"' + external([fact]) + '"', 
    if proof == 'told':
        print 'was your answer'
    elif proof == 'initial':
        print 'was on your initial facts list'
    elif proof == 'atomic':
        print 'is an absolute truth'
    elif proof == 'not':
        print 'was a negative answer, or was ommitted'
    else:
        rule, subproof = proof
        print 'was deduced by firing rule', rule
        for branch in subproof:
            trace_tree(branch, level+3)

