from MyPyWidgets import *


class DropDownDD(object):

    def __init__(self, master):
        self.master = master
        self.widget = {
            'master': 'root_window',
            'id': 'DD',
            'widget': DropDown,
            'args': [self.DD_dropdown_default(),
                     self.DD_dropdown_choices(),
                     self.DD_dropdown_go],
            'location': {
                'row': 206,
                'column': 29,
                'rowspan': 25,
                'columnspan': 100,
                'sticky': 'NSWE'
                }
            }

    #&FUNCTIONS
    def DD_dropdown_default(self):
        """
        Return the default value displayed by DD_dropdown, once an option has been selected, this option will no
        longer be displayed or available
        """
        return 'DD Default'

    def DD_dropdown_choices(self):
        """
        Return the list of choices to be displayed by DD_dropdown
        """
        return ['DD Choices']

    def DD_dropdown_go(self, *args):
        """
        Function called when an option is selected in DD_dropdown.
        args[0] will contain the value selected
        """
        print('DD')

