from fractions import Fraction


def mixed_numeral(vulgar):
    integer = vulgar.numerator // vulgar.denominator
    fraction = Fraction(vulgar.numerator - integer * vulgar.denominator,
                        vulgar.denominator)
    return integer, fraction
