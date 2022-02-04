#############################################################################
# Generated by PAGE version 5.0.2c
#  in conjunction with Tcl version 8.6
#  Feb 21, 2020 04:08:14 AM CST  platform: Linux
set vTcl(timestamp) ""


if {!$vTcl(borrow) && !$vTcl(template)} {

set desc "-family {DejaVu Sans} -size 9"
set vTcl(actual_gui_font_text_desc) $desc
set vTcl(actual_gui_font_text_name) [font create {*}$desc]
set desc "-family {DejaVu Sans Mono} -size 9"
set vTcl(actual_gui_font_fixed_desc) $desc
set vTcl(actual_gui_font_fixed_name) [font create {*}$desc]
set desc "-family {DejaVu Sans} -size 9"
set vTcl(actual_gui_font_menu_desc) $desc
set vTcl(actual_gui_font_menu_name) [font create {*}$desc]
set desc "-family {DejaVu Sans} -size 9"
set vTcl(actual_gui_font_tooltip_desc) $desc
set vTcl(actual_gui_font_tooltip_name) [font create {*}$desc]
set desc "-family {Liberation Sans} -size 9 -weight bold"
set vTcl(actual_gui_font_treeview_desc) $desc
set vTcl(actual_gui_font_treeview_name) [font create {*}$desc]
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
set vTcl(pr,menufgcolor) #000000
set vTcl(pr,menubgcolor) #d9d9d9
set vTcl(pr,menuanalogcolor) #ececec
set vTcl(pr,treehighlight) firebrick
set vTcl(pr,autoalias) 1
set vTcl(pr,relative_placement) 0
set vTcl(mode) Absolute
}




proc vTclWindow.top43 {base} {
    global vTcl
    if {$base == ""} {
        set base .top43
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
    wm geometry $top 278x365+1181+365
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
    wm title $top "I am the child"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    set vTcl(real_top) {}
    vTcl:withBusyCursor {
    ttk::style configure Button -background $vTcl(actual_gui_bg)
    ttk::style configure Button -foreground $vTcl(actual_gui_fg)
    ttk::style configure Button -font "$vTcl(actual_gui_font_dft_desc)"
    button $top.but44 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnExit \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -text Exit 
    vTcl:DefineAlias "$top.but44" "btnExit" vTcl:WidgetProc "Toplevel1" 1
    frame $top.fra45 \
        -borderwidth 2 -relief groove -background $vTcl(actual_gui_bg) \
        -height 215 -highlightcolor black -width 245 
    vTcl:DefineAlias "$top.fra45" "Frame1" vTcl:WidgetProc "Toplevel1" 1
    set site_3_0 $top.fra45
    button $site_3_0.but46 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 7 
    vTcl:DefineAlias "$site_3_0.but46" "btn7" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but47 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 8 
    vTcl:DefineAlias "$site_3_0.but47" "btn8" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but48 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 9 
    vTcl:DefineAlias "$site_3_0.but48" "btn9" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but49 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 4 
    vTcl:DefineAlias "$site_3_0.but49" "btn4" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but50 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 5 
    vTcl:DefineAlias "$site_3_0.but50" "btn5" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but51 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 6 
    vTcl:DefineAlias "$site_3_0.but51" "btn6" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but52 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 1 
    vTcl:DefineAlias "$site_3_0.but52" "btn1" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but53 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 2 
    vTcl:DefineAlias "$site_3_0.but53" "btn2" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but54 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 3 
    vTcl:DefineAlias "$site_3_0.but54" "btn3" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but55 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text 0 
    vTcl:DefineAlias "$site_3_0.but55" "btn0" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but56 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text . 
    vTcl:DefineAlias "$site_3_0.but56" "btnDot" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but57 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnEnter \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text Enter 
    vTcl:DefineAlias "$site_3_0.but57" "btnEnter" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but43 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnClear \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text Clear 
    vTcl:DefineAlias "$site_3_0.but43" "btnClear" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but44 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnBackspace \
        -font {-family {DejaVu Sans} -size 12 -weight bold -slant italic} \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text Bksp 
    vTcl:DefineAlias "$site_3_0.but44" "btnBackSpace" vTcl:WidgetProc "Toplevel1" 1
    place $site_3_0.but46 \
        -in $site_3_0 -x 10 -y 10 -width 45 -relwidth 0 -height 45 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.but47 \
        -in $site_3_0 -x 60 -y 10 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but48 \
        -in $site_3_0 -x 110 -y 10 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but49 \
        -in $site_3_0 -x 10 -y 60 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but50 \
        -in $site_3_0 -x 60 -y 60 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but51 \
        -in $site_3_0 -x 110 -y 60 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but52 \
        -in $site_3_0 -x 10 -y 110 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but53 \
        -in $site_3_0 -x 60 -y 110 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but54 \
        -in $site_3_0 -x 110 -y 110 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but55 \
        -in $site_3_0 -x 10 -y 160 -width 95 -relwidth 0 -height 45 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.but56 \
        -in $site_3_0 -x 110 -y 160 -width 45 -height 45 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but57 \
        -in $site_3_0 -x 160 -y 110 -width 79 -relwidth 0 -height 94 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.but43 \
        -in $site_3_0 -x 160 -y 10 -width 79 -relwidth 0 -height 45 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.but44 \
        -in $site_3_0 -x 160 -y 60 -width 79 -relwidth 0 -height 45 \
        -relheight 0 -anchor nw -bordermode ignore 
    label $top.lab58 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -borderwidth 2 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -relief ridge \
        -text Label -textvariable DisplayLabel 
    vTcl:DefineAlias "$top.lab58" "Label1" vTcl:WidgetProc "Toplevel1" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.but44 \
        -in $top -x 90 -y 20 -width 109 -relwidth 0 -height 29 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.fra45 \
        -in $top -x 20 -y 137 -width 245 -relwidth 0 -height 215 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.lab58 \
        -in $top -x 18 -y 89 -width 246 -relwidth 0 -height 49 -relheight 0 \
        -anchor nw -bordermode ignore 
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
Window show .top43 $btop
if {$vTcl(borrow)} {
    $btop configure -background plum
}

