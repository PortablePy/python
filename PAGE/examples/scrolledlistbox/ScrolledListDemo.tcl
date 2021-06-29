#############################################################################
# Generated by PAGE version 6.0.1
#  in conjunction with Tcl version 8.6
#  Feb 23, 2021 03:32:32 PM CST  platform: Linux
set vTcl(timestamp) ""
if {![info exists vTcl(borrow)]} {
    tk_messageBox -title Error -message  "You must open project files from within PAGE."
    exit}


if {!$vTcl(borrow) && !$vTcl(template)} {

set vTcl(actual_gui_font_dft_desc)  TkDefaultFont
set vTcl(actual_gui_font_dft_name)  TkDefaultFont
set vTcl(actual_gui_font_text_desc)  TkTextFont
set vTcl(actual_gui_font_text_name)  TkTextFont
set vTcl(actual_gui_font_fixed_desc)  TkFixedFont
set vTcl(actual_gui_font_fixed_name)  TkFixedFont
set vTcl(actual_gui_font_menu_desc)  TkMenuFont
set vTcl(actual_gui_font_menu_name)  TkMenuFont
set vTcl(actual_gui_font_tooltip_desc)  TkDefaultFont
set vTcl(actual_gui_font_tooltip_name)  TkDefaultFont
set vTcl(actual_gui_font_treeview_desc)  TkDefaultFont
set vTcl(actual_gui_font_treeview_name)  TkDefaultFont
set vTcl(actual_gui_bg) #d9d9d9
set vTcl(actual_gui_fg) #000000
set vTcl(actual_gui_analog) #ececec
set vTcl(actual_gui_menu_analog) #ececec
set vTcl(actual_gui_menu_bg) #d9d9d9
set vTcl(actual_gui_menu_fg) #000000
set vTcl(complement_color) #d9d9d9
set vTcl(analog_color_p) #d9d9d9
set vTcl(analog_color_m) #ececec
set vTcl(active_fg) #000000
set vTcl(actual_gui_menu_active_bg)  #ececec
set vTcl(actual_gui_menu_active_fg)  #000000
set vTcl(pr,autoalias) 1
set vTcl(pr,relative_placement) 1
set vTcl(mode) Relative
}




proc vTclWindow.top44 {base} {
    global vTcl
    if {$base == ""} {
        set base .top44
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    set top $base
    ###################
    # CREATING WIDGETS
    ###################
    vTcl::widgets::core::toplevel::createCmd $top -class Toplevel \
        -background $vTcl(actual_gui_bg) -highlightcolor black 
    wm focusmodel $top passive
    wm geometry $top 600x450+613+98
    update
    # set in toplevel.wgt.
    global vTcl
    global img_list
    set vTcl(save,dflt,origin) 0
    wm maxsize $top 1905 1050
    wm minsize $top 1 1
    wm overrideredirect $top 0
    wm resizable $top 1 1
    wm deiconify $top
    wm title $top "New Toplevel"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    set vTcl(real_top) {}
    vTcl:withBusyCursor {
    ttk::style configure Scrolledlistbox -background $vTcl(actual_gui_bg)
    ttk::style configure Scrolledlistbox -foreground $vTcl(actual_gui_fg)
    ttk::style configure Scrolledlistbox -font "$vTcl(actual_gui_font_dft_desc)"
    vTcl::widgets::ttk::scrolledlistbox::CreateCmd $top.scr45 \
        -background $vTcl(actual_gui_bg) -height 75 -highlightcolor black \
        -width 125 
    vTcl:DefineAlias "$top.scr45" "Scrolledlistbox1" vTcl:WidgetProc "Toplevel1" 1

    $top.scr45.01 configure -background white \
        -cursor xterm \
        -font TkFixedFont \
        -foreground black \
        -height 3 \
        -highlightcolor #d9d9d9 \
        -selectbackground blue \
        -selectforeground white \
        -width 10
    button $top.but46 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnExit \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -text Exit 
    vTcl:DefineAlias "$top.but46" "btnExit" vTcl:WidgetProc "Toplevel1" 1
    button $top.but47 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnDeleteListItems \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -text {Delete List Items} 
    vTcl:DefineAlias "$top.but47" "btnDeleteListItems" vTcl:WidgetProc "Toplevel1" 1
    button $top.but48 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnFillList \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -text {Fill List} 
    vTcl:DefineAlias "$top.but48" "btnFillList" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab44 \
        -background $vTcl(actual_gui_bg) -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) -relief sunken -text Label \
        -textvariable SelectedItem 
    vTcl:DefineAlias "$top.lab44" "Label1" vTcl:WidgetProc "Toplevel1" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.scr45 \
        -in $top -x 0 -relx 0.133 -y 0 -rely 0.289 -width 0 -relwidth 0.26 \
        -height 0 -relheight 0.507 -anchor nw -bordermode ignore 
    place $top.but46 \
        -in $top -x 0 -relx 0.783 -y 0 -rely 0.044 -width 91 -relwidth 0 \
        -height 31 -relheight 0 -anchor nw -bordermode ignore 
    place $top.but47 \
        -in $top -x 0 -relx 0.45 -y 0 -rely 0.467 -width 151 -relwidth 0 \
        -height 31 -relheight 0 -anchor nw -bordermode ignore 
    place $top.but48 \
        -in $top -x 0 -relx 0.45 -y 0 -rely 0.356 -width 151 -relwidth 0 \
        -height 31 -relheight 0 -anchor nw -bordermode ignore 
    place $top.lab44 \
        -in $top -x 0 -relx 0.133 -y 0 -rely 0.178 -width 0 -relwidth 0.598 \
        -height 0 -relheight 0.091 -anchor nw -bordermode ignore 
    } ;# end vTcl:withBusyCursor 

    vTcl:FireEvent $base <<Ready>>
}

set btop ""
if {$vTcl(borrow)} {
    set btop .bor[expr int([expr rand() * 100])]
    while {[lsearch $btop $vTcl(tops)] != -1} {
        set btop .bor[expr int([expr rand() * 100])]
    }
}
set vTcl(btop) $btop
Window show .
Window show .top44 $btop
if {$vTcl(borrow)} {
    $btop configure -background plum
}
