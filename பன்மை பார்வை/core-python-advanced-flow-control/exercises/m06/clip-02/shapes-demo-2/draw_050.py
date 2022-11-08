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


    def draw(self):
        return (
            f'<rect '
            f'x="{self.p[0]}" '
            f'y="{self.p[1]}" '
            f'width="{self.width}" '
            f'height="{self.height}" '
            f'{self.attrs()} />'
        )
