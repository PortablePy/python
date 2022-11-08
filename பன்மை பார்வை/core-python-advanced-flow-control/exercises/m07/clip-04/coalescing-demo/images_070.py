"""Image size functions."""

def image_width(num_pixels=1280):
    return num_pixels


def image_height(num_pixels=720):
    return num_pixels


def num_image_pixels(h=1280, v=720):
    return image_width(h) * image_height(v)
