#!/usr/bin/env python3


def main():
    f = open('lines.txt')
    for line in f:
        print(line.rstrip())

if __name__ == '__main__': main()
