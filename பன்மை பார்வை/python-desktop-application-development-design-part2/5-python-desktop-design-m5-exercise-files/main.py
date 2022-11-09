from PyQt4.QtGui import *
from PyQt4.QtCore import *
import sys

from ui import css_ui


class Beautiful(QDialog, css_ui.Ui_Dialog):
    def __init__(self):
        QDialog.__init__(self)
        self.setupUi(self)


app = QApplication(sys.argv)
dialog = Beautiful()
dialog.show()
app.exec_()
