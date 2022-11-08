from PyQt4.QtCore import *
from PyQt4.QtGui import *
import sys





app = QApplication(sys.argv)
dialog = HelloWorld()
dialog.show()
app.exec_()