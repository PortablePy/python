from dataclasses import dataclass, replace


@dataclass
class Frame:
    top: str = "-"
    left: str = "|"
    bottom: str = "-"
    right: str = "|"
    top_left: str = "+"
    top_right: str = "+"
    bottom_left: str = "+"
    bottom_right: str = "+"


fancy_frame = Frame("─", "│", "─", "│", "╭", "╮", "╰", "╯")
invisible_frame = Frame(" ", " ", " ", " ", " ", " ", " ", " ")


def frame_text(text: str, frame: Frame) -> str:
    s_list = text.split('\n')
    count = 0
    for s in s_list:
        count = max(len(s), count)   
    out = frame.top_left
    for c in range(count):
        out += frame.top
    out += frame.top_right + '\n'
    for s in s_list:
        f = ""
        if len(s) < count:
            f = " "* (count - len(s))
        out += frame.left + s + f + frame.right + '\n'
    out += frame.bottom_left
    for c in range(count):
        out += frame.bottom
    out += frame.bottom_right
    return out



te ='      *\n     ***\n    *****\n   *******\n    *****\n   *******\n  *********\n ***********\n*************\n     |||\n     |||'

fr = Frame(top='-', left='|', bottom='-', right='|', top_left='+', top_right='+', bottom_left='+', bottom_right='+')

print(frame_text(te, fr))