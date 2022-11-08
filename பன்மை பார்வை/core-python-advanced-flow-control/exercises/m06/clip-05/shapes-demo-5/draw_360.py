from functools import singledispatch

from shapes import Polygon, Rectangle, Group, Circle


def attrs(shape):
    return ' '.join(
        f'{key}="{value}"' for key, value in
        {
            "stroke": shape.stroke_color,
            "stroke-width": shape.stroke_width,
            "fill": shape.fill_color
        }.items()
        if value is not None
    )


@singledispatch
def draw(shape):
    """Draw a generic shape."""
    raise TypeError(f"Can't draw shape {shape!r}")


@draw.register(Rectangle)
def _(rect):
    return (
        f'<rect '
        f'x="{rect.p[0]}" '
        f'y="{rect.p[1]}" '
        f'width="{rect.width}" '
        f'height="{rect.height}" '
        f'{attrs(rect)} />'
    )


@draw.register(Circle)
def _(circle):
    return (
        f'<circle '
        f'cx="{circle.center[0]}" '
        f'cy="{circle.center[1]}" '
        f'r="{circle.radius}" '
        f'{attrs(circle)} />'
    )


@draw.register(Polygon)
def _(polygon):
    return '<polygon points="{points}" {attrs} />'.format(
        points=" ".join(f"{p[0]} {p[1]}" for p in polygon.points),
        attrs=attrs(polygon)
    )


def draw_group(group):
    return (
        '<g>\n{}\n</g>'.format(
            "\n".join(draw(shape) for shape in group.shapes)
        )
    )


def make_svg_document(min_x, min_y, max_x, max_y, shapes):
    """Make an SVG document from a collection of shapes."""
    return (
        '<svg viewBox="{min_x} {min_y} {width} {height}" xmlns="http://www.w3.org/2000/svg">'
        '\n{shapes}\n'
        '</svg>'.format(
            min_x=min_x,
            min_y=min_y,
            width=max_x - min_x,
            height=max_y - min_y,
            shapes="\n".join(draw(shape) for shape in shapes)
        )
    )


if __name__ == "__main__":
    outline = Polygon(points=[
            (300, 425), (580, 425), (560, 155), (510, 155),
            (500, 285), (450, 250), (450, 285), (400, 250),
            (400, 285), (350, 250), (350, 285), (300, 250),
        ],
        stroke_width=8,
        stroke_color="#2a9fbc",
        fill_color="#addbea",
    )
    left_window = Rectangle(
        p=(350, 330),
        width=50, height=40,
        stroke_width=6,
        stroke_color="#2a9fbc",
        fill_color="#ffffff",
    )
    right_window = Rectangle(
        p=(430, 330),
        width=50, height=40,
        stroke_width=6,
        stroke_color="#2a9fbc",
        fill_color="#ffffff",
    )
    smoke = Group(
        [
            Circle(center=(550, 120), radius=30, fill_color="#d8d8d8"),
            Circle(center=(600, 90), radius=40, fill_color="#d8d8d8"),
            Circle(center=(650, 60), radius=50, fill_color="#d8d8d8"),
        ]
    )
    d = make_svg_document(300, 10, 700, 425, [outline, right_window, left_window, smoke])
    with open("shapes.svg", "wt", encoding="utf=8") as svg_file:
        print(d, file=svg_file)
