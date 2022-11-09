#!/usr/bin/env python
# coding: utf-8

# In[1]:


import sys

import pandas as pd
import numpy as np

from sklearn.model_selection import train_test_split

from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier

from sklearn.metrics import classification_report


# In[2]:


def build_model(classifier_fn,                
                features, 
                label, 
                dataset, 
                test_frac=0.2):
    
    X = dataset[features]
    Y = dataset[label]
    
    x_train, x_test, y_train, y_test = train_test_split(X, Y, test_size=test_frac)
       
    model = classifier_fn(x_train, y_train)
    
    y_pred = model.predict(x_test)
    
    print("Features used: ", features)
    summarize_classification(y_test, y_pred)
    
    return {'model':model, 
            'x_train': x_train, 
            'y_train': y_train, 
            'x_test': x_test, 
            'y_test': y_test, 
            'y_pred': y_pred}


# In[3]:


def summarize_classification(y_test, y_pred):

    report = classification_report(y_test, y_pred)

    print('Classification report')
    print("------" * 10)
    print(report)


# In[11]:


def logistic_fn(x_train, y_train, penalty='l2', C=1.0, max_iter=1000):
    
    model = LogisticRegression(penalty=penalty, C=C,
                               max_iter=max_iter , solver='lbfgs')
    
    model.fit(x_train, y_train)
    
    return model


# In[5]:


def decision_tree_fn(x_train, y_train, max_depth=3): 
    
    model = DecisionTreeClassifier(max_depth=max_depth)
    model.fit(x_train, y_train)
    
    return model


# In[6]:


def main():

    data = pd.read_csv('./datasets/advertising_cleaned.csv')
    features = ['TimeSpent', 'Age',
                'AreaIncome','DailyInternetUsage', 
                'Male']

    try:
        model_type = sys.argv[1]
        
        if len(sys.argv) > 2:
            features = sys.argv[2:]
        
    except error:
        print("Classifier model not specified!") 
        
        
    print("Running classifier: ", model_type)

    if model_type == "logistic_regression":
        build_model(logistic_fn,
                    features,
                    'Clicked',
                    data)
    elif model_type == "decision_tree":
        build_model(decision_tree_fn,
                    features,
                    'Clicked',
                    data)
    else:
        print("Invalid classifier model")   


# In[7]:


if __name__ == "__main__":
    main()
    
