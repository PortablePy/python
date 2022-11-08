##############################################################################
# $Id: template.tcl,
#
# propmgr.tcl - procedures used by the widget properties manager
#
# Copyright (C) 2019 Donald Rozenberg
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

##############################################################################


# This handles some of the processing needed for the template function.
    global vTcl

proc vTcl:transform_option {target option value} {
    # First check to see if the option needs to be processed. If not
    # bail.
    global vTcl
    if {$target == "Menu"} {
        set class "Menu"
    } else {
        set class [vTcl:get_class $target]
    }
    set vTcl(option_test,-background) $vTcl(actual_gui_bg)
    set vTcl(option_test,-foreground) $vTcl(actual_gui_fg)
    set vTcl(option_test,-activebackground) $vTcl(analog_color_m)
    set vTcl(option_test,-activeforeground) $vTcl(analog_color_p)
    set vTcl(option_test,-highlightbackground) $vTcl(actual_gui_bg)

    #set vTcl(option_test,-disabledforeground)
    #set vTcl(option_test,-highlightcolor)

    set vTcl(option_return,-background) vTcl(actual_gui_bg)
    set vTcl(option_return,-foreground) vTcl(actual_gui_fg)
    set vTcl(option_return,-activebackground) vTcl(analog_color_m)
    # set vTcl(option_return,-activeforeground) vTcl(analog_color_p)
    set vTcl(option_return,-activeforeground) vTcl(actual_gui_fg)
    set vTcl(option_return,-highlightbackground) vTcl(actual_gui_bg)

    set color_options [list -background -foreground -activebackground \
                           -activeforeground -highlightbackground]
    if {[lsearch $color_options $option] > -1} {
        # It's a color option
        switch $option {
            -background {
                # if {$target == "" || $class == "Menu"} { }
                if {$class == "Menu"} {
                    # if {$value == $vTcl(pr,menubgcolor)} {
                    #     return vTcl(pr,menubgcolor)}
                    if {$value == $vTcl(actual_gui_menu_bg)} {
                        return vTcl(actual_gui_menu_bg)}
                } else {
                    if {$value == $vTcl(option_test,$option)} {
                        return $vTcl(option_return,$option)}
                }
            }
            -foreground {
                if {$target == "" || $class == "Menu"} {
                    if {$value == $vTcl(actual_gui_menu_fg)} {
                        return vTcl(actual_gui_menu_fg)}
                } else {
                    if {$value == $vTcl(option_test,$option)} {
                        return $vTcl(option_return,$option)}
                }
            }
            -activebackground {
                if {$target == "" || $class == "Menu"} {
                    if {$value == $vTcl(actual_gui_menu_analog)} {
                        return vTcl(actual_gui_menu_analog)}
                } else {
                    if {$value == $vTcl(option_test,$option)} {
                        return $vTcl(option_return,$option)}
                }
            }

            default {
                if {$value == $vTcl(option_test,$option)} {
                    return $vTcl(option_return,$option)}
            }
        }
    }
            # -activeforeground {
            #     if {$target == "" || $class == "Menu"} {
            #         if {$value == $vTcl(actual_gui_menu_analog)} {
            #             return vTcl(actual_gui_menu_analog)}
            #     } else {
            #         if {$value == $vTcl(option_test,$option)} {
            #             return $vTcl(option_return,$option)}
            #     }
            # }

    if {$target == "" || $class == "Menu"} {
        # Assuming that $target = "" means a menu.
        if {$option == "-background"} {
            if {$value == $vTcl(pr,menubgcolor)} {
                return vTcl(pr,menubgcolor)}
        }
        if {$option == "-foreground"} {
            if {$value == $vTcl(pr,menufgcolor)} {
                return vTcl(pr,menufgcolor)}
        }
    }
#     if {[lsearch $color_options $option] > -1} {
#         # It's a color option
# dmsg color   test value =     $vTcl(option_test,$option)
#         if {$value == $vTcl(option_test,$option)} {
# dmsg color return
#             return $vTcl(option_return,$option)
#         }
    #     }
    if {$option == "-font"} {
        # if {[string first "Tk" $value] == 0} {}
        if {$value in $vTcl(standard_fonts)} {
            # One of the TK built in fonts.
            return $value
        }
        if {[string match font* $value]} {
            # set value $vTcl(fonts,$value,font_descr)
            set value [font configure $value]
        }
        #set value [vTcl:condense_font_description $value]
        #set value [vTcl:condense_font_description $value]

        switch $class {
            Menubutton -
            Menu {
                if {[vTcl:font_compare $value \
                         $vTcl(actual_gui_font_menu_desc)]} {
                    return vTcl(actual_gui_font_menu_desc)}
            }
            Label -
            Checkbutton -
            Labelframe -
            Radiobutton -
            Scale -
            Button {
                if {[vTcl:font_compare $value $vTcl(actual_gui_font_dft_desc)]} {
                    return vTcl(actual_gui_font_dft_desc)}
            }
            Listbox -
            Entry {
              if {[vTcl:font_compare $value $vTcl(actual_gui_font_fixed_desc)]} {
                  return vTcl(actual_gui_font_fixed_desc)}
            }
        }
    }
#     ##################################
#     ;# NEEDS WORK menubutton
#     if {$class eq "Menubutton" && $option eq "-menu"} {
#         dmsg Bingo
# dpr vTcl(basemame,$target)
#         #"$top.men47.m"
#         set vv [string trim $value "\""]
#         set sp [split $vv "."]
# dpr target vv
# dpr sp
#         #set value  "\$site_[llength $sp]_0.[lrange $sp end end]"
#         set value $vTcl(basemame,$target).[lrange $sp end end]
# dpr value
# dmsg ###############################
#     }
#     ##################################
    if {$value == ""} {set value \{\}}
    return $value
}

proc vTcl:font_compare {font_a font_b} {
    global vTcl
    set font_a [vTcl:condense_font_description $font_a]
    if {$font_a == $font_b} {
        set ret 1
    } else {
        set ret 0
    }
    return $ret
}
