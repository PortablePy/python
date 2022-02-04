// -*- C++ -*-
//
// generated by wxGlade
//
// Example for compiling a single file project under Linux using g++:
//  g++ MyApp.cpp $(wx-config --libs) $(wx-config --cxxflags) -o MyApp
//
// Example for compiling a multi file project under Linux using g++:
//  g++ main.cpp $(wx-config --libs) $(wx-config --cxxflags) -o MyApp Dialog1.cpp Frame1.cpp
//

#ifndef COMPLEXEXAMPLE_30_H
#define COMPLEXEXAMPLE_30_H

#include <wx/wx.h>
#include <wx/image.h>
#include <wx/intl.h>

#ifndef APP_CATALOG
#define APP_CATALOG "ComplexExampleApp"  // replace with the appropriate catalog name
#endif


// begin wxGlade: ::dependencies
#include <wx/grid.h>
#include <wx/notebook.h>
#include <wx/statline.h>
// end wxGlade

// begin wxGlade: ::extracode
// end wxGlade


class PyOgg2_MyFrame: public wxFrame {
public:
    // begin wxGlade: PyOgg2_MyFrame::ids
    // end wxGlade

    PyOgg2_MyFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos=wxDefaultPosition, const wxSize& size=wxDefaultSize, long style=wxDEFAULT_FRAME_STYLE);

private:

protected:
    // begin wxGlade: PyOgg2_MyFrame::attributes
    wxMenuBar* Mp3_To_Ogg_menubar;
    wxStatusBar* Mp3_To_Ogg_statusbar;
    wxToolBar* Mp3_To_Ogg_toolbar;
    wxNotebook* notebook_1;
    wxPanel* notebook_1_pane_1;
    wxTextCtrl* text_ctrl_1;
    wxButton* button_3;
    wxPanel* notebook_1_pane_2;
    wxRadioBox* rbx_sampling_rate;
    wxCheckBox* cbx_love;
    wxPanel* notebook_1_pane_3;
    wxTextCtrl* text_ctrl_2;
    wxPanel* notebook_1_pane_4;
    wxStaticText* _lbl_output_filename;
    wxTextCtrl* text_ctrl_3;
    wxButton* button_4;
    wxCheckBox* checkbox_1;
    wxPanel* notebook_1_pane_5;
    wxStaticText* label_1;
    wxStaticLine* static_line_1;
    wxButton* button_5;
    wxButton* button_2;
    wxButton* button_1;
    // end wxGlade

    DECLARE_EVENT_TABLE();

public:
    virtual void OnOpen(wxCommandEvent &event); // wxGlade: <event_handler>
    virtual void OnClose(wxCommandEvent &event); // wxGlade: <event_handler>
    virtual void OnAboutDialog(wxCommandEvent &event); // wxGlade: <event_handler>
    virtual void startConverting(wxCommandEvent &event); // wxGlade: <event_handler>
}; // wxGlade: end class


class MyFrameGrid: public wxFrame {
public:
    // begin wxGlade: MyFrameGrid::ids
    // end wxGlade

    MyFrameGrid(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos=wxDefaultPosition, const wxSize& size=wxDefaultSize, long style=wxDEFAULT_FRAME_STYLE);

private:

protected:
    // begin wxGlade: MyFrameGrid::attributes
    wxBoxSizer* _szr_frame;
    wxFlexGridSizer* grid_sizer;
    wxGrid* grid;
    wxStaticLine* static_line;
    wxButton* button;
    // end wxGlade
}; // wxGlade: end class


#endif // COMPLEXEXAMPLE_30_H
