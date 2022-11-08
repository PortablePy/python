def ensure_has_divisible(items, divisor):
    for item in items:
        if item % divisor == 0:
            found = item
            break
    else:  # nobreak
        items.append(divisor)
        found = divisor


items = [2, 25, 9]
divisor = 12

print(f"{items} contains {found} which is a multiple of {divisor}")
