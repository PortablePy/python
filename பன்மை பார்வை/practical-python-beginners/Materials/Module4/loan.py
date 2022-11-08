# Get the loan details
money_owed = float(input("How much money do you owe, in dollars?\n")) # $50,000
apr = float(input("What is the annual percentage rate of the loan?\n")) # 3%
payment = float(input("How much will you pay off each month in dollars?\n")) # $1,000
months = int(input("How many months do you want to see the results for?\n")) # 24

# Divide apr by 100 to make a percent, and 12 to make monthly
monthly_rate = apr/100/12

# Repeat payments exactly months number of times
for i in range(months):

    # Add in interest
    interest_paid = money_owed*monthly_rate
    money_owed = money_owed + interest_paid

    if (money_owed - payment < 0):
        print("The last payment is", money_owed)
        print("You paid off loan in", i+1, "months")
        break

    # Make payment
    money_owed = money_owed - payment

    # Print results after this month
    print("Paid",payment,"of which",interest_paid,"was interest", end=" ")
    print("Now I owe", money_owed)
