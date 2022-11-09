DEMO 1

# installing python using conda

conda install -c anaconda python

#checking installation 
python --version

jupyter notebook

#installing jupyter
pip install jupyter

jupyter notebook

# toggling between python 2 and 3

# configure python 2.7
conda create -n py27 python=2.7

# activate the env
conda activate py27

# install ipykernel
conda install notebook ipykernel
ipython kernel install --user

# open jupyter notebook
jupyter notebook

# simple comands in pyhton 2

raw_input('Enter your name: \n')

cmp(1,0)

for x in xrange(1,5):
	print(x)
