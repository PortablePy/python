# encoding: utf8
import os
import sys
import unittest
try:
    import tkinter as tk
    import tkinter.ttk as ttk
    from tkinter.scrolledtext import ScrolledText
except:
    import Tkinter as tk
    import ttk
    from ScrolledText import ScrolledText


pygubu_basedir = os.path.abspath(os.path.dirname(
                    os.path.dirname(os.path.realpath(sys.argv[0]))))
if pygubu_basedir not in sys.path:
    sys.path.insert(0, pygubu_basedir)

import pygubu
import support


class TestText(unittest.TestCase):

    def setUp(self):
        support.root_deiconify()
        xmldata = 'test_tkinterscrolledtext.ui'
        self.builder = builder = pygubu.Builder()
        builder.add_from_file(xmldata)
        self.widget = builder.get_object('mainframe')
        self.text = builder.get_object('scrolledtext_1')

    def tearDown(self):
        support.root_withdraw()

    def test_class(self):
        self.assertIsInstance(self.text, tk.Text)
        self.widget.destroy()
