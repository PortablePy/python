#############################################################################
# Generated by PAGE version 5.0.2c
#  in conjunction with Tcl version 8.6
#  Feb 21, 2020 04:02:20 AM CST  platform: Linux
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
    wm geometry $top 600x242+252+315
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
    wm title $top "I am Parent"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    set vTcl(real_top) {}
    vTcl:withBusyCursor {
    button $top.but44 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnExit \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -text Exit 
    vTcl:DefineAlias "$top.but44" "btnExit" vTcl:WidgetProc "Toplevel1" 1
    button $top.but45 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -command on_btnLaunch \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -text {Launch Child} 
    vTcl:DefineAlias "$top.but45" "btnLaunch" vTcl:WidgetProc "Toplevel1" 1
    frame $top.fra46 \
        -borderwidth 2 -relief groove -background $vTcl(actual_gui_bg) \
        -height 135 -highlightcolor black -width 585 
    vTcl:DefineAlias "$top.fra46" "Frame1" vTcl:WidgetProc "Toplevel1" 1
    set site_3_0 $top.fra46
    label $site_3_0.lab48 \
        -activebackground #f9f9f9 -activeforeground black -anchor e \
        -background $vTcl(actual_gui_bg) -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -text Status: \
        -width 76 
    vTcl:DefineAlias "$site_3_0.lab48" "Label2" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.lab49 \
        -activebackground #f9f9f9 -activeforeground black -anchor e \
        -background $vTcl(actual_gui_bg) -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black \
        -text Received: 
    vTcl:DefineAlias "$site_3_0.lab49" "Label3" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.lab50 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -borderwidth 2 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) -highlightcolor black -relief ridge \
        -text Label -textvariable DataReceived 
    vTcl:DefineAlias "$site_3_0.lab50" "Label4" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.lab43 \
        -activebackground #f9f9f9 -activeforeground black -background #ff0000 \
        -borderwidth 2 -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightcolor black -relief groove 
    vTcl:DefineAlias "$site_3_0.lab43" "Label5" vTcl:WidgetProc "Toplevel1" 1
    place $site_3_0.lab48 \
        -in $site_3_0 -x 40 -y 40 -width 76 -relwidth 0 -height 19 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.lab49 \
        -in $site_3_0 -x 40 -y 80 -width 76 -relwidth 0 -height 19 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.lab50 \
        -in $site_3_0 -x 120 -y 76 -width 216 -relwidth 0 -height 29 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_3_0.lab43 \
        -in $site_3_0 -x 124 -y 44 -width 15 -relwidth 0 -height 15 \
        -relheight 0 -anchor nw -bordermode ignore 
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.but44 \
        -in $top -x 480 -y 20 -width 99 -relwidth 0 -height 29 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.but45 \
        -in $top -x 40 -y 20 -width 149 -relwidth 0 -height 29 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.fra46 \
        -in $top -x 10 -y 100 -width 585 -relwidth 0 -height 135 -relheight 0 \
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

