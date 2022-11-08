# -*- coding: utf-8 -*-
# try something like

def add():
    form = SQLFORM(db.contacts).process()
    return locals()

def view():
    if request.args(0) is None:
        rows = db(db.contacts).select(orderby=db.contacts.last_name | db.contacts.first_name)
    else:
        letter = request.args(0)
        rows = db(db.contacts.last_name.startswith(letter)).select(orderby=db.contacts.last_name | db.contacts.first_name)
    return locals()

def update():
    record = db.contacts(request.args(0)) or redirect(URL('view'))
    form = SQLFORM(db.contacts, record)
    if form.process().accepted:
        response.flash = T('Record Updated')
    else:
        response.flash = T('Please complete the form.')
    return locals()





def index(): return dict(message="hello from contacts.py")

def data():
    rows = db(db.contacts).select()
    return locals()

def filter():
    # get count
    rows1_count = db(db.contacts.state_name=='CA').count()
    # get all records, sorted by name
    rows2_all_sorted_by_name = db(db.contacts).select(orderby=~db.contacts.last_name | db.contacts.first_name)
    # filter, show only those whose last_name starts with M
    rows3_startswith = db(db.contacts.last_name.startswith('M')).select(orderby=db.contacts.state_name | db.contacts.last_name)
    # filter, show those in CA
    rows4_by_state = db(~(db.contacts.state_name=='CA')).select(orderby=db.contacts.last_name | db.contacts.first_name)
    # boolean logic:  & (and); | (or)
    rows5_combo = db((db.contacts.state_name=='CA') & (db.contacts.last_name.startswith('A'))).select(orderby=db.contacts.last_name)
    return locals()
