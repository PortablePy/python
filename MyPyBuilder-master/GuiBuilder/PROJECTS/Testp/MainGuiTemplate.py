

class MainTemplate(object):

    def __init__(self, master):
        self.master = master
        self.components = {}
        self.window = None
        self.widget = {'type': 'root',
                       'master': None,
                       'title': 'test1',
                       'id': 'root_window',
                       'owner': self.master,
                       'base_location': {
                            'row': 0,
                            'column': 0,
                            'rowspan': 640,
                            'columnspan': 480,
                            'sticky': 'NSWE'
                            },
                       'row_offset': 0,
                       'column_offset': 0}
