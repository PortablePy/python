#!/usr/bin/env python3


def main():
    seq = range(11)
    print_list(seq)

def print_list(o):
    for x in o: print(x, end = ' ')
    print()

if __name__ == '__main__': main()
