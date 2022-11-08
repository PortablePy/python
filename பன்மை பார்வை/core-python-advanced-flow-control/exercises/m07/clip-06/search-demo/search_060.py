from bisect import bisect_left

s = [5, 8, 19, 34, 35, 53]


def contains(sequence, value):
    index = bisect_left(sequence, value)
    return (index != len(sequence)) and (sequence[index] == value)
