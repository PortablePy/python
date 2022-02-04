#############################################################################
# Generated by PAGE version 4.18b
#  in conjunction with Tcl version 8.6
#  Oct 03, 2018 10:46:26 AM PDT  platform: Linux
set vTcl(timestamp) ""


if {!$vTcl(borrow)} {

vTcl:font:add_GUI_font font10 \
"-family {DejaVu Sans} -size 14 -weight normal -slant roman -underline 0 -overstrike 0"
vTcl:font:add_GUI_font font9 \
"-family {DejaVu Sans Mono} -size 14 -weight normal -slant roman -underline 0 -overstrike 0"
set vTcl(actual_gui_bg) #d9d9d9
set vTcl(actual_gui_fg) #000000
set vTcl(actual_gui_menu_bg) #d9d9d9
set vTcl(actual_gui_menu_fg) #000000
set vTcl(complement_color) #b2c9f4
set vTcl(analog_color_p) #eaf4b2
set vTcl(analog_color_m) #f4bcb2
set vTcl(active_fg) #111111
set vTcl(actual_gui_menu_active_bg)  #f4bcb2
set vTcl(active_menu_fg) #000000
}

#############################################################################
#################################
#LIBRARY PROCEDURES
#


if {[info exists vTcl(sourcing)]} {

proc vTcl:project:info {} {
    set base .top32
    global vTcl
    set base $vTcl(btop)
    if {$base == ""} {
        set base .top32
    }
    namespace eval ::widgets::$base {
        set dflt,origin 0
        set runvisible 1
    }
    namespace eval ::widgets_bindings {
        set tagslist _TopLevel
    }
    namespace eval ::vTcl::modules::main {
        set procs {
        }
        set compounds {
        }
        set projectType single
    }
}
}

#################################
# GENERATED GUI PROCEDURES
#

