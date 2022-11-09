import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

price_data = pd.read_csv('~/Desktop/price.csv')

print(price_data.head())

price_data = price_data.fillna(0)

print(price_data.head())

def get_price_info():
    for index, row in price_data.iterrows():
        try:
        	price = row['Total_Price']
        	quantity = row['Quantity']
            price_of_a_unit = (price/quantity)
            
            print(price_of_a_unit)
        except ZeroDivisionError :
            continue


get_price_info()


plt.bar(price_data.Things, height=price_data.Total_Price)
plt.title('Barplot of Things vs Total_Price')
plt.show()
