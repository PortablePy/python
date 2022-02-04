#!/usr/bin/env lisp
;;;
;;; generated by wxGlade
;;;

(asdf:operate 'asdf:load-op 'wxcl)
(use-package "FFI")
(ffi:default-foreign-language :stdc)


;;; begin wxGlade: dependencies
(use-package :wxCL)
(use-package :wxColour)
(use-package :wxEvent)
(use-package :wxEvtHandler)
(use-package :wxFont)
(use-package :wxFrame)
(use-package :wxSizer)
(use-package :wxStaticText)
(use-package :wxTextCtrl)
(use-package :wxWindow)
(use-package :wx_main)
(use-package :wx_wrapper)
;;; end wxGlade

;;; begin wxGlade: extracode
;;; end wxGlade


(defclass MyFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (text-ctrl-1 :initform nil :accessor slot-text-ctrl-1)
        (label-1 :initform nil :accessor slot-label-1)
        (label-2 :initform nil :accessor slot-label-2)
        (label-3 :initform nil :accessor slot-label-3)
        (label-4 :initform nil :accessor slot-label-4)
        (label-5 :initform nil :accessor slot-label-5)
        (label-6 :initform nil :accessor slot-label-6)))

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
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (setf (slot-text-ctrl-1 obj) (wxTextCtrl_Create (slot-top-window obj) wxID_ANY "Some Input" -1 -1 -1 -1 wxTE_READONLY))
        (wxWindow_SetBackgroundColour (slot-text-ctrl-1 obj) (wxColour_CreateRGB 0, 255, 127))
        (wxWindow_SetForegroundColour (slot-text-ctrl-1 obj) (wxColour_CreateRGB 255, 0, 0))
        (wxWindow_SetFont (slot-text-ctrl-1 obj) (wxFont_Create 16 wxDEFAULT wxNORMAL wxBOLD 0 "" wxFONTENCODING_DEFAULT))
        (wxWindow_SetFocus (slot-text-ctrl-1 obj))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-text-ctrl-1 obj) 1 (logior wxALL wxEXPAND) 5 nil)
        
        (setf (slot-label-1 obj) (wxStaticText_Create (slot-top-window obj) wxID_ANY "label_1" -1 -1 -1 -1 0))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-label-1 obj) 0 0 0 nil)
        
        (setf (slot-label-2 obj) (wxStaticText_Create (slot-top-window obj) wxID_ANY "label_2" -1 -1 -1 -1 0))
        (wxWindow_SetFont label-2 (wxFont_Create 8 wxDECORATIVE wxSLANT wxLIGHT 0 "" wxFONTENCODING_DEFAULT))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-label-2 obj) 0 0 0 nil)
        
        (setf (slot-label-3 obj) (wxStaticText_Create (slot-top-window obj) wxID_ANY "label_3" -1 -1 -1 -1 0))
        (wxWindow_SetFont label-3 (wxFont_Create 8 wxROMAN wxITALIC wxBOLD 0 "" wxFONTENCODING_DEFAULT))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-label-3 obj) 0 0 0 nil)
        
        (setf (slot-label-4 obj) (wxStaticText_Create (slot-top-window obj) wxID_ANY "label_4" -1 -1 -1 -1 0))
        (wxWindow_SetFont label-4 (wxFont_Create 8 wxSCRIPT wxNORMAL wxNORMAL 0 "" wxFONTENCODING_DEFAULT))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-label-4 obj) 0 0 0 nil)
        
        (setf (slot-label-5 obj) (wxStaticText_Create (slot-top-window obj) wxID_ANY "label_5" -1 -1 -1 -1 0))
        (wxWindow_SetFont label-5 (wxFont_Create 10 wxSWISS wxNORMAL wxNORMAL 0 "" wxFONTENCODING_DEFAULT))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-label-5 obj) 0 0 0 nil)
        
        (setf (slot-label-6 obj) (wxStaticText_Create (slot-top-window obj) wxID_ANY "label_6" -1 -1 -1 -1 0))
        (wxWindow_SetFont label-6 (wxFont_Create 12 wxMODERN wxNORMAL wxNORMAL 1 "" wxFONTENCODING_DEFAULT))
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-label-6 obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        
        (wxFrame_layout (slot-frame self))
        ;;; end wxGlade
        )

;;; end of class MyFrame


(defun init-func (fun data evt)
        (let ((frame (make-MyFrame)))
        (ELJApp_SetTopWindow (slot-top-window frame))
        (wxWindow_Show (slot-top-window frame))))
;;; end of class MyApp


(unwind-protect
    (Eljapp_initializeC (wxclosure_Create #'init-func nil) 0 nil)
    (ffi:close-foreign-library "../miscellaneous/wxc-msw2.6.2.dll"))
