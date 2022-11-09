DEMO-01

#Download homebrew
#Checking the installation
which brew

#install python in Mac
brew install python3

#checking python version
python --version



# Interacting with python
python
print("Hello World")
(1+3)*2

#install python in Mac
brew install wget

#checking python version
wget --version


#install pip3 with help of wget and python
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py


#checking intallation
pip3



# Using pip for installation
# checking pip version
pip --version

python -m pip install SomePackage

#install a specific version of package
python -m pip install SomePackage==1.0.4    # specific version
python -m pip install "SomePackage>=1.0.4"  # minimum version

#examples
pip install numpy
pip install scipy

# numpy operations
python

#operations on 1-D array

import numpy as np

array_1 = np.array([5,10,15,20,25])
array_2 = np.arange(5)
array_2

array_3 = array_1 + array_2
array_3

array_power = np.power(array_1, 2)
array_power

conditional_check = array_1 >= 20
conditional_check


#operations on 2-D array

a = np.array([[2,6],[3,9]])
b = np.array([[6,7],[4,0]])

print(a)
print(b)

#matrix multiplication
print(a@b)

#using random

rand_num = np.random.random((2,2))
rand_num

#using min
rand_num.min()

#Setting up an environment
#intsall virtualenv

pip install virtualenv

#create an environment with python3
virtualenv env -p python3

#Activate the environment
. venv/bin/activate

#Coding and running python
#Create a python file in the Desktop
cd Desktop
touch file.py

#Writing code in the file from terminal
nano file.py

#file.py
print("Welcome to Loonycorn")

#run the file
python file.py

#SUBLIME TEXT

# file: code.py

# running the file
cd Desktop/
python code.py


# VIM

#install vim
brew install vim

#opening existing file
cd Desktop
vim file.py

#run the file 
! clear; python %
:q

#edit the file
vim file.py
:i
print("This is a new line")

#save and exit
:w
:q

#run the file 
vim file.py
! clear; python %


#REPL.IT

#code in main.py
x = 1.5
y = 7.2
sum = float(x) + float(y)
print(sum)

#interacting with repl.it
a = int(input("Enter a number: "))
square = a**2
print("The square of",a,"is",square)

# upload the dataset
# create requirements.txt
# inside the req.txt , type numpy, pandas
# upload the file code.py
# run the file