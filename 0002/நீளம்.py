# Calculating Length

# len() --> returns length
def அச்சிடு(*arg):
    print(*arg)

def நீளம்(*arg):
    return len(*arg)

firstName = "Taylor"
அச்சிடு(நீளம்(firstName))
lastName = "Swift"
அச்சிடு(நீளம்(lastName))
firstName.__len__()

ages = [0, 11, 43, 12, 10]
அச்சிடு(நீளம்(ages))
அச்சிடு(ages)

i = 0
for i in range(0, len(ages)):
    அச்சிடு(ages[i])

அச்சிடு(நீளம்(["bob", "mary", "sam"]))

candyCollection = {"bob" : 10, "mary" : 7, "sam" : 18}
அச்சிடு(நீளம்(candyCollection))

அச்சிடு(candyCollection)
