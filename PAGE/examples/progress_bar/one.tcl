#############################################################################
# Generated by PAGE version 6.1g
#  in conjunction with Tcl version 8.6
#  Mar 09, 2021 11:55:26 PM PST  platform: Linux
set vTcl(timestamp) ""
if {![info exists vTcl(borrow)]} {
    tk_messageBox -title Error -message  "You must open project files from within PAGE."
    exit}


if {!$vTcl(borrow) && !$vTcl(template)} {

set desc "-family {DejaVu Sans Mono} -size 14"
set vTcl(actual_gui_font_dft_desc) $desc
set vTcl(actual_gui_font_dft_name) [font create {*}$desc]
set desc "-family {DejaVu Sans} -size 14"
set vTcl(actual_gui_font_text_desc) $desc
set vTcl(actual_gui_font_text_name) [font create {*}$desc]
set desc "-family {DejaVu Sans Mono} -size 14"
set vTcl(actual_gui_font_fixed_desc) $desc
set vTcl(actual_gui_font_fixed_name) [font create {*}$desc]
set desc "-family {DejaVu Sans} -size 12"
set vTcl(actual_gui_font_menu_desc) $desc
set vTcl(actual_gui_font_menu_name) [font create {*}$desc]
set vTcl(actual_gui_font_tooltip_desc)  TkTooltipFont
set vTcl(actual_gui_font_tooltip_name)  TkTooltipFont
set vTcl(actual_gui_font_treeview_desc)  TkDefaultFont
set vTcl(actual_gui_font_treeview_name)  TkDefaultFont
set vTcl(actual_gui_bg) wheat
set vTcl(actual_gui_fg) #000000
set vTcl(actual_gui_analog) #f4bcb2
set vTcl(actual_gui_menu_analog) #ececec
set vTcl(actual_gui_menu_bg) #d9d9d9
set vTcl(actual_gui_menu_fg) #000000
set vTcl(complement_color) #b2c9f4
set vTcl(analog_color_p) #eaf4b2
set vTcl(analog_color_m) #f4bcb2
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
        -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    wm focusmodel $top passive
    wm geometry $top 600x450+779+229
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
    ttk::style configure Button -background $vTcl(actual_gui_bg)
    ttk::style configure Button -foreground $vTcl(actual_gui_fg)
    ttk::style configure Button -font "$vTcl(actual_gui_font_dft_desc)"
    button $top.but45 \
        -activebackground $vTcl(analog_color_m) -activeforeground black \
        -background $vTcl(actual_gui_bg) -borderwidth 2 -command quit \
        -disabledforeground #b8a786 -font $vTcl(actual_gui_font_dft_desc) \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Quit 
    vTcl:DefineAlias "$top.but45" "Button1" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab46 \
        -activebackground #ffffcd -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #b8a786 \
        -font $vTcl(actual_gui_font_dft_desc) \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -justify left \
        -text {Example of Using a Progress bar.
Hit the Advance button below repeatedly.
Wait after progress bar fills until it 
dissapears.} 
    vTcl:DefineAlias "$top.lab46" "Label1" vTcl:WidgetProc "Toplevel1" 1
    button $top.but47 \
        -activebackground $vTcl(analog_color_m) -activeforeground black \
        -background $vTcl(actual_gui_bg) -borderwidth 2 -command advance \
        -disabledforeground #b8a786 -font $vTcl(actual_gui_font_dft_desc) \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Advance Progress Bar} 
    vTcl:DefineAlias "$top.but47" "Button2" vTcl:WidgetProc "Toplevel1" 1
    ttk::progressbar $top.tPr44 \
        -length 100 -variable prog_var 
    vTcl:DefineAlias "$top.tPr44" "TProgressbar1" vTcl:WidgetProc "Toplevel1" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.but45 \
        -in $top -x 0 -relx 0.42 -y 0 -rely 0.733 -width 96 -relwidth 0 \
        -height 39 -relheight 0 -anchor nw -bordermode ignore 
    place $top.lab46 \
        -in $top -x 0 -relx 0.1 -y 0 -rely 0.129 -width 0 -relwidth 0.823 \
        -height 0 -relheight 0.189 -anchor nw -bordermode ignore 
    place $top.but47 \
        -in $top -x 0 -relx 0.267 -y 0 -rely 0.513 -width 276 -relwidth 0 \
        -height 39 -relheight 0 -anchor nw -bordermode ignore 
    place $top.tPr44 \
        -in $top -x 0 -relx 0.3333 -y 0 -rely 0.378 -width 0 -relwidth 0.333 \
        -height 0 -relheight 0.042 -anchor nw -bordermode ignore 
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

