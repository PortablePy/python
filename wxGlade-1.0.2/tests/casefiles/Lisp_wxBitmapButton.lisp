;;; generated by wxGlade
;;;

(asdf:operate 'asdf:load-op 'wxcl)
(use-package "FFI")
(ffi:default-foreign-language :stdc)


;;; begin wxGlade: dependencies
(use-package :wxBitmapButton)
(use-package :wxCL)
(use-package :wxColour)
(use-package :wxEvent)
(use-package :wxEvtHandler)
(use-package :wxFrame)
(use-package :wxSizer)
(use-package :wxWindow)
(use-package :wx_main)
(use-package :wx_wrapper)
;;; end wxGlade

;;; begin wxGlade: extracode
;;; end wxGlade


(defclass MyFrame()
        ((top-window :initform nil :accessor slot-top-window)
        (sizer-1 :initform nil :accessor slot-sizer-1)
        (bitmap-button-1 :initform nil :accessor slot-bitmap-button-1)))

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
        (wxFrame_SetTitle (slot-top-window obj) "frame_1")
        
        (setf (slot-sizer-1 obj) (wxBoxSizer_Create wxVERTICAL))
        
        (setf (slot-bitmap-button-1 obj) (wxBitmapButton_Create (slot-top-window obj) wxID_ANY (wxBitmap_CreateLoad "icons/wxglade_small.png" wxBITMAP_TYPE_ANY) -1 -1 -1 -1 0))
        (slot-bitmap-button-1 obj).wxWindow_SetSize((slot-bitmap-button-1 obj).wxWindow_GetBestSize())
        (wxSizer_AddWindow (slot-sizer-1 obj) (slot-bitmap-button-1 obj) 0 0 0 nil)
        
        (wxWindow_SetSizer (slot-top-window obj) (slot-sizer-1 obj))
        (wxSizer_Fit (slot-sizer-1 obj) (slot-top-window obj))
        
        (wxFrame_layout (slot-frame-1 self))
        ;;; end wxGlade
        )

;;; end of class MyFrame


