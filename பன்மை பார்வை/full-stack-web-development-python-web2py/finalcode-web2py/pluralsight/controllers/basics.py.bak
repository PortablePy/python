# -*- coding: utf-8 -*-
# try something like
import random
def isPrime(num):
    counter = 2
    while counter < num-1:
        if num%counter==0:
            return False
        counter = counter + 1
    return True

def random_number():
    x = random.randint(3,20)
    result = isPrime(x)
    return locals()

def request_vars():
    num1 = 0
    num2 = 0
    total = 0
    if request.post_vars:
        num1 = float(request.post_vars.num1)
        num2 = float(request.post_vars.num2)
        total = num1 + num2
        response.flash = T("The total is " + str(total))
    return locals()

def request_args():
    arg1 = float(request.args(0))
    arg2 = float(request.args(1))
    total = arg1 + arg2
    return locals()

def request_object():
    app = request.application
    cntr = request.controller
    fx = request.function
    ext = request.extension
    folder = request.folder
    now = request.now
    client = request.client
    isSecure = request.is_https
    return locals()

def add2():
    arg1 = float(request.args(0))
    arg2 = float(request.args(1))
    total = arg1 + arg2
    return locals()

def helloworld():
    msg = "Hello from the Controller!"
    return locals()

def index(): 
    return dict(message="hello from basics.py")
