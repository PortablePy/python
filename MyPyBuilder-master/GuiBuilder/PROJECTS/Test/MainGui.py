from MyPyWidgets import *
from GuiBuilder.PROJECTS.Test import *


class Gui(object):

    def __init__(self):
        self.main = MainTemplate(self)
        self.main.window = MyPyWindow(**self.main.widget)
        self.main_window = self.main.window
        self.main_components = self.main.components
        self.structure = BuildHelper()
        self.structure_components = self.structure.components

        self.dsf = Maindsf(self)
        self.dsf.window = None
        self.dsf_window = None
        self.dsf_components = self.dsf.components

        # &FRAMES
    def run(self):
        for widget in self.structure_components['root_window']:
            self.main_components[widget.__name__] = widget(self.main)
            self.main_window.add_widget(**self.main_components[widget.__name__].widget)
        self.main_window.setup()
        self.main_window.run()

    def show_dsf(self):
        self.dsf.widget['master'] = self.main_window
        if self.dsf.widget['type'] == 'toplevel':
            self.main_window.add_toplevel(**self.dsf.widget)
        else:
            self.main_window.add_frame(**self.dsf.widget)
        self.dsf.window = self.main_window.containers[self.dsf.widget['id']]
        self.dsf_window = self.dsf.window
        for widget in self.structure_components['dsf']:
            self.dsf_components[widget.__name__] = widget(self.dsf)
            self.dsf_window.add_widget(**self.dsf_components[widget.__name__].widget)

    # &SHOWFRAME
