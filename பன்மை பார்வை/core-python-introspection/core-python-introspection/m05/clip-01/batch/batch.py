from itertools import chain


class Batch:
    def __init__(self, iterables=()):
        self._iterables = list(iterables)

    def append(self, iterable):
        self._iterables.append(iterable)

    def __iter__(self):
        return chain(*self._iterables)

