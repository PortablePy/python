#!/usr/bin/env python3
""" Solution: Sort an array of random integers with merge sort """

import random
import time
import multiprocessing as mp

""" sequential implementation of merge sort """
def seq_mergesort(array, *args):
    if not args: # first call
        seq_mergesort(array, 0, len(array)-1)
        return array # return the sorted array
    else: # recursive call
        left, right = args
        if (left < right):
            mid = (left + right) // 2 # find the middle point
            seq_mergesort(array, left, mid) # sort the left half
            seq_mergesort(array, mid+1, right) # sort the right half
            merge(array, left, mid, right) # merge the two sorted halves

""" helper method to merge two sorted subarrays
    array[l..m] and array[m+1..r] into array """
def merge(array, left, mid, right):
    # copy data to temp subarrays to be merged
    left_temp_arr = array[left:mid+1].copy()
    right_temp_arr = array[mid+1:right+1].copy()

    # initial indexes for left, right and merged subarrays
    left_temp_index = 0
    right_temp_index = 0
    merge_index = left

    # merge temp arrays into original
    while (left_temp_index < (mid - left + 1) or right_temp_index < (right - mid)):
        if (left_temp_index < (mid - left + 1) and right_temp_index < (right - mid)):
            if (left_temp_arr[left_temp_index] <= right_temp_arr[right_temp_index]):
                array[merge_index] = left_temp_arr[left_temp_index]
                left_temp_index += 1
            else:
                array[merge_index] = right_temp_arr[right_temp_index]
                right_temp_index += 1
        elif (left_temp_index < (mid - left + 1)): # copy any remaining on left side
            array[merge_index] = left_temp_arr[left_temp_index]
            left_temp_index += 1
        elif (right_temp_index < (right - mid)): # copy any remaining on right side
            array[merge_index] = right_temp_arr[right_temp_index]
            right_temp_index += 1
        merge_index += 1

""" parallel implementation of merge sort """
def par_mergesort(array, *args):
    pass
    """ ******************* """
    """ YOUR CODE GOES HERE """
    """ ******************* """

if __name__ == '__main__':
    NUM_EVAL_RUNS = 1
    print('Generating Random Array...')
    array = [random.randint(0,10_000) for i in range(100_000)]

    print('Evaluating Sequential Implementation...')
    sequential_result = seq_mergesort(array.copy())
    sequential_time = 0
    for i in range(NUM_EVAL_RUNS):
        start = time.perf_counter()
        seq_mergesort(array.copy())
        sequential_time += time.perf_counter() - start
    sequential_time /= NUM_EVAL_RUNS

    print('Evaluating Parallel Implementation...')
    parallel_result = par_mergesort(array.copy())
    parallel_time = 0
    for i in range(NUM_EVAL_RUNS):
        start = time.perf_counter()
        par_mergesort(array.copy())
        parallel_time += time.perf_counter() - start
    parallel_time /= NUM_EVAL_RUNS

    if sequential_result != parallel_result:
        raise Exception('sequential_result and parallel_result do not match.')
    print('Average Sequential Time: {:.2f} ms'.format(sequential_time*1000))
    print('Average Parallel Time: {:.2f} ms'.format(parallel_time*1000))
    print('Speedup: {:.2f}'.format(sequential_time/parallel_time))
    print('Efficiency: {:.2f}%'.format(100*(sequential_time/parallel_time)/mp.cpu_count()))
