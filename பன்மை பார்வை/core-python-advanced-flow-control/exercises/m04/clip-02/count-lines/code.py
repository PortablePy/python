try:
    f = open(filename, "rt")
except OSError:
    print("File could not be opened for read")
else:
    # Now we're sure the file is open
    num_lines = sum(1 for line in f)
    print("Number of lines", num_lines)
    f.close()
