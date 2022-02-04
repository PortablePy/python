#!/usr/bin/env lisp
;;;
;;; generated by wxGlade
;;;

(asdf:operate 'asdf:load-op 'wxcl)
(use-package "FFI")
(ffi:default-foreign-language :stdc)


;;; begin wxGlade: dependencies
(use-package :NotebookPageWithBases)
(use-package :SplitterWindowWithBasesInFrame)
(use-package :TestNotebookWithBasesInFrame)
(use-package :TestPanelWithBasesInFrame)
(use-package :wx.html.HtmlWindow)
(use-package :wxButton)
(use-package :wxCL)
(use-package :wxColour)
(use-package :wxEvent)
(use-package :wxEvtHandler)
(use-package :wxFrame)
(use-package :wxMenu)
(use-package :wxMenuBar)
(use-package :wxNotebook)
(use-package :wxPanel)
(use-package :wxScrolledWindow)
(use-package :wxSizer)
(use-package :wxSplitterWindow)
(use-package :wxStatusBar)
(use-package :wxToolBar)
(use-package :wxWindow)
(use-package :wx_main)
(use-package :wx_wrapper)
;;; end wxGlade

;;; begin wxGlade: extracode
import wx.html
;;; end wxGlade


(defclass MyFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)))

(defun make-MyFrame ()
        (let ((obj (make-instance 'MyFrame)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyFrame))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyFrame.__init__
        (setf (slot-top-window obj) (wxFrame_create nil wxID_ANY "" -1 -1 -1 -1 wxDEFAULT_FRAME_STYLE))
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        (wxFrame_SetTitle (slot-top-window obj) "frame")
        
        ;;; Menu Bar
        (setf (slot-frame-menubar obj) (wxMenuBar_Create 0))
        (wxFrame_SetMenuBar (slot-top-window obj) (slot-frame-menubar obj))
        ;;; Menu Bar end
        
        (setf (slot-frame-statusbar obj) (wxFrame_CreateStatusBar (slot-top-window obj) 1 0))
        (wxStatusBar_SetStatusWidths (slot-frame-statusbar obj) 1 (vector -1))
        (wxStatusBar_SetStatusText (slot-frame-statusbar obj) "frame_statusbar" 0)
        
        ;;; Tool Bar
        (setf (slot-frame-toolbar obj) (wxToolBar_Create (slot-top-window obj) -1 -1 -1 -1 -1 wxTB_HORIZONTAL))
        (wxFrame_SetToolBar (slot-top-window obj) (slot-frame-toolbar obj))
        (wxToolBar_Realize (slot-frame-toolbar obj))
        ;;; Tool Bar end
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxHORIZONTAL))
        
        (setf (slot-panel-x obj) (wxPanel_Create (slot-top-window obj) wxID_ANY -1 -1 -1 -1 wxTAB_TRAVERSAL))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-panel-x obj) 1 wxEXPAND 0 nil)
        
        (setf (slot-sizer-2 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (setf (slot-notebook-1 obj) (wxNotebook_Create (slot-panel-x obj) wxID_ANY -1 -1 -1 -1 wxNB_TOP))
        (wxSizer_AddWindow (slot-sizer-2 obj) (slot-notebook-1 obj) 1 wxEXPAND 0 nil)
        
        (setf (slot-notebook-1-pane-1 obj) (wxPanel_Create (slot-notebook-1 obj) wxID_ANY -1 -1 -1 -1 wxTAB_TRAVERSAL))
        (wxNotebook_AddPage (slot-notebook-1 obj) (slot-notebook-1-pane-1 obj) "notebook_1_pane_1" 1 -1)
        
        (wxSizer_AddWindow (slot-sizer-2 obj) ((20, 20) obj) 0 wxALIGN_CENTER_HORIZONTAL 0 nil)
        
        (setf (slot-window-1 obj) (wxSplitterWindow_Create (slot-panel-x obj) wxID_ANY -1 -1 -1 -1 wxSP_3D))
        wxSplitterWindow_SetMinimumPaneSize (slot-window-1 obj) 20)
        (wxSizer_AddWindow (slot-sizer-2 obj) (slot-window-1 obj) 1 wxEXPAND 0 nil)
        
        (setf (slot-window-1-pane-1 obj) (wxPanel_Create (slot-window-1 obj) wxID_ANY -1 -1 -1 -1 wxTAB_TRAVERSAL))
        (wxWindow_SetBackgroundColour (slot-window-1-pane-1 obj) (wxColour_CreateRGB 112, 219, 147))
        
        (setf (slot-window-1-pane-2-scrolled obj) (wxPanel_Create (slot-window-1 obj) wxID_ANY -1 -1 -1 -1 wxTAB_TRAVERSAL))
        (wxWindow_SetBackgroundColour (slot-window-1-pane-2-scrolled obj) (wxColour_CreateRGB 35, 142, 35))
        (wxScrolledWindow:wxScrolledWindow_SetScrollRate (slot-window-1-pane-2-scrolled obj) 10  10)
        
        (setf html (wx.html.HtmlWindow_Create (object-panel-x self) wxID_ANY))
        (wxSizer_AddWindow (slot-sizer-2 obj) (slot-html obj) 1 (logior wxALL wxEXPAND) 3 nil)
        
        (SplitVertically window-1 window_1_pane_1 window_1_pane_2_scrolled )
        
        (wxWindow_SetSizer (slot-panel-x obj) (slot-sizer-2 obj))
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxFrame_layout (slot-frame self))
        ;;; end wxGlade
        )

