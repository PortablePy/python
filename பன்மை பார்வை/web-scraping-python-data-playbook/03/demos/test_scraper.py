import unittest
import scraper

def test_extract_displacement():
    displacement = scraper.extract_displacement('something 70.0 cubic inches')
    assert displacement == 70.0