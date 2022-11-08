"""Image size functions."""


def image_width(num_pixels=None):
    return num_pixels if (num_pixels is not None) else 1280


def image_height(num_pixels=None):
    return num_pixels or 720


def num_image_pixels(h=None, v=None):
    return image_width(h) * image_height(v)
