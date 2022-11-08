from MyPyWidgets import *


class InputFieldinif(object):

    def __init__(self, master):
        self.master = master
        self.widget = {
            'master': 'root_window',
            'id': 'inif',
            'widget': InputField,
            'args': [],
            'location': {
                'row': 365,
                'column': 270,
                'rowspan': 25,
                'columnspan': 100,
                'sticky': 'NSWE'
            }
        }

    #&FUNCTIONS
