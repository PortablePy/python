import numpy as np
import pandas as pd

data = pd.read_csv('Advertising.csv')

print("First 5 samples:")
print("-" * 100)
print(data.head())

print("Shape of the dataset:", data.shape)
print("-" * 100)
print(data.shape)

print("Statistical summary:")
print("-" * 100)
print(data.describe())


print("Null values in the dataset:")
print("-" * 100)
print(data.isnull().sum())


print("Datatypes:")
print("-" * 100)
print(data.dtypes)
