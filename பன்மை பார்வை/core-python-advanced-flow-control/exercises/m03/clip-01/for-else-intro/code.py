for item in iterable:
    if match(item):
        result = item
        break
else:  # nobreak
    # No match found
    result = None

# Always come here
print(result)
