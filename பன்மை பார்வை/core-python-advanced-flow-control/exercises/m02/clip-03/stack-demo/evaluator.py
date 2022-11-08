def is_comment(item):
    return isinstance(item, str) and item.startswith("#")


def execute(program):
    # TODO: Evaluate program
    print("Finished")


if __name__ == "__main__":
    import operator

    program = list(reversed((
        "# A short stack program to add and",
        "# and multiply some constants",
        5,
        2,
        operator.add,
        3,
        operator.mul,
    )))

    execute(program)
