m2-demo-01-RunningJupyterNotebooksWithTheAnacondaPythonDistributionHostedJupyterNotebooksInWindows
##Commands:- 
-- cd Projects\Pluralsight
-- jupyter notebook

m2-demo-02-RunningJupyterNotebooksByInstallingPipCommandJupyterNotebooksInWindows
##Commands:-
-- python --version
-- jupyter --version
-- pip install jupyter notebook
-- cls 
-- cd Projects\Pluralsight
-- jupyter notebook
-- ctrl c c   ## To shutdown jupyter notebook kernel


m2-demo-03-RunningJupyterNotebooksWithTheAnacondaPythonDistributionHostedJupyterNotebooksInMacOs
##Commands:-
-- cd Desktop/Pluralsight
-- python --version
-- jupyter --version
-- jupyter notebook
-- control c c # To shutdown jupyter notebook kernel
-- clear
-- pip install notebook==6.0.1
-- clear
-- jupyter notebook
-- control c c # To shutdown jupyter notebook kernel

m2-demo-04-RunningJupyterNotebooksByInstallingPipCommandJupyterNotebooksInMacOs
##Commands:-
-- bash ~/Downloads/Anaconda3-2019.07-MacOSX-x86_64.sh
## -- Press Enter and go down by pressing down arrow key to read t&c 
-- yes
-- yes
-- clear
-- cd Desktop/Pluralsight
-- python --version
-- jupyter --version
-- jupyter notebook
-- control c c # To shutdown jupyter notebook kernel
-- pip install notebook==6.0.1
-- jupyter notebook
-- control c c # To shutdown jupyter notebook kernel


m2-demo-05-RunningJupyterNotebooksInDockerContainers
##Commands:-
-- docker run -it --rm -p 8888:8888 -p 4040:4040 -v ~:/home/jovyan/workspace jupyter/all-spark-notebook
-- docker run --rm -p 8888:8888 -p 4040:4040 -e JUPYTER_ENABLE_LAB=yes -v ~:/home/jovyan/work jupyter/all-spark-notebook


m2-demo-06-JupyterLabUsingPip
##Commands:-
-- python
-- exit()
-- python3
-- brew install python3
-- python3
-- pip --version
-- exit()
-- pip --version
-- pip3 --version
-- python3 -m pip install --upgrade pip
-- jupyter --version
-- cd Desktop/Pluralsight
-- pip3 install notebook==6.0.1
-- jupyter notebook
-- control c c # To shutdown jupyter notebook kernel
-- cd ~
-- pip3 install jupyterlab
-- cd Desktop/Pluralsight
-- jupyter lab
-- control c c # To shutdown jupyter notebook kernel


m3-demo-03-TogglingBetweenPython2And3InJupyterNotebooksAsWellAsRLanguage
##Commands:-
-- conda create -n py27 python=2.7 anaconda  ## Creating enviroment for python2.x
-- y
-- cd Desktop/Pluralsight
-- conda activate py27
-- jupyter notebook
-- control c c # To shutdown jupyter notebook kernel
-- conda deactive
-- conda create -n r_env r-essentials r-base ## Creating enviroment for R
-- y 
-- cd Desktop/Pluralsight
-- conda activate r_env
-- jupyter notebook


m5-demo-01-OptionsForWorkingWithJupyterNotebooksOnAWS
##Commands:-
-- pwd
-- ls
-- cd SageMaker/
-- ls

m5-demo-03OptionsForWorkingWithJupyterNotebooksOnTheGoogleCloudPlatform
##Commands:-
-- pwd
-- ls

