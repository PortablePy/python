import numpy as np
import pandas as pd


data = pd.read_csv('Advertising.csv')

print("First 5 sample:\n", data.head())

print("Shape of dataset:\n", data.shape)

print("Basic statistical details:\n", data.describe())

print(data.describe().sum())

print("Null values in the dataset:\n", data.isnull().head())

print(data.isnull().sum())

print("Datatypes:\n", data.dtypes)
