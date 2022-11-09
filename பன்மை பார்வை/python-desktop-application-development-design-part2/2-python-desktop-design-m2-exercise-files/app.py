from PyQt4.QtCore import *
from PyQt4.QtGui import *
import sys

import helloworld_ui


class HelloWorld(QDialog, helloworld_ui.Ui_helloworld):
    def __init__(self):
        QDialog.__init__(self)
        self.setupUi(self)

        self.progress.setValue(50)
        self.url.setText("http://www.google.com")



app = QApplication(sys.argv)
helloworld = HelloWorld()
helloworld.show()
app.exec_()