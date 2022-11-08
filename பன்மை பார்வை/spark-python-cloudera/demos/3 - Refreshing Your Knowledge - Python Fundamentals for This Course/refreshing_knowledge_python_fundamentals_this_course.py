# Note: not meant to be executed as an application, this file has .py extension for display in a code editor
# *** m3 Refreshing Your Knowledge: Python Fundamentals for This Course ***
# In this module you will refresh some of the basic Python fundamentals required to work with Spark

# *****************************************************************************************************
# *****************************************************************************************************
# *** The Python Shell: REPL
python --version

cat test.py
def tell_running():
    print "I am a running application in Python"
if __name__ == "__main__":
    tell_running()

# Running a code file from terminal
python test.py

# Firing up the REPL
python

# Defining a function
def tell_running():
    print "I am running from the REPL"

# Invoking the function
tell_running()
tell_running()

def tell_running():
    print "I am running from the REPL redeclared"
	
tell_running()

# The Zen of Python
import this


# *****************************************************************************************************
# *****************************************************************************************************
# *** Syntax, Variables, (Dynamic) Types, and Operators

message = "This is a physical line"
message = "These are two
message = "This is a logical \
line"
message


# This is a single line comment

# This is not a good \
comment

""" This is a 
multiline comment
"""

valid = "This is a variable"
type(valid)
1nvalid = "Not valid"
b88l = True
b88l
sp#$% = 5
message
Message

message = "This is a variable"
message
type(message)
message = 42
message
type(message)

message = "Use double quotes"
message
message = 'Use single quotes'
message
message = "But do not mix'
message
message = "Unless it's for combining quotes"
message
message = 'It\s ok to escape as well'
message
message = 'Learn escape chars \nThey are useful'
message
print message
message[0]

True
False
one_var = "One"
"One" == one_var
"one" == one_var
"Onenot" == one_var

10 * 100 * 1000 == 1000 * 100 * 10
10 - 100 - 1000 == 1000 - 100 - 10

a_list = []
len(a_list)
len(a_list) == False
True == 1
True == 0
True == -1

message = "a string"
message
print message

print "This is %s" % message
message2 = "another string"
print "One %s, two %s" % (message, message2)

print "%d" % 3.14159
print "%f" % 3.14159

result = "Pi-ish " + 'plus ten is...'
print result
pi_ish_plus_ten = 3.14159 + 10
print pi_ish_plus_ten 

print result + pi_ish_plus_ten 
print result + str(pi_ish_plus_ten)

10 + 100 + 1000
(10 + 100) + 1000
10 + (100 + 1000)

10 * 1000 * 1000
1000 * 10 * 100
100 * 1000 * 10

10 - 100 - 1000
(10 - 100) - 1000
10 - (100 - 1000)


# *****************************************************************************************************
# *****************************************************************************************************
# *** Compound Variables: Lists, Tuples, and Dictionaries

numbers = [1, 2, 3]
type(list)
numbers

other_list = ['xavier', 1, True]
other_list[0]
other_list[0] = 'Xavier Morera'
other_list

numbers + 4
numbers + [4]
numbers + other_list

numbers = [1, 2, 3]
numbers.append([4, 5])
numbers

numbers = [1, 2, 3]
numbers.extend([4, 5])
numbers

numbers[2:4]
numbers[:2]


number_five = 5
id(number_five)
hex(id(number_five))
number_five += 1
id(number_five)
hex(id(number_five))

number_list = [1, 2]
id(number_list)
number_list.append(3)
id(number_list)

qa_people = {'xavier': 1}
type(qa_people)
qa_people

qa_people = {'xavier': 1, 'xavier':2}
qa_people['xavier']

qa_people
qa_people['xavier'] = 10
qa_people['irene'] = 100
qa_people.items()

one_tuple = ('xavier', 1)
one_tuple[0]
bigger_tuple = (1, 'xavier', 'morera')

{1, 2, 2, 3, 3}


# *****************************************************************************************************
# *****************************************************************************************************
# *** Code Blocks, Functions, Loops, Generators and Flow Control

def tell_running(count, user):
    print user + "is running a Python program"
    return count + 1
tell_running(2, 'Xavier')

tell_running
x = tell_running
x(3, 'Irene')


def execute_if(my_function, count, user):
    my_function (count, user)
    
execute_if(tell_running, 3, 'Xavier')
 
 
sys
import sys
sys
sys.copyright
print sys.copyright


def tell_running(count, user):
    print user + "is running a Python program"
    return count + 1

def tell_running(count, user):
    print user + "is running a Python program"
        return count + 1

def tell_running(count, user):
    if count == 1:
	    print user + "is running a Python program"
    return count + 1
tell_running(1, 'Xavier')	
tell_running(2, 'Xavier')	


def tell_running(count, user):
    print user + "is running a Python program"
    return count + 1
	
	 	
def tell_running(count, user):
    if count == 1:
        print user + " is in the True part of the if"
    elif count == 2:
        print user + ' is in the elif'
    else:
        print user + " is in the False part of the if"

tell_running(1, 'Xavier')	
tell_running(2, 'Xavier')
tell_running(3, 'Xavier')


names = ['Xavier', 'Irene', 'Juli', 'Luci']
for n in names:
    print n

	
i = 0
executing = True
while executing:
    i = i + 1
    print i
    if i == 5:
        executing = False


# *****************************************************************************************************
# *****************************************************************************************************
# *** Map, Filter, Group and Reduce

map(add_one, numbers_list)
filter(is_even, numbers_list)
reduce(add_items, numbers_list


def add_one(this_item):
    return this_item + 1
numbers_list = [1, 2, 3, 4, 5]
map(add_one, numbers_list)

def is_even(this_item):
    return this_item % 2 == 0
numbers_list
filter(is_even, numbers_list)

def add_items(first, second):
    return first + second
numbers_list
reduce(add_items, numbers_list)


# *****************************************************************************************************
# *****************************************************************************************************
# *** Enter PySpark: Spark in the REPL

python
globals()
spark
exit()

pyspark2
globals
spark
sc
exit()