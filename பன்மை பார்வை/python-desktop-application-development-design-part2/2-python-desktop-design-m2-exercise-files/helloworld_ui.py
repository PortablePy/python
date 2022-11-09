# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'helloworld.ui'
#
# Created: Sun Sep  7 21:02:22 2014
#      by: PyQt4 UI code generator 4.11.1
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_helloworld(object):
    def setupUi(self, helloworld):
        helloworld.setObjectName(_fromUtf8("helloworld"))
        helloworld.resize(191, 149)
        helloworld.setSizeGripEnabled(False)
        helloworld.setModal(True)
        self.verticalLayout = QtGui.QVBoxLayout(helloworld)
        self.verticalLayout.setObjectName(_fromUtf8("verticalLayout"))
        self.url = QtGui.QLineEdit(helloworld)
        self.url.setObjectName(_fromUtf8("url"))
        self.verticalLayout.addWidget(self.url)
        self.save_location = QtGui.QLineEdit(helloworld)
        self.save_location.setObjectName(_fromUtf8("save_location"))
        self.verticalLayout.addWidget(self.save_location)
        self.browse = QtGui.QPushButton(helloworld)
        self.browse.setObjectName(_fromUtf8("browse"))
        self.verticalLayout.addWidget(self.browse)
        self.progress = QtGui.QProgressBar(helloworld)
        self.progress.setProperty("value", 0)
        self.progress.setAlignment(QtCore.Qt.AlignCenter)
        self.progress.setObjectName(_fromUtf8("progress"))
        self.verticalLayout.addWidget(self.progress)
        self.download = QtGui.QPushButton(helloworld)
        self.download.setObjectName(_fromUtf8("download"))
        self.verticalLayout.addWidget(self.download)

        self.retranslateUi(helloworld)
        QtCore.QMetaObject.connectSlotsByName(helloworld)

    def retranslateUi(self, helloworld):
        helloworld.setWindowTitle(_translate("helloworld", "QtDesigner", None))
        self.url.setPlaceholderText(_translate("helloworld", "URL", None))
        self.save_location.setPlaceholderText(_translate("helloworld", "File save location", None))
        self.browse.setText(_translate("helloworld", "Browse", None))
        self.download.setText(_translate("helloworld", "Download", None))

