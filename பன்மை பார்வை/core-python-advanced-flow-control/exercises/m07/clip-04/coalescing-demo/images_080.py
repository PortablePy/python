"""Image size functions."""

DEFAULT_WIDTH = 1280
DEFAULT_HEIGHT = 720


def image_width(num_pixels=DEFAULT_WIDTH):
    return num_pixels


def image_height(num_pixels=DEFAULT_HEIGHT):
    return num_pixels


def num_image_pixels(h=DEFAULT_WIDTH, v=DEFAULT_HEIGHT):
    return image_width(h) * image_height(v)