;;; end of class MyFrame



(defclass NotebookPageWithBases()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)))

(defun make-NotebookPageWithBases ()
        (let ((obj (make-instance 'NotebookPageWithBases)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj NotebookPageWithBases))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: NotebookPageWithBases.__init__
        (wxPanel_layout (slot-notebook-1-pane-1 self))
        ;;; end wxGlade
        )

;;; end of class NotebookPageWithBases



(defclass TestNotebookWithBasesInFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)))

(defun make-TestNotebookWithBasesInFrame ()
        (let ((obj (make-instance 'TestNotebookWithBasesInFrame)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj TestNotebookWithBasesInFrame))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: TestNotebookWithBasesInFrame.__init__
        
        (setf (slot-notebook_1_pane_1 obj) (wxPanel_Create (slot-top-window obj) wxID_ANY -1 -1 -1 -1))
        (wxNotebook_AddPage (slot-notebook_1_pane_1 obj) page "notebook_1_pane_1" 1 -1);
        ;;; end wxGlade
        )

;;; end of class TestNotebookWithBasesInFrame



(defclass SplitterWindowWithBasesInFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)))

(defun make-SplitterWindowWithBasesInFrame ()
        (let ((obj (make-instance 'SplitterWindowWithBasesInFrame)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj SplitterWindowWithBasesInFrame))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: SplitterWindowWithBasesInFrame.__init__
        
        (setf (slot-window-1-pane-1 obj) (wxPanel_Create (slot-top-window obj) wxID_ANY -1 -1 -1 -1 wxTAB_TRAVERSAL))
        (wxWindow_SetBackgroundColour (slot-window-1-pane-1 obj) (wxColour_CreateRGB 112, 219, 147))
        
        (setf (slot-window-1-pane-2 obj) (wxPanel_Create (slot-top-window obj) wxID_ANY -1 -1 -1 -1 wxTAB_TRAVERSAL))
        (wxWindow_SetBackgroundColour (slot-window-1-pane-2 obj) (wxColour_CreateRGB 35, 142, 35))
        $self->SplitVertically($self->{window_1_pane_1}, $self->{window_1_pane_2}, );
        ;;; end wxGlade
        )

;;; end of class SplitterWindowWithBasesInFrame



(defclass TestPanelWithBasesInFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)))

(defun make-TestPanelWithBasesInFrame ()
        (let ((obj (make-instance 'TestPanelWithBasesInFrame)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj TestPanelWithBasesInFrame))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: TestPanelWithBasesInFrame.__init__
        
        (setf (slot-sizer-2 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (setf (slot-notebook-1 obj) (wxNotebook_Create (slot-top-window obj) wxID_ANY -1 -1 -1 -1 wxNB_TOP))
        (wxSizer_AddWindow (slot-sizer-2 obj) (slot-notebook-1 obj) 1 wxEXPAND 0 nil)
        
        (setf (slot-window-1 obj) (wxSplitterWindow_Create (slot-top-window obj) wxID_ANY))
        (wxSizer_AddWindow (slot-sizer-2 obj) (slot-window-1 obj) 1 wxEXPAND 0 nil)
        
        (setf html (wx.html.HtmlWindow_Create nil wxID_ANY))
        (wxSizer_AddWindow (slot-sizer-2 obj) (slot-html obj) 1 (logior wxALL wxEXPAND) 3 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-2 obj))
        
        (wxPanel_layout (slot-panel-1 self))
        ;;; end wxGlade
        )

;;; end of class TestPanelWithBasesInFrame



(defclass MyFrameWithBases()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)))

(defun make-MyFrameWithBases ()
        (let ((obj (make-instance 'MyFrameWithBases)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyFrameWithBases))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyFrameWithBases.__init__
        (setf (slot-top-window obj) (wxFrame_create nil wxID_ANY "" -1 -1 -1 -1 wxDEFAULT_FRAME_STYLE))
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        (wxFrame_SetTitle (slot-top-window obj) "frame")
        
        ;;; Menu Bar
        (setf (slot-frame-copy-menubar obj) (wxMenuBar_Create 0))
        (wxFrame_SetMenuBar (slot-top-window obj) (slot-frame-copy-menubar obj))
        ;;; Menu Bar end
        
        (setf (slot-frame-copy-statusbar obj) (wxFrame_CreateStatusBar (slot-top-window obj) 1 0))
        (wxStatusBar_SetStatusWidths (slot-frame-copy-statusbar obj) 1 (vector -1))
        (wxStatusBar_SetStatusText (slot-frame-copy-statusbar obj) "frame_copy_statusbar" 0)
        
        ;;; Tool Bar
        (setf (slot-frame-copy-toolbar obj) (wxToolBar_Create (slot-top-window obj) -1 -1 -1 -1 -1 wxTB_HORIZONTAL))
        (wxFrame_SetToolBar (slot-top-window obj) (slot-frame-copy-toolbar obj))
        (wxToolBar_Realize (slot-frame-copy-toolbar obj))
        ;;; Tool Bar end
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxHORIZONTAL))
        
        (setf (slot-panel_1 obj) (wxPanel_Create (slot-top-window obj) wxID_ANY -1 -1 -1 -1))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-panel-1 obj) 1 wxEXPAND 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxFrame_layout (slot-frame-copy self))
        ;;; end wxGlade
        )

;;; end of class MyFrameWithBases



(defclass MyDialog()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyDialog ()
        (let ((obj (make-instance 'MyDialog)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyDialog))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyDialog.__init__
        (setf (slot-top-window obj) (wxDialog_create nil wxID_ANY "" -1 -1 -1 -1 wxDEFAULT_DIALOG_STYLE))
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        (wxWindow_SetTitle (slot-dialog self) "dialog")
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (wxSizer_AddWindow (slot-sizer-1 obj) ((0, 0) obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxWindow_layout (slot-dialog self))
        ;;; end wxGlade
        )

;;; end of class MyDialog



(defclass MyPanel()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyPanel ()
        (let ((obj (make-instance 'MyPanel)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyPanel))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyPanel.__init__
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (wxSizer_AddWindow (slot-sizer-1 obj) ((0, 0) obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxPanel_layout (slot-panel self))
        ;;; end wxGlade
        )

;;; end of class MyPanel



(defclass MyMDIChildFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyMDIChildFrame ()
        (let ((obj (make-instance 'MyMDIChildFrame)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyMDIChildFrame))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyMDIChildFrame.__init__
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        (wxFrame_SetTitle (slot-top-window obj) "frame_1")
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (wxSizer_AddWindow (slot-sizer-1 obj) ((0, 0) obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxFrame_layout (slot-frame-1 self))
        ;;; end wxGlade
        )

;;; end of class MyMDIChildFrame



(defclass MyMenuBar()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyMenuBar ()
        (let ((obj (make-instance 'MyMenuBar)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyMenuBar))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyMenuBar.__init__
        ;;; end wxGlade
        )

;;; end of class MyMenuBar



(defclass wxToolBar()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-wxToolBar ()
        (let ((obj (make-instance 'wxToolBar)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj wxToolBar))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: wxToolBar.__init__
        (wxToolBar_Realize (slot-toolbar obj))
        ;;; end wxGlade
        )

;;; end of class wxToolBar



(defclass MyDialogWithBases()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyDialogWithBases ()
        (let ((obj (make-instance 'MyDialogWithBases)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyDialogWithBases))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyDialogWithBases.__init__
        (setf (slot-top-window obj) (wxDialog_create nil wxID_ANY "" -1 -1 -1 -1 wxDEFAULT_DIALOG_STYLE))
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        (wxWindow_SetTitle (slot-dialog-copy self) "dialog")
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (wxSizer_AddWindow (slot-sizer-1 obj) ((0, 0) obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxWindow_layout (slot-dialog-copy self))
        ;;; end wxGlade
        )

;;; end of class MyDialogWithBases



(defclass MyPanelWithBases()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyPanelWithBases ()
        (let ((obj (make-instance 'MyPanelWithBases)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyPanelWithBases))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyPanelWithBases.__init__
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (wxSizer_AddWindow (slot-sizer-1 obj) ((0, 0) obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxPanel_layout (slot-panel-copy self))
        ;;; end wxGlade
        )

;;; end of class MyPanelWithBases



(defclass MyPanelScrolled()
        ((top-window :initform nil :accessor slot-top-window)
        (frame-menubar :initform nil :accessor slot-frame-menubar)
        (frame-statusbar :initform nil :accessor slot-frame-statusbar)
        (frame-toolbar :initform nil :accessor slot-frame-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-x :initform nil :accessor slot-panel-x)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2-scrolled :initform nil :accessor slot-window-1-pane-2-scrolled)
        (html :initform nil :accessor slot-html)
        (frame-copy-menubar :initform nil :accessor slot-frame-copy-menubar)
        (frame-copy-statusbar :initform nil :accessor slot-frame-copy-statusbar)
        (frame-copy-toolbar :initform nil :accessor slot-frame-copy-toolbar)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (panel-1 :initform nil :accessor slot-panel-1)
        (sizer-2 :initform nil :accessor slot-sizer-2)
        (notebook-1 :initform nil :accessor slot-notebook-1)
        (notebook-1-pane-1 :initform nil :accessor slot-notebook-1-pane-1)
        (window-1 :initform nil :accessor slot-window-1)
        (window-1-pane-1 :initform nil :accessor slot-window-1-pane-1)
        (window-1-pane-2 :initform nil :accessor slot-window-1-pane-2)
        (html :initform nil :accessor slot-html)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (sizer-1 :initform nil :accessor slot-sizer-1)))

(defun make-MyPanelScrolled ()
        (let ((obj (make-instance 'MyPanelScrolled)))
          (init obj)
          (set-properties obj)
          (do-layout obj)
          obj))

(defmethod init ((obj MyPanelScrolled))
"Method creates the objects contained in the class."
        ;;; begin wxGlade: MyPanelScrolled.__init__
        (slot-top-window obj).wxWindow_SetSize((400, 300))
        (wxScrolledWindow:wxScrolledWindow_SetScrollRate (slot-10  10 obj))
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (wxSizer_AddWindow (slot-sizer-1 obj) ((0, 0) obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxPanel_layout (slot-panel-copy-scrolled self))
        ;;; end wxGlade
        )

;;; end of class MyPanelScrolled


(defun init-func (fun data evt)
        (let ((frame (make-MyFrame)))
        (ELJApp_SetTopWindow (slot-top-window frame))
        (wxWindow_Show (slot-top-window frame))))
;;; end of class MyApp


(unwind-protect
    (Eljapp_initializeC (wxclosure_Create #'init-func nil) 0 nil)
    (ffi:close-foreign-library "../miscellaneous/wxc-msw2.6.2.dll"))
