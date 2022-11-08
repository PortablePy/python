"""Sharing marketing loot."""

def share_stickers(num_stickers, num_developers):
    try:
        return num_stickers // num_developers
    except ZeroDivisionError:
        return 0
