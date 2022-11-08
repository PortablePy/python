#!/usr/bin/env python
# coding: utf-8

# # 02_03: Dictionaries and Sets

# In[1]:


import math
import collections

import numpy as np
import pandas as pd
import matplotlib.pyplot as pp

get_ipython().run_line_magic('matplotlib', 'inline')


# In[2]:


capitals = {'United States': 'Washington, DC', 'France': 'Paris', 'Italy': 'Rome'}


# In[3]:


capitals


# In[4]:


capitals['Italy']


# In[5]:


capitals['Spain'] = 'Madrid'


# In[6]:


capitals


# In[7]:


capitals['Germany']


# In[8]:


'Germany' in capitals, 'Italy' in capitals


# In[9]:


morecapitals = {'Germany': 'Berlin', 'United Kingdom': 'London'}


# In[10]:


capitals + morecapitals


# In[11]:


capitals.update(morecapitals)


# In[12]:


capitals


# In[13]:


del capitals['United Kingdom']


# In[14]:


capitals


# In[15]:


birthdays = {(7,15): 'Michele', (3,14): 'Albert'}


# In[16]:


birthdays[(7,15)]


# In[17]:


hash('Italy')


# In[18]:


hash((7,15))


# In[19]:


{}


# In[20]:


len({})


# In[21]:


for country in capitals:
    print(country)


# In[22]:


for country in capitals.keys():
    print(country)


# In[23]:


capitals.keys()


# In[24]:


list(capitals.keys())


# In[25]:


for capital in capitals.values():
    print(capital)


# In[26]:


for country, capital in capitals.items():
    print(country, capital)


# In[27]:


continents = {'America', 'Europe', 'Asia', 'Oceania', 'Africa', 'Africa'}


# In[28]:


continents


# In[29]:


'Africa' in continents


# In[30]:


continents.add('Antarctica')


# In[31]:


continents.remove('Antarctica')


# In[32]:


for c in continents:
    print(c)


# In[ ]:




