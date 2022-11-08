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


def draw(self):
    return (
        f'<circle '
        f'cx="{self.center[0]}" '
        f'cy="{self.center[1]}" '
        f'r="{self.radius}" '
        f'{self.attrs()} />'
    )
