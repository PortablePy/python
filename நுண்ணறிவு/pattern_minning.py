from collections import Counter

def seq_mining(str_list, min_por, max_pat_len):
    out_dict= dict()
    for str_e in str_list:
        temp_d = dict()
        sub_len = min(max_pat_len, len(str_e))
        for l in range(1,sub_len+1):
            for i in range(len(str_e)):
                pat = str_e[i:i+l]
                if pat:
                    if not temp_d.get(pat,0):
                        temp_d[pat] = 1 
                        out_dict[pat] = out_dict.get(pat,0)+1
    size = len(str_list)
    result = {k:v for k, v in out_dict.items() if v/size>=min_por}
    return Counter(result)

print(seq_mining(['CFEDS', 'SKDJFGKSJDFG', 'OITOER'],0.24,6))
print(seq_mining(['ABCD', 'ABABC', 'BCAABCD'], 0.34, 1000000))


"""
So seq_mining(["ABC", "BCD"], 0.66, 2) (searching patterns of length 2 maximum, must appear on at lest 66% of sequences) should return:

Counter({'B': 2, 'C': 2, 'BC': 2})

(because as we have only two sequences, 66% already means the two of them)

while seq_mining(["ABC", "BCD"], 0.33, 2) (searching patterns of length 2 maximum, must appear on at lest 33% of sequences) should return:

Counter({'C': 2, 'B': 2, 'BC': 2, 'A': 1, 'D': 1, 'AB': 1, 'CD': 1})

 33% allows a pattern to be found in a single sequence
In [1]: from solution import seq_mining

In [2]: data = ['ABCD', 'ABABC', 'BCAABCD']

In [3]: seq_mining(data, 0.34, 3)
Out[3]:
Counter({'A': 3,
         'AB': 3,
         'ABC': 3,
         'B': 3,
         'BC': 3,
         'BCD': 2,
         'C': 3,
         'CD': 2,
         'D': 2})

In [4]: seq_mining(data, 0.34, 4)
Out[4]:
Counter({'A': 3,
         'AB': 3,
         'ABC': 3,
         'ABCD': 2,
         'B': 3,
         'BC': 3,
         'BCD': 2,
         'C': 3,
         'CD': 2,
         'D': 2})

In [5]: seq_mining(data, 0.50, 2)
Out[5]: Counter({'A': 3, 'AB': 3, 'B': 3, 'BC': 3, 'C': 3, 'CD': 2, 'D': 2})
"""