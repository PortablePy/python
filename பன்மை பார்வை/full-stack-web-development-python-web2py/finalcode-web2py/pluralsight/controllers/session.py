# -*- coding: utf-8 -*-
# try something like

def set():
    session.name="Sam";
    session.date="7/1/2015"
    session.membership="family"
    return locals()

def view():
    return locals()

def index(): return dict(message="hello from session.py")
