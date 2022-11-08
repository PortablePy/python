# Calculating Length

# len() --> returns length

firstName = "Taylor"
print(len(firstName))
lastName = "Swift"
print(len(lastName))
firstName.__len__()

ages = [0, 11, 43, 12, 10]
print(len(ages))
i = 0
for i in range(0, len(ages)):
    print(ages[i])

print(len(["bob", "mary", "sam"]))

candyCollection = {"bob" : 10, "mary" : 7, "sam" : 18}
print(len(candyCollection))