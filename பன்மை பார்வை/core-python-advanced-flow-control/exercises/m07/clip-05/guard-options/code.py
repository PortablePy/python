def share_stickers(num_stickers, num_developers):
    if num_developers == 0:
        return 0
    return num_stickers // num_developers


def share_stickers(num_stickers, num_developers):
    try:
        return num_stickers // num_developers
    except ZeroDivisionError:
        return 0


def share_stickers(num_stickers, num_developers):
    return num_developers and num_stickers // num_developers
