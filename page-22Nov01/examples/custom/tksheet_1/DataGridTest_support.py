#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#
# Support module generated by PAGE version 7g
#  in conjunction with Tcl version 8.6
#    Jun 12, 2021 08:13:07 AM PDT  platform: Linux

#-------------------------------------------------------------------------------
# A basic example of using the tksheet 3rd-party package, written by
# ragardner, https://github.com/ragardner/tksheet, as a custom widget within
# a python PAGE application.
#
# A data grid with 10 rows and 6 columns is created on screen startup, with
# each cell populated with some default data. As first set up, the grid has
# some basic functionality :
#
# [1] Columns and rows can be resized by width and height respectively.
# [2] Columns and rows can be highlighted by clicking on the col/row header.
# [3] Cells can be selected by left-clicking them. This will also make the cell
#     contents and its row/col index available in the code.
# [4] A block of cells can be highlighted by dragging the mouse over them.
# [5] Double-clicking a cell will put it in edit mode, to allow contents to be
#     edited, replaced or deleted.
# [6] The standard Ctrl-C and Ctrl-V keys can be used to copy and paste cell
#     contents.
# [7] Individual cells can be highlighted by setting the text and background
#     colours, under program control.
#
# As well as displaying the data grid, the PAGE screen will display the cell
# values in a label widget when a cell is selected.
# A <Load Data> button is also present, which will populate the data grid with
# a set of values, and also set the column/row headers, column widths and
# conditional cell formatting, as if the data was being loaded from an
# external file or database, for example.
# A <Clear> button will reset the data grid to empty and remove any cell
# highlighting that had been applied.
#-------------------------------------------------------------------------------

import sys
import tkinter as tk
import tkinter.ttk as ttk
from tkinter.constants import *

import DataGridTest

# This is the external class that implements the sheet (data grid) widget.
from tksheet import Sheet

def main(*args):
    '''Main entry point for the application.'''
    global root
    root = tk.Tk()
    root.protocol( 'WM_DELETE_WINDOW' , root.destroy)
    # Creates a toplevel widget.
    global _top42, _w42
    _top42 = root
    _w42 = DataGridTest.Toplevel1(_top42)
    init(_top42, _w42)
    root.mainloop()

#-------------------------------------------------------------------------------

def btnClear_Click(*args):
    """ Clear all data from the data grid. """

    # Get the full sheet in a list of lists, to get no. of rows and columns
    data = w.Custom1.get_sheet_data()

    # Set each cell to a single space character.
    for row in range(0,len(data)):
        w.Custom1.set_row_data(row, values=(' ' * len(data[0])))
        # Remove any conditional formatting from the 'Balance' column.
        w.Custom1.highlight_cells(row,5,bg='#fcfcfc',fg='black')

    # Refresh the sheet to display the new values.
    w.Custom1.refresh()

    w.lblCellValue.config(text='')

#-------------------------------------------------------------------------------

def btnLoad_Click(*args):
    """ Load data to the data grid and apply some formatting. This data would
        usually come from a file or database query. """

    # Clear the data before repopulating.
    btnClear_Click()

    # Load the data into the data grid.
    rows = loadData()

    # Apply some formatting to the data grid.
    formatSheet(rows)

    # Refresh the sheet to display the new values/formatting.
    w.Custom1.refresh()

#-------------------------------------------------------------------------------

def loadData():
    """ Create some data to load to the data grid. """

    # Set up a list to hold the Column Header values.
    head = ['Account','Type','Transactions','Start Date','End Date','Balance']
    # and apply them to the data grid.
    w.Custom1.headers(head)

    # Set up a list of lists to hold the data...
    details = [
        ['Account 1', 'Current', 123, '2012-02-24', '2020-09-12', 123.45],
        ['Account 2', 'Savings', 45, '2016-12-04', '2020-07-23', 1234.56],
        ['Account 3', 'Credit Card', 76, '2018-04-01', '2020-08-30', -345.67],
        ['Account 4', 'Credit Card', 143, '2019-01-01', '2020-09-10', -23.44],
        ['Account 5', 'Savings', 38, '2020-02-03', '2020-08-25', 876.54] ]
    # and add them to the data grid.
    for row in range(0,len(details)):
        for col in range(0,len(details[0])):
            w.Custom1.set_cell_data(row, col, details[row][col])

    return len(details)

#-------------------------------------------------------------------------------

def formatSheet(rows):
    """ Set up various formatting options for the data grid.  """

    # Change column width
    w.Custom1.column_width(1,100)

    # Change column alignment
    w.Custom1.align_columns(2,'center')
    w.Custom1.align_columns(3,'center')
    w.Custom1.align_columns(4,'center')
    w.Custom1.align_columns(5,'e')

    # Highlight any cells that meet a condition - a Balance that is negative.
    for row in range(0,rows):
        value = w.Custom1.get_cell_data(row,5)
        if value != ' ' and value != '':
            if float(value) < 0:
                w.Custom1.highlight_cells(row=row,column=5,fg='white',bg='red')

#-------------------------------------------------------------------------------

def init(top, gui, *args, **kwargs):
    global w, top_level, root
    w = gui
    top_level = top
    root = top

    w.lblCellValue.config(text='')

    # Call a separate function to initialise the sheet (data grid) widget.
    initialise_custom_widget()

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

def initialise_custom_widget():
    """
    The tksheet.Sheet class has a lot of properties and event handlers, this
    initialisation function only uses a small subset of them to make a data
    grid with fairly basic functionality and formatting. There is minimal (or
    no) documentation with tksheet, so to extend the functionality illustrated
    here, look at the test_tksheet.py on GitHub for other options.
    """

    # Initialise the sheet with 10 rows.
    for idx in range(0,10):
        w.Custom1.insert_row()
        # Create the columns by assigning data values to the rows.
        # Each character in 'values' will create a single column.
        w.Custom1.set_row_data(idx,values=('*' * 6))

    # Enable a subset of the built-in class event handlers. These don't need to
    # be defined here, they are included in the class.
    w.Custom1.enable_bindings(
        ("single_select",
        "drag_select",
        "column_select",
        "row_select",
        "column_width_resize",
        "row_height_resize",
        "copy",
        "cut",
        "paste",
        "delete",
        "undo",
        "edit_cell")
        )

    # Additional event handlers that require a local definition.
    w.Custom1.extra_bindings([('cell_select', cell_select)])

#-------------------------------------------------------------------------------

def cell_select(response):
    """
    This event handler will return a value when a cell in the sheet is either
    left-clicked with the mouse, or the <Enter> key pressed when the cell is
    selected. response[1] is the row index, response[2] is the column index.
    An additional class method can then be used to retrieve the value held in
    the cell. """

    row = response[1]
    col = response[2]
    value = w.Custom1.get_cell_data(row, col)
    temp = 'Row: ' + str(row) + ', Col: ' + str(col) + ' --- > Value: ' + value

    w.lblCellValue.config(text=temp)

#-------------------------------------------------------------------------------

def destroy_window():
    # Function which closes the window.
    global top_level
    top_level.destroy()
    top_level = None

#-------------------------------------------------------------------------------

Custom = tk.Frame    # To be updated by user with name of custom widget.
Custom = Sheet       # The class imported from the tksheet package.

#-------------------------------------------------------------------------------

if __name__ == '__main__':
    DataGridTest.start_up()
