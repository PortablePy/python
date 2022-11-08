from MyPyWidgets import *


class DropDowneg(object):

    def __init__(self, master):
        self.master = master
        self.widget = {
            'master': 'root_window',
            'id': 'eg',
            'widget': DropDown,
            'args': [self.eg_dropdown_default(),
                     self.eg_dropdown_choices(),
                     self.eg_dropdown_go],
            'location': {
                'row': 104,
                'column': 244,
                'rowspan': 25,
                'columnspan': 100,
                'sticky': 'NSWE'
                }
            }

    #&FUNCTIONS
    def eg_dropdown_default(self):
        """
        Return the default value displayed by eg_dropdown, once an option has been selected, this option will no
        longer be displayed or available
        """
        return 'eg Default'

    def eg_dropdown_choices(self):
        """
        Return the list of choices to be displayed by eg_dropdown
        """
        return ['eg Choices']

    def eg_dropdown_go(self, *args):
        """
        Function called when an option is selected in eg_dropdown.
        args[0] will contain the value selected
        """
        print('eg')

