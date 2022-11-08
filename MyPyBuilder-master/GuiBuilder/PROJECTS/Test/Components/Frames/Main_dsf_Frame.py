

class Maindsf(object):

    def __init__(self, master):
        self.master = master
        self.components = {}
        self.window = None
        self.widget = {'type': 'toplevel',
                       'master': None,
                       'title': '234',
                       'id': 'dsf',
                       'owner': self.master,
                       'base_location': {
                            'row': 0,
                            'column': 0,
                            'rowspan': 12,
                            'columnspan': 123,
                            'sticky': 'NSWE'
                            },
                       'row_offset': 0,
                       'column_offset': 0}
