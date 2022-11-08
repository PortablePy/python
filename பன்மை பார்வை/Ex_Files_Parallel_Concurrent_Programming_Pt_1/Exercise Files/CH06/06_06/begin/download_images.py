#!/usr/bin/env python3
""" Challenge: Download a collection of images """

import time
import urllib.request
import multiprocessing as mp
import concurrent.futures

""" sequential implementation of multiple image downloader
    returns total bytes from downloading all images in image_numbers list """
def seq_download_images(image_numbers):
    total_bytes = 0
    for num in image_numbers:
        total_bytes += _download_image(num)
    return total_bytes

""" helper function returns number of bytes from downloading image """
def _download_image(image_number):
    image_number = (abs(image_number) % 50) + 1 # force between 1 and 50
    image_url = 'http://699340.youcanlearnit.net/image{:03d}.jpg'.format(image_number)
    try:
        with urllib.request.urlopen(image_url, timeout=60) as conn:
            return len(conn.read()) # number of bytes in downloaded image
    except urllib.error.HTTPError:
        print('HTTPError: Could not retrieve image ', image_number)
    except Exception as e:
        print(e)

""" parallel implementation of multiple image downloader
    returns total bytes from downloading all images in image_numbers list """
def par_download_images(image_numbers):
    pass
    """ ******************* """
    """ YOUR CODE GOES HERE """
    """ ******************* """

if __name__ == '__main__':
    NUM_EVAL_RUNS = 1
    IMAGE_NUMBERS = list(range(1,200))

    print('Evaluating Sequential Implementation...')
    sequential_result = seq_download_images(IMAGE_NUMBERS)
    sequential_time = 0
    for i in range(NUM_EVAL_RUNS):
        start = time.perf_counter()
        seq_download_images(IMAGE_NUMBERS)
        sequential_time += time.perf_counter() - start
    sequential_time /= NUM_EVAL_RUNS

    print('Evaluating Parallel Implementation...')
    parallel_result = par_download_images(IMAGE_NUMBERS)
    parallel_time = 0
    for i in range(NUM_EVAL_RUNS):
        start = time.perf_counter()
        par_download_images(IMAGE_NUMBERS)
        parallel_time += time.perf_counter() - start
    parallel_time /= NUM_EVAL_RUNS

    if sequential_result != parallel_result:
        raise Exception('sequential_result and parallel_result do not match.')
    print('Average Sequential Time: {:.2f} ms'.format(sequential_time*1000))
    print('Average Parallel Time: {:.2f} ms'.format(parallel_time*1000))
    print('Speedup: {:.2f}'.format(sequential_time/parallel_time))
    print('Efficiency: {:.2f}%'.format(100*(sequential_time/parallel_time)/mp.cpu_count()))
