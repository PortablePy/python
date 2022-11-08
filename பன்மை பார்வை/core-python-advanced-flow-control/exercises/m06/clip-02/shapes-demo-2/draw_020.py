    def attrs(self):
        return ' '.join(
            f'{key}="{value}"' for key, value in
            {
                "stroke": self.stroke_color,
                "stroke-width": self.stroke_width,
                "fill": self.fill_color
            }.items()
            if value is not None
        )
