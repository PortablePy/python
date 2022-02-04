#############################################################################
# Generated by PAGE version 6.2
#  in conjunction with Tcl version 8.6
#  May 14, 2021 09:48:53 AM PDT  platform: Linux
set vTcl(timestamp) ""
if {![info exists vTcl(borrow)]} {
    tk_messageBox -title Error -message  "You must open project files from within PAGE."
    exit}


set image_list { \
    openfold_gif "./openfold.gif" \
    stop_gif "./stop.gif" \
}
vTcl:create_project_images $image_list   ;# In image.tcl


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
set desc "-family {DejaVu Sans} -size 12"
set vTcl(actual_gui_font_tooltip_desc) $desc
set vTcl(actual_gui_font_tooltip_name) [font create {*}$desc]
set vTcl(actual_gui_font_treeview_desc)  TkDefaultFont
set vTcl(actual_gui_font_treeview_name)  TkDefaultFont
set vTcl(actual_gui_bg) wheat
set vTcl(actual_gui_fg) #000000
set vTcl(actual_gui_analog) #f4bcb2
set vTcl(actual_gui_menu_analog) #ececec
set vTcl(actual_gui_menu_bg) wheat
set vTcl(actual_gui_menu_fg) #000000
set vTcl(complement_color) #b2c9f4
set vTcl(analog_color_p) #eaf4b2
set vTcl(analog_color_m) #f4bcb2
set vTcl(active_fg) #111111
set vTcl(actual_gui_menu_active_bg)  #f4bcb2
set vTcl(actual_gui_menu_active_fg)  #000000
set vTcl(pr,autoalias) 1
set vTcl(pr,relative_placement) 0
set vTcl(mode) Relative
}




proc vTclWindow.top32 {base} {
    global vTcl
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
        -menu "$top.m33" -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    wm focusmodel $top passive
    wm geometry $top 644x420+632+293
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
    wm title $top "Menu Example"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    set vTcl(real_top) {}
    vTcl:withBusyCursor {
    ttk::style configure Menu -background $vTcl(actual_gui_bg)
    ttk::style configure Menu -foreground $vTcl(actual_gui_fg)
    ttk::style configure Menu -font "$vTcl(actual_gui_font_dft_desc)"
    menu $top.m33 \
        -activebackground #f9f9f9 -activeforeground black -background #ff0000 \
        -font {-family Purisa -size 12 -weight normal -slant roman -underline 0 -overstrike 0} \
        -foreground black -tearoff 0 
    $top.m33 add cascade \
        -menu "$top.m33.men34" -background #00ffff -compound left \
        -font {-family Purisa -size 12 -weight normal -slant roman -underline 0 -overstrike 0} \
        -foreground $vTcl(actual_gui_menu_fg) -label File 
    set site_3_0 $top.m33
    menu $site_3_0.men34 \
        -activebackground #f9f9f9 -activeforeground black -background #ffff00 \
        -font TkMenuFont -foreground black -tearoff 0 
    $site_3_0.men34 add command \
        -command {#save} -foreground $vTcl(actual_gui_menu_fg) -label Save 
    $site_3_0.men34 add separator \
        
    $site_3_0.men34 add command \
        -command {#quit} -compound top -image stop_gif -label Quit 
    $top.m33 add cascade \
        -menu "$top.m33.men32" -background #990000 -compound left \
        -font {-family {Purisa} -size 12} -foreground #ffff00 -label Edit 
    set site_3_0 $top.m33
    menu $site_3_0.men32 \
        -activebackground #f9f9f9 -activeforeground black -background #ff0000 \
        -font TkMenuFont -foreground white -tearoff 0 
    $site_3_0.men32 add command \
        -command {#cut} -label Cut 
    $site_3_0.men32 add command \
        -command {#copy} -label Copy 
    $site_3_0.men32 add separator \
        
    $site_3_0.men32 add command \
        -command {#paste} -label Paste 
    $site_3_0.men32 add cascade \
        -menu "$site_3_0.men32.men32" -command {{}} -label Other 
    set site_4_0 $site_3_0.men32
    menu $site_4_0.men32 \
        -activebackground #f9f9f9 -activeforeground black -background #ffff00 \
        -font TkMenuFont -foreground black -tearoff 0 
    $site_4_0.men32 add command \
        -command {#post} -label Post 
    $site_4_0.men32 add command \
        -command {#sync} -label Sync 
    $site_4_0.men32 add cascade \
        -menu "$site_4_0.men32.men32" -command {{}} -label Still 
    set site_5_0 $site_4_0.men32
    menu $site_5_0.men32 \
        -activebackground #f9f9f9 -activeforeground black -background plum \
        -font TkMenuFont -foreground black -tearoff 0 
    $site_5_0.men32 add command \
        -command {#yes} -label Yes 
    $site_5_0.men32 add command \
        -command {#no} -label No 
    $site_5_0.men32 add checkbutton \
        -variable IRS -command {#} -label IRS 
    $site_5_0.men32 add checkbutton \
        -variable Charity -background plum -command {#} -label Charity 
    $site_5_0.men32 add cascade \
        -menu "$site_5_0.men32.men32" -command {{}} -label More 
    set site_6_0 $site_5_0.men32
    menu $site_6_0.men32 \
        -activebackground #f9f9f9 -activeforeground black -background #ff0000 \
        -font TkMenuFont -foreground black -tearoff 0 
    $site_6_0.men32 add radiobutton \
        -value 1 -activebackground #d9d9d9 -activeforeground #000000 \
        -background #ffff00 -command {#radio_a} -font TkMenuFont \
        -foreground $vTcl(actual_gui_menu_fg) -label Radio-A 
    $site_6_0.men32 add radiobutton \
        -value 2 -activebackground #d9d9d9 -activeforeground #000000 \
        -background #00ff00 -command {#radio_b} -font TkMenuFont \
        -foreground $vTcl(actual_gui_menu_fg) -label Radio-B 
    $site_6_0.men32 add checkbutton \
        -selectcolor #990000 -variable Check_1 -activebackground #d9d9d9 \
        -activeforeground #000000 -background #ff0000 -command {#check1} \
        -compound left -font TkMenuFont -foreground $vTcl(actual_gui_menu_fg) \
        -image openfold_gif -label {Check 1} 
    $site_6_0.men32 add checkbutton \
        -variable Check_2 -activebackground #d9d9d9 -activeforeground #000000 \
        -background #ff0000 -command {#check2} \
        -foreground $vTcl(actual_gui_menu_fg) -label {Check 2} 
    ###################
    # SETTING GEOMETRY
    ###################
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
Window show .top32 $btop
if {$vTcl(borrow)} {
    $btop configure -background plum
}