proc vTclWindow.top32 {base} {
    if {$base == ""} {
        set base .top32
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    set top $base
    ###################
    # CREATING WIDGETS
    ###################
    vTcl::widgets::core::toplevel::createCmd $top -class Toplevel \
        -menu "$top.m32" -background {#d9d9d9} -highlightbackground wheat \
        -highlightcolor black 
    wm focusmodel $top passive
    wm geometry $top 609x642+617+155
    update
    # set in toplevel.wgt.
    global vTcl
    global img_list
    set vTcl(save,dflt,origin) 0
    wm maxsize $top 1905 1170
    wm minsize $top 1 1
    wm overrideredirect $top 0
    wm resizable $top 1 1
    wm deiconify $top
    wm title $top "Vrex for Python"
    vTcl:DefineAlias "$top" "Vrex" vTcl:Toplevel:WidgetProc "" 1
    ttk::style configure TPanedwindow -background #d9d9d9
    ttk::style configure TPanedwindow.Label -background #d9d9d9
    ttk::style configure TPanedwindow.Label -foreground #000000
    ttk::style configure TPanedwindow.Label -font font9
    ttk::panedwindow $top.tPa33 \
        -width 585 -height 530 
    vTcl:DefineAlias "$top.tPa33" "TPanedwindow1" vTcl:WidgetProc "Vrex" 1
    ttk::style configure TLabelframe.Label -background #d9d9d9
    ttk::style configure TLabelframe.Label -foreground #000000
    ttk::style configure TLabelframe.Label -font font9
    ttk::style configure TLabelframe -background #d9d9d9
    ttk::labelframe $top.tPa33.f1 \
        -text {Regular Expression} -height 85 
    vTcl:DefineAlias "$top.tPa33.f1" "TPanedwindow1_f1" vTcl:WidgetProc "Vrex" 1
    set site_4_0 $top.tPa33.f1
    vTcl::widgets::ttk::scrolledtext::CreateCmd $site_4_0.tSc35 \
        -background {#f5deb3} -height 75 -highlightbackground {#f5deb3} \
        -highlightcolor black -width 125 
    vTcl:DefineAlias "$site_4_0.tSc35" "Expression" vTcl:WidgetProc "Vrex" 1

    $site_4_0.tSc35.01 configure -background white \
        -font font4 \
        -foreground black \
        -height 3 \
        -highlightbackground wheat \
        -highlightcolor black \
        -insertbackground black \
        -insertborderwidth 3 \
        -selectbackground #c4c4c4 \
        -selectforeground black \
        -width 10 \
        -wrap none
    place $site_4_0.tSc35 \
        -in $site_4_0 -x 10 -y 30 -width 561 -relwidth 0 -height 46 \
        -relheight 0 -anchor nw -bordermode ignore 
    grid columnconf $site_4_0.tSc35 0 -weight 1
    grid rowconf $site_4_0.tSc35 0 -weight 1
    $top.tPa33 add $top.tPa33.f1 
        
    ttk::style configure TLabelframe.Label -background #d9d9d9
    ttk::style configure TLabelframe.Label -foreground #000000
    ttk::style configure TLabelframe.Label -font font9
    ttk::style configure TLabelframe -background #d9d9d9
    ttk::labelframe $top.tPa33.f2 \
        -text Sample -height 91.0 
    vTcl:DefineAlias "$top.tPa33.f2" "TPanedwindow1_f2" vTcl:WidgetProc "Vrex" 1
    set site_4_1 $top.tPa33.f2
    vTcl::widgets::ttk::scrolledtext::CreateCmd $site_4_1.tSc34 \
        -background {#f5deb3} -height 75 -highlightbackground {#f5deb3} \
        -highlightcolor black -width 125 
    vTcl:DefineAlias "$site_4_1.tSc34" "Sample" vTcl:WidgetProc "Vrex" 1
    bind $site_4_1.tSc34 <Button-1> {
        sync_matches
    }

    $site_4_1.tSc34.01 configure -background white \
        -font font4 \
        -foreground black \
        -height 41 \
        -highlightcolor black \
        -insertbackground black \
        -insertborderwidth 3 \
        -selectbackground #c4c4c4 \
        -selectforeground black \
        -width 10 \
        -wrap none
    place $site_4_1.tSc34 \
        -in $site_4_1 -x 10 -y 30 -width 561 -relwidth 0 -height 50 \
        -relheight 0 -anchor nw -bordermode ignore 
    grid columnconf $site_4_1.tSc34 0 -weight 1
    grid rowconf $site_4_1.tSc34 0 -weight 1
    $top.tPa33 add $top.tPa33.f2 
        
    ttk::style configure TLabelframe.Label -background #d9d9d9
    ttk::style configure TLabelframe.Label -foreground #000000
    ttk::style configure TLabelframe.Label -font font9
    ttk::style configure TLabelframe -background #d9d9d9
    ttk::labelframe $top.tPa33.f3 \
        -text Matches -height 354 
    vTcl:DefineAlias "$top.tPa33.f3" "TPanedwindow1_f3" vTcl:WidgetProc "Vrex" 1
    set site_4_2 $top.tPa33.f3
    vTcl::widgets::ttk::scrolledtext::CreateCmd $site_4_2.scr32 \
        -background {#f5deb3} -height 75 -highlightbackground {#f5deb3} \
        -highlightcolor black -width 125 
    vTcl:DefineAlias "$site_4_2.scr32" "Matches" vTcl:WidgetProc "Vrex" 1
    bind $site_4_2.scr32 <Button-1> {
        sync_sample
    }

    $site_4_2.scr32.01 configure -background white \
        -font font4 \
        -foreground black \
        -height 103 \
        -highlightcolor black \
        -insertbackground black \
        -insertborderwidth 3 \
        -selectbackground #c4c4c4 \
        -selectforeground black \
        -width 10 \
        -wrap none
    place $site_4_2.scr32 \
        -in $site_4_2 -x 10 -y 30 -width 561 -relwidth 0 -height 305 \
        -relheight 0 -anchor nw -bordermode ignore 
    grid columnconf $site_4_2.scr32 0 -weight 1
    grid rowconf $site_4_2.scr32 0 -weight 1
    $top.tPa33 add $top.tPa33.f3 
        
    set site_3_0 $top.m32
    menu $site_3_0 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -font TkMenuFont -foreground black -tearoff 1 
    $site_3_0 add cascade \
        -menu "$site_3_0.men33" -background {#d9d9d9} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label File 
    menu $site_3_0.men33 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -font TkMenuFont -foreground black -tearoff 0 
    $site_3_0.men33 add command \
        -background {#d9d9d9} -command {#load_regular_expression} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label {Load regular expression} 
    $site_3_0.men33 add command \
        -background {#d9d9d9} -command {#save_regular_expression} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label {Save regular expression} 
    $site_3_0.men33 add separator \
        -background {#d9d9d9} 
    $site_3_0.men33 add command \
        -background {#d9d9d9} -command {#load_sample} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label {Load sample} 
    $site_3_0.men33 add command \
        -background {#d9d9d9} -command {#save_sample} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label {Save sample} 
    $site_3_0.men33 add separator \
        -background {#d9d9d9} 
    $site_3_0.men33 add command \
        -background {#d9d9d9} -command {#quit} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label Quit 
    $site_3_0 add command \
        -background {#d9d9d9} -command {#help} \
        -font {-family {Nimbus Sans L} -size 14 -weight normal -slant roman -underline 0 -overstrike 0} \
        -label Help 
    button $top.but34 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -command quit -disabledforeground {#b8a786} \
        -foreground black -highlightbackground wheat -highlightcolor black \
        -text Quit 
    vTcl:DefineAlias "$top.but34" "Quit" vTcl:WidgetProc "Vrex" 1
    button $top.but32 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -command lambda:display(0) \
        -disabledforeground {#b8a786} -foreground black \
        -highlightbackground wheat -highlightcolor black -text Match 
    vTcl:DefineAlias "$top.but32" "Match" vTcl:WidgetProc "Vrex" 1
    button $top.but33 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(1) \
        -disabledforeground {#b8a786} -foreground blue \
        -highlightbackground wheat -highlightcolor black -text 1 
    vTcl:DefineAlias "$top.but33" "Button1" vTcl:WidgetProc "Vrex" 1
    button $top.but35 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(2) \
        -disabledforeground {#b8a786} -foreground darkgreen \
        -highlightbackground wheat -highlightcolor black -text 2 
    vTcl:DefineAlias "$top.but35" "Button2" vTcl:WidgetProc "Vrex" 1
    button $top.but36 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(3) \
        -disabledforeground {#b8a786} -foreground magenta \
        -highlightbackground wheat -highlightcolor black -text 3 
    vTcl:DefineAlias "$top.but36" "Button3" vTcl:WidgetProc "Vrex" 1
    button $top.but37 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(4) \
        -disabledforeground {#b8a786} -foreground sienna \
        -highlightbackground wheat -highlightcolor black -text 4 
    vTcl:DefineAlias "$top.but37" "Button4" vTcl:WidgetProc "Vrex" 1
    button $top.but38 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(5) \
        -disabledforeground {#b8a786} -foreground purple \
        -highlightbackground wheat -highlightcolor black -text 5 
    vTcl:DefineAlias "$top.but38" "Button5" vTcl:WidgetProc "Vrex" 1
    button $top.but39 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(6) \
        -disabledforeground {#b8a786} -foreground firebrick \
        -highlightbackground wheat -highlightcolor black -text 6 
    vTcl:DefineAlias "$top.but39" "Button6" vTcl:WidgetProc "Vrex" 1
    button $top.but40 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(7) \
        -disabledforeground {#b8a786} -foreground deeppink \
        -highlightbackground wheat -highlightcolor black -text 7 
    vTcl:DefineAlias "$top.but40" "Button7" vTcl:WidgetProc "Vrex" 1
    button $top.but41 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(8) \
        -disabledforeground {#b8a786} -foreground green4 \
        -highlightbackground wheat -highlightcolor black -text 8 
    vTcl:DefineAlias "$top.but41" "Button8" vTcl:WidgetProc "Vrex" 1
    button $top.but42 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -command lambda:display(9) \
        -disabledforeground {#b8a786} -foreground deepskyblue1 \
        -highlightbackground wheat -highlightcolor black -text 9 
    vTcl:DefineAlias "$top.but42" "Button9" vTcl:WidgetProc "Vrex" 1
    button $top.but43 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -command go -disabledforeground {#b8a786} \
        -foreground black -highlightbackground wheat -highlightcolor black \
        -text Go 
    vTcl:DefineAlias "$top.but43" "Go" vTcl:WidgetProc "Vrex" 1
    ttk::style configure TSizegrip -background #d9d9d9
    vTcl::widgets::ttk::sizegrip::CreateCmd $top.tSi34 \
        -cursor bottom_right_corner 
    vTcl:DefineAlias "$top.tSi34" "TSizegrip1" vTcl:WidgetProc "Vrex" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.tPa33 \
        -in $top -x 11 -y 10 -width 585 -relwidth 0 -height 530 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.but34 \
        -in $top -x 547 -y 550 -width 51 -height 26 -anchor nw \
        -bordermode ignore 
    place $top.but32 \
        -in $top -x 79 -y 550 -width 63 -height 26 -anchor nw \
        -bordermode ignore 
    place $top.but33 \
        -in $top -x 170 -y 550 -anchor nw -bordermode ignore 
    place $top.but35 \
        -in $top -x 210 -y 550 -anchor nw -bordermode ignore 
    place $top.but36 \
        -in $top -x 250 -y 550 -anchor nw -bordermode ignore 
    place $top.but37 \
        -in $top -x 290 -y 550 -anchor nw -bordermode ignore 
    place $top.but38 \
        -in $top -x 330 -y 550 -anchor nw -bordermode ignore 
    place $top.but39 \
        -in $top -x 370 -y 550 -anchor nw -bordermode ignore 
    place $top.but40 \
        -in $top -x 410 -y 550 -anchor nw -bordermode ignore 
    place $top.but41 \
        -in $top -x 450 -y 550 -anchor nw -bordermode ignore 
    place $top.but42 \
        -in $top -x 490 -y 550 -anchor nw -bordermode ignore 
    place $top.but43 \
        -in $top -x 14 -y 550 -width 42 -height 26 -anchor nw \
        -bordermode ignore 
    place $top.tSi34 \
        -in $top -x 0 -relx 1 -y 0 -rely 1 -anchor se -bordermode inside 

    vTcl:FireEvent $base <<Ready>>
}

#############################################################################
## Binding tag:  _TopLevel

bind "_TopLevel" <<Create>> {
    if {![info exists _topcount]} {set _topcount 0}; incr _topcount
}
bind "_TopLevel" <<DeleteWindow>> {
    if {[set ::%W::_modal]} {
                vTcl:Toplevel:WidgetProc %W endmodal
            } else {
                destroy %W; if {$_topcount == 0} {exit}
            }
}
bind "_TopLevel" <Destroy> {
    if {[winfo toplevel %W] == "%W"} {incr _topcount -1}
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
Window show .top32 $btop
if {$vTcl(borrow)} {
    $btop configure -background plum
}

