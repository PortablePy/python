"""Sharing marketing loot."""

def share_stickers(num_stickers, num_developers):
    if num_developers == 0:
        return 0
    return num_stickers // num_developers
