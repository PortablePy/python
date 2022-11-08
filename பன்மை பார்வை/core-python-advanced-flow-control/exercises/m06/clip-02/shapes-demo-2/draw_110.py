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


def draw_rectangle(rect):
    return (
        f'<rect '
        f'x="{rect.p[0]}" '
        f'y="{rect.p[1]}" '
        f'width="{rect.width}" '
        f'height="{rect.height}" '
        f'{attrs(rect)} />'
    )


def draw_circle(circle):
    return (
        f'<circle '
        f'cx="{circle.center[0]}" '
        f'cy="{circle.center[1]}" '
        f'r="{circle.radius}" '
        f'{attrs(circle)} />'
    )


    def draw(self):
        return '<polygon points="{points}" {attrs} />'.format(
            points=" ".join(f"{p[0]} {p[1]}" for p in self.points),
            attrs=self.attrs()
        )
