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


class Circle(Shape):

    def __init__(self, center, radius, **kwargs):
        super().__init__(**kwargs)
        self.center = center
        self.radius = radius

    def draw(self):
        return (
            f'<circle '
            f'cx="{self.center[0]}" '
            f'cy="{self.center[1]}" '
            f'r="{self.radius}" '
            f'{self.attrs()} />'
        )


class Polygon(Shape):

    def __init__(self, points, **kwargs):
        super().__init__(**kwargs)
        self.points = points

    def draw(self):
        return '<polygon points="{points}" {attrs} />'.format(
            points=" ".join(f"{p[0]} {p[1]}" for p in self.points),
            attrs=self.attrs()
        )


class Group:

    def __init__(self, shapes):
        self.shapes = shapes

    def draw(self):
        return (
            '<g>\n{}\n</g>'.format(
                "\n".join(shape.draw() for shape in self.shapes)
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
            shapes="\n".join(shape.draw() for shape in shapes)
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
