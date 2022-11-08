# -*- coding: utf-8 -*-
# try something like

def isPrime(num):
    counter = 2
    while counter < num-1:
        if num%counter==0:
            return False
        counter = counter + 1
    return True

def primeform():
    answer = False
    form = SQLFORM.factory(
        Field('enter_number', requires=IS_INT_IN_RANGE(10,10000))
        )
    if form.process().accepted:
        response.flash = 'form accepted'
        session.enter_number = form.vars.enter_number
        answer = isPrime(int(session.enter_number))
    elif form.errors:
        response.flash = 'form has errors'
    return locals()

def form():
    form = SQLFORM.factory(
        Field('your_name', requires=IS_NOT_EMPTY()),
        Field('join_date', type='date', requires=IS_DATE() ),
        Field('membership', requires=IS_IN_SET(['individual','company','family']) )
        )
    if form.process().accepted:
        response.flash = 'form accepted'
        session.your_name = form.vars.your_name
        session.join_date = form.vars.join_date
        session.membership = form.vars.membership
        redirect(URL("formaccepted"))
    elif form.errors:
        response.flash = 'form has errors'
    return locals()

def formaccepted():
    return locals()

def index(): return dict(message="hello from factory.py")
