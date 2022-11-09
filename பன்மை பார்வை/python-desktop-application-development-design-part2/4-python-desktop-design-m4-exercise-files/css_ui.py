# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'css.ui'
#
# Created: Mon Sep 29 19:54:42 2014
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

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName(_fromUtf8("Dialog"))
        Dialog.resize(400, 300)
        Dialog.setStyleSheet(_fromUtf8("QLineEdit { \n"
"  padding: 6px 12px;\n"
"  font-size: 14px;\n"
"  color: #555;\n"
"  background-color: #fff;\n"
"  border: 1px solid #ccc;\n"
"  border-radius: 4px;\n"
"}\n"
"QLineEdit:focus {\n"
"  border-color: #66afe9;\n"
"}"))
        self.frame = QtGui.QFrame(Dialog)
        self.frame.setGeometry(QtCore.QRect(0, 0, 401, 80))
        self.frame.setStyleSheet(_fromUtf8("QFrame { \n"
"background-color: qlineargradient(spread:pad, x1:1, y1:1, x2:1, y2:0, stop:0 rgba(250, 250, 250, 90), stop:1 rgba(255, 255, 255, 255));\n"
"border-bottom: 1px solid darkgrey;\n"
"}\n"
"\n"
"QToolButton {\n"
"    background-color: transparent;\n"
"    border: none;\n"
"}\n"
"\n"
"QToolButton:checked, QToolButton:pressed {\n"
"    background-color: rgb(193, 210, 238);\n"
"    border: 1px solid rgb(60, 127, 177);\n"
"}\n"
"\n"
"QToolButton:hover {\n"
"    background-color: rgb(224, 232, 246);\n"
"}\n"
"\n"
"QToolButton::checked:hover {\n"
"    background-color: rgb(193, 210, 238);\n"
"}"))
        self.frame.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtGui.QFrame.Raised)
        self.frame.setObjectName(_fromUtf8("frame"))
        self.facebook = QtGui.QToolButton(self.frame)
        self.facebook.setGeometry(QtCore.QRect(50, 20, 61, 51))
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(_fromUtf8(":/facebook.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.facebook.setIcon(icon)
        self.facebook.setIconSize(QtCore.QSize(32, 32))
        self.facebook.setCheckable(True)
        self.facebook.setAutoExclusive(True)
        self.facebook.setToolButtonStyle(QtCore.Qt.ToolButtonTextUnderIcon)
        self.facebook.setObjectName(_fromUtf8("facebook"))
        self.twitter = QtGui.QToolButton(self.frame)
        self.twitter.setGeometry(QtCore.QRect(170, 20, 61, 51))
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(_fromUtf8(":/twitter.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.twitter.setIcon(icon1)
        self.twitter.setIconSize(QtCore.QSize(32, 32))
        self.twitter.setCheckable(True)
        self.twitter.setAutoExclusive(True)
        self.twitter.setToolButtonStyle(QtCore.Qt.ToolButtonTextUnderIcon)
        self.twitter.setObjectName(_fromUtf8("twitter"))
        self.googleplus = QtGui.QToolButton(self.frame)
        self.googleplus.setGeometry(QtCore.QRect(280, 20, 61, 51))
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(_fromUtf8(":/googleplus.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.googleplus.setIcon(icon2)
        self.googleplus.setIconSize(QtCore.QSize(32, 32))
        self.googleplus.setCheckable(True)
        self.googleplus.setAutoExclusive(True)
        self.googleplus.setToolButtonStyle(QtCore.Qt.ToolButtonTextUnderIcon)
        self.googleplus.setObjectName(_fromUtf8("googleplus"))
        self.username = QtGui.QLineEdit(Dialog)
        self.username.setGeometry(QtCore.QRect(130, 100, 141, 31))
        self.username.setObjectName(_fromUtf8("username"))
        self.password = QtGui.QLineEdit(Dialog)
        self.password.setGeometry(QtCore.QRect(130, 140, 141, 31))
        self.password.setEchoMode(QtGui.QLineEdit.Password)
        self.password.setObjectName(_fromUtf8("password"))
        self.progressBar = QtGui.QProgressBar(Dialog)
        self.progressBar.setGeometry(QtCore.QRect(130, 180, 141, 23))
        self.progressBar.setStyleSheet(_fromUtf8("QProgressBar {\n"
"  border: 2px solid grey;\n"
"  border-radius: 5px;\n"
"  text-align: center;\n"
"}\n"
"\n"
"QProgressBar::chunk {\n"
"  background-color: #3366FF;\n"
"  width: 10px;\n"
"  margin: 1px;\n"
"}"))
        self.progressBar.setProperty("value", 24)
        self.progressBar.setInvertedAppearance(False)
        self.progressBar.setObjectName(_fromUtf8("progressBar"))
        self.pushButton = QtGui.QPushButton(Dialog)
        self.pushButton.setGeometry(QtCore.QRect(160, 220, 75, 23))
        self.pushButton.setStyleSheet(_fromUtf8("QPushButton {\n"
"  font-size: 14px;\n"
"  border: 1px solid transparent;\n"
"  border-radius: 4px;\n"
"  color: #fff;\n"
"  background-color: #428bca;\n"
"  border-color: #357ebd;\n"
"}\n"
"\n"
"QPushButton:hover {\n"
"  color: #fff;\n"
"  background-color: #3071a9;\n"
"  border-color: #285e8e;\n"
"}"))
        self.pushButton.setObjectName(_fromUtf8("pushButton"))

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.facebook.setText(_translate("Dialog", "Facebook", None))
        self.twitter.setText(_translate("Dialog", "Twitter", None))
        self.googleplus.setText(_translate("Dialog", "Google+", None))
        self.username.setPlaceholderText(_translate("Dialog", "Username", None))
        self.password.setPlaceholderText(_translate("Dialog", "Password", None))
        self.pushButton.setText(_translate("Dialog", "Log In", None))

import icons_rc
