#!/usr/bin/env python3
""" Solution: Multiply two matrices """

import random
import time
import math
import multiprocessing as mp

""" sequential implementation of matrix multiplication """
def seq_matrix_multiply(A, B):
    # establish a few useful variables
    num_rows_A = len(A)
    num_cols_A = len(A[0])
    num_rows_B = len(B)
    num_cols_B = len(B[0])
    if num_cols_A != num_rows_B:
        raise ArithmeticError('Invalid dimensions; Cannot multiply {}x{}*{}x{}'.format(num_rows_A, num_cols_A, num_rows_B, num_cols_B))
    # compute a return matrix product C = A*B
    C = [[0] * num_cols_B for i in range(num_rows_A)]
    for i in range(num_rows_A):
        for j in range(num_cols_B):
            for k in range(num_cols_A): # same as num_rows_B
                C[i][j] += A[i][k] * B[k][j]
    return C

""" parallel implementation of matrix multiplication """
def par_matrix_multiply(A, B):
    # establish a few useful variables
    num_rows_A = len(A)
    num_cols_A = len(A[0])
    num_rows_B = len(B)
    num_cols_B = len(B[0])
    if num_cols_A != num_rows_B:
        raise ArithmeticError('Invalid dimensions; Cannot multiply {}x{}*{}x{}'.format(num_rows_A, num_cols_A, num_rows_B, num_cols_B))

    # if the output C will be small enough, simply use the sequential version
    if num_rows_A * num_cols_B < 25_000:
        return seq_matrix_multiply(A, B)

    # create workers to calculate results for subset of rows in C
    num_workers = mp.cpu_count()
    chunk_size = math.ceil(num_rows_A/num_workers)
    C_1D = mp.RawArray('d', num_rows_A * num_cols_B) # flat version of matrix C
    workers = []
    for w in range(num_workers):
        row_start_C = min(w * chunk_size, num_rows_A)
        row_end_C = min((w + 1) * chunk_size, num_rows_A)
        workers.append(mp.Process(target=_par_worker,
                                  args=(A, B, C_1D, row_start_C, row_end_C)))
    for w in workers:
        w.start()
    for w in workers:
        w.join()

    # convert flat C_1D into 2D list-of-lists
    C_2D = [[0] * num_cols_B for i in range(num_rows_A)]
    for i in range(num_rows_A):
        for j in range(num_cols_B):
            C_2D[i][j] = C_1D[i*num_cols_B + j]
    return C_2D

""" parallel worker to calculate results for subset of rows in C """
def _par_worker(A, B, C_1D, row_start_C, row_end_C):
    for i in range(row_start_C, row_end_C): # subset of rows in A
        for j in range(len(B[0])): # num_cols_B
            for k in range(len(A[0])): # num_cols_A, also num_rows_B
                C_1D[i*len(B[0]) + j] += A[i][k] * B[k][j]

if __name__ == '__main__':
    NUM_EVAL_RUNS = 10
    A = [[random.random() for i in range(1000)] for j in range(1000)]
    B = [[random.random() for i in range(1000)] for j in range(1000)]

    print('Evaluating Sequential Implementation...')
    sequential_result = seq_matrix_multiply(A, B) # "warm up"
    sequential_time = 0
    for i in range(NUM_EVAL_RUNS):
        start = time.perf_counter()
        seq_matrix_multiply(A, B)
        sequential_time += time.perf_counter() - start
    sequential_time /= NUM_EVAL_RUNS

    print('Evaluating Parallel Implementation...')
    parallel_result = par_matrix_multiply(A, B)  # "warm up"
    parallel_time = 0
    for i in range(NUM_EVAL_RUNS):
        start = time.perf_counter()
        par_matrix_multiply(A, B)
        parallel_time += time.perf_counter() - start
    parallel_time /= NUM_EVAL_RUNS

    if sequential_result != parallel_result:
        raise Exception('sequential_result and parallel_result do not match.')
    print('Average Sequential Time: {:.2f} ms'.format(sequential_time*1000))
    print('Average Parallel Time: {:.2f} ms'.format(parallel_time*1000))
    print('Speedup: {:.2f}'.format(sequential_time/parallel_time))
    print('Efficiency: {:.2f}%'.format(100*(sequential_time/parallel_time)/mp.cpu_count()))
