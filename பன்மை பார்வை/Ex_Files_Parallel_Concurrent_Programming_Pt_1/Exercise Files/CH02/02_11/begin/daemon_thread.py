#!/usr/bin/env python3
""" Barron finishes cooking while Olivia cleans """

import threading
import time

def kitchen_cleaner():
    while True:
        print('Olivia cleaned the kitchen.')
        time.sleep(1)

if __name__ == '__main__':
    olivia = threading.Thread(target=kitchen_cleaner)
    olivia.start()

    print('Barron is cooking...')
    time.sleep(0.6)
    print('Barron is cooking...')
    time.sleep(0.6)
    print('Barron is cooking...')
    time.sleep(0.6)
    print('Barron is done!')
