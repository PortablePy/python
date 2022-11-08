"""Image size functions."""


def image_width(num_pixels=None):
    return num_pixels if (num_pixels is not None) else 1280


def image_height(num_pixels=None):
    if num_pixels is None:
        num_pixels = 720
    return num_pixels


def num_image_pixels(h=None, v=None):
    return image_width(h) * image_height(v)
