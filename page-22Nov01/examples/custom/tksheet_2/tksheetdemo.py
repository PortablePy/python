from tksheet import Sheet
import tkinter as tk


class demo(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(0, weight=1)
        self.frame = tk.Frame(self)
        self.frame.grid_columnconfigure(0, weight=1)
        self.frame.grid_rowconfigure(0, weight=1)
        self.sheet = Sheet(
            self.frame,
            page_up_down_select_row=True,
            #empty_vertical = 0,
            column_width=120,
            startup_select=(0, 1, "rows"),
            data=[[
                f"Row {r}, Column {c}\nnewline1\nnewline2" for c in range(50)
            ] for r in range(1000)],  #to set sheet data at startup
            height=500,  #height and width arguments are optional
            width=1200  #For full startup arguments see DOCUMENTATION.md
        )

        self.sheet.enable_bindings((
            "single_select",  #"single_select" or "toggle_select"
            # "drag_select",  #enables shift click selection as well
            # "column_drag_and_drop",
            # "row_drag_and_drop",
            "column_select",
            "row_select",
            # "column_width_resize",
            # "double_click_column_resize",
            #"row_width_resize",
            #"column_height_resize",
            "arrowkeys",
            "row_height_resize",
            "double_click_row_resize",
            "right_click_popup_menu",
            "rc_select",
            "rc_insert_column",
            "rc_delete_column",
            "rc_insert_row",
            "rc_delete_row",
            # "hide_columns",
            # "copy",
            # "cut",
            # "paste",
            # "delete",
            # "undo",
            "edit_cell"))
        #self.sheet.disable_bindings() #uses the same strings
        #self.sheet.enable_bindings()

        self.frame.grid(row=0, column=0, sticky="nswe")
        self.sheet.grid(row=0, column=0, sticky="nswe")
        """_________________________ EXAMPLES _________________________ """
        """_____________________________________________________________"""

        # __________ CHANGING THEME __________

        #self.sheet.change_theme("light green")

        # __________ DISPLAY SUBSET OF COLUMNS __________

        self.sheet.display_subset_of_columns(indexes=[0, 1, 2, 3, 4, 5],
                                             enable=True)
        #self.sheet.display_columns(enable = False)
        self.sheet.insert_column(idx=0)
        self.sheet.insert_columns(columns=5,
                                  idx=10,
                                  mod_column_positions=False)

        # __________ HIGHLIGHT / DEHIGHLIGHT CELLS __________

        self.sheet.highlight_cells(row=5, column=5, fg="red")
        self.sheet.highlight_cells(row=5, column=1, fg="red")
        self.sheet.highlight_cells(row=5,
                                   bg="#ed4337",
                                   fg="white",
                                   canvas="row_index")
        self.sheet.highlight_cells(column=0,
                                   bg="#ed4337",
                                   fg="white",
                                   canvas="header")

        # __________ CELL / ROW / COLUMN ALIGNMENTS __________

        self.sheet.align_cells(row=1, column=1, align="e")
        self.sheet.align_rows(rows=3, align="e")
        self.sheet.align_columns(columns=4, align="e")

        # __________ ADDITIONAL BINDINGS __________

        #self.sheet.bind("<Motion>", self.mouse_motion)

    """

    UNTIL DOCUMENTATION IS COMPLETE, PLEASE BROWSE THE FILE
    _tksheet.py FOR A FULL LIST OF FUNCTIONS AND THEIR PARAMETERS

    """

    def all_extra_bindings(self, event):
        print(event)

    def begin_edit_cell(self, event):
        print(event)  # event[2] is keystroke
        return event[
            2]  # return value is the text to be put into cell edit window

    def window_resized(self, event):
        pass
        #print (event)

    def deselect(self, event):
        print(event, self.sheet.get_selected_cells())

    def rc(self, event):
        print(event)

    def ctrl_a(self, response):
        print(response)

    def row_select(self, response):
        print(response)

    def column_select(self, response):
        print(response)
        #for i in range(50):
        #    self.sheet.create_dropdown(i, response[1], values=[f"{i}" for i in range(200)], set_value="100",
        #                               destroy_on_select = False, destroy_on_leave = False, see = False)
        #print (self.sheet.get_cell_data(0, 0))
        #self.sheet.refresh()


app = demo()
app.mainloop()