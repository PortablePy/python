from functools import singledispatch

from intersections import (
    rectangle_intersects_rectangle,
    rectangle_intersects_circle,
    rectangle_intersects_polygon,
    circle_intersects_circle,
    circle_intersects_polygon,
    polygon_intersects_polygon,
)


class Shape:

    def __init__(self, *, stroke_color=None, fill_color=None, stroke_width=None):
        self.stroke_color = stroke_color
        self.stroke_width = stroke_width
        self.fill_color = fill_color


class Rectangle(Shape):

    def __init__(self, p, width, height, **kwargs):
        super().__init__(**kwargs)
        self.p = p
        self.width = width
        self.height = height

    def intersects(self, shape):
        return intersects_with_rectangle(shape, self)


@singledispatch
def intersects_with_rectangle(shape, rectangle):
    raise TypeError(
        f"Can't intersect {type(shape).__name__} "
        f"with {type(rectangle).__name__}"
    )

@intersects_with_rectangle.register(Rectangle)
def _(shape, rectangle):
    return rectangle_intersects_rectangle(rectangle, shape)

@intersects_with_rectangle.register(Circle)
def _(shape, rectangle):
    return rectangle_intersects_circle(rectangle, shape)

@intersects_with_rectangle.register(Polygon)
def _(shape, rectangle):
    return rectangle_intersects_polygon(rectangle, shape)


class Circle(Shape):

    def __init__(self, center, radius, **kwargs):
        super().__init__(**kwargs)
        self.center = center
        self.radius = radius


class Polygon(Shape):

    def __init__(self, points, **kwargs):
        super().__init__(**kwargs)
        self.points = points


class Group:

    def __init__(self, shapes):
        self.shapes = shapes
