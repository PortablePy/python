def sign(x):
    if x < 0:
        return -1
    elif x > 0:
        return 1
    return 0


def orientation(p, q, r, num_type=float):
    p = tuple(map(num_type, p))
    q = tuple(map(num_type, q))
    r = tuple(map(num_type, r))
    d = (q[0] - p[0]) * (r[1] - p[1]) - (q[1] - p[1]) * (r[0] - p[0])
    return sign(d)
