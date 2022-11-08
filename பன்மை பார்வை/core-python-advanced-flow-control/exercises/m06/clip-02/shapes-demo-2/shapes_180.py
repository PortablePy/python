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


class Circle(Shape):

    def __init__(self, center, radius, **kwargs):
        super().__init__(**kwargs)
        self.center = center
        self.radius = radius

    def intersects(self, shape):
        return intersects_with_circle(shape, self)


class Polygon(Shape):

    def __init__(self, points, **kwargs):
        super().__init__(**kwargs)
        self.points = points

    def intersects(self, shape):
        return intersects_with_polygon(shape, self)


class Group:

    def __init__(self, shapes):
        self.shapes = shapes


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


@singledispatch
def intersects_with_circle(shape, circle):
    raise TypeError(
        f"Can't intersect {type(shape).__name__} "
        f"with {type(circle).__name__}"
    )


@intersects_with_circle.register(Rectangle)
def _(shape, circle):
    return rectangle_intersects_circle(shape, circle)


@intersects_with_circle.register(Circle)
def _(shape, circle):
    return circle_intersects_circle(circle, shape)


@intersects_with_circle.register(Polygon)
def _(shape, circle):
    return circle_intersects_polygon(circle, shape)


@singledispatch
def intersects_with_polygon(shape, polygon):
    raise TypeError(
        f"Can't intersect {type(shape).__name__} "
        f"with {type(polygon).__name__}"
    )


@intersects_with_polygon.register(Rectangle)
def _(shape, polygon):
    return rectangle_intersects_polygon(shape, polygon)


@intersects_with_polygon.register(Circle)
def _(shape, polygon):
    return circle_intersects_polygon(shape, polygon)


@intersects_with_polygon.register(Polygon)
def _(shape, polygon):
    return polygon_intersects_polygon(polygon, shape)
