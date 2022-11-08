def is_comment(item):
    return isinstance(item, str) and item.startswith("#")


def execute(program):
    # Find the real start of the program by skipping
    # any leading comments
    while program:
        item = program.pop()
        if not is_comment(item):
            program.append(item)
            break
    else:  # nobreak
        print("Empty program!")
        return

    # Evaluate the program
    pending = []

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
