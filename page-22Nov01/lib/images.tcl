##############################################################################
#
# image.tcl  - procedures to handle a database of stock images and user images
#
# Copyright (C) 2000 Christian Gavin
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
#
# @@change by Christian Gavin March 2000
# new file to display an image manager and an image selector for properties
# @@end_change

# vTcl:image:new_image_file
# vTcl:image:get_image
# vTcl:image:generate_image_user
# vTcl:image:translate
# vTcl:image:create_new_image
# vTcl:image:new_image_file
# vTcl:image:dump_create_image
# vTcl:image:dump_create_image_header
# vTcl:prompt_user_image2

# bitmap types accepted by PAGE

set vTcl(image,filetypes) {
    {{Image Files}   {.gif .png .bmp}       }
    {{All Files}          *                 }
    {{Portable Pixel Map} {.ppm}            }
    {{X Windows Bitmap}   {.xbm}            }
}


if {$vTcl(Img_found)} {
    set vTcl(image,filetypes) {
        {{Image Files}   {.gif .png .bmp .jpg}  }
        {{All Files}          *                 }
        {{Portable Pixel Map} {.ppm}            }
        {{X Windows Bitmap}   {.xbm}            }
    }
}

# returns "photo" if a GIF or "bitmap" if a xbm

proc vTcl:image:get_creation_type {filename} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.
    switch [string tolower [file extension $filename]] {
        .ppm -
        .jpg -
        .bmp -
        .png -
        .gif    {return photo}
        .xbm    {return bitmap}
        default {return photo}
    }
}

proc {vTcl:image:create_new_image} { filename
                                    {description {no description}}
                                    {type {}}
                                    {data {}}
                                    {name {}}} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    ## In this function, type means user or stock.

    # Creates an image if one does not exist and adds vTcl entry cross
    # referencing image properties with the created image object.
    global vTcl
    if {!$vTcl(Img_found)} {
        # Test for supported file types.
        set file_ext [file extension $filename]
        set file_types [list .png .gif .ppm]
        if {[lsearch -exact $file_types $file_ext] == -1} {
            set msg "Image format must be PNG, GIF, or PPM"
            ::vTcl::MessageBox -icon error -message $msg \
                -title "Error!" -type ok
            return
        }
    }
    # Does the image already exist?
    if {[info exists ::vTcl(images,files)]} {
        if {[lsearch -exact $::vTcl(images,files) $filename] > -1} { return }
    }
    if {![info exists ::vTcl(sourcing)] && [string length $data] > 0} {
        set object [image create \
            [vTcl:image:get_creation_type $filename] \
            -data $data]
    } else {
        # Wait a minute... Does the file actually exist?
        if {! [file exists $filename] } {
            # Try current directory
            set script [file dirname [info script]]
            set filename [file join $script [file tail $filename] ]
        }
        if {![file exists $filename]} {
            set description "file not found!"
            ## will add 'broken image' again when img is fixed, for
            ## now create empty
            set object [image create photo -width 1 -height 1]
        } else {
            if {$type == "user"} {
                if {$name == ""} {
                    set name [vTcl:get_new_name $filename]
                }
                set object [image create \
                      [vTcl:image:get_creation_type $filename] \
                       $name       -file $filename]

            } else {
                set object [image create \
                [vTcl:image:get_creation_type $filename] \
                                -file $filename]
            }
        }

    }
    set reference [vTcl:rename $filename]
    set ::vTcl(images,$reference,image)       $object
    set ::vTcl(images,$reference,description) $description
    set ::vTcl(images,$reference,type)        $type
    set ::vTcl(images,filename,$object)       $filename

    lappend ::vTcl(images,files) $filename
    lappend ::vTcl(images,$type) $object
    set ::vTcl(imagefile,$object) $filename   ;# Rozen

    # return image name in case caller might want it
    return $object
}

proc vTcl:get_new_name {filename} {
    global vTcl
    set t [file tail $filename]
    set name [vTcl:rename $t]
    return $name
}

proc vTcl:image:get_reference {image} {
    return $::vTcl(images,filename,$image)
}

proc {vTcl:image:get_description} {filename} {
    set reference [vTcl:rename $filename]
    return $::vTcl(images,$reference,description)
}

proc {vTcl:image:get_type} {filename} {
    set reference [vTcl:rename $filename]
    return $::vTcl(images,$reference,type)
}

proc {vTcl:image:get_image} {filename} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.
    set reference [vTcl:rename $filename]
    # Let's do some checking first
    if {![info exists ::vTcl(images,$reference,image)]} {
        # Well, the path may be wrong; in that case check
        # only the filename instead, without the path.
        set imageTail [file tail $filename]
        foreach oneFile $::vTcl(images,files) {
            if {[file tail $oneFile] == $imageTail} {
                set reference [vTcl:rename $oneFile]
                break
            }
        }
    }
    # Rozen. There follows a hack in case one wants to rerun a tcl
    # file which contains a file name where an image is expected.
    if {![info exists ::vTcl(images,$reference,image)]} {
        set ::vTcl(images,$reference,image) \
            [vTcl:image:create_new_image $filename]
    }
    return $::vTcl(images,$reference,image)
}

proc {vTcl:image:init_img_manager} {} {
    # I believe that this is no longer being used. Rozen
    global vTcl tcl_platform
    # in case an image editor has not been specified yet,
    # set a default
    set noeditor 0
    if {![info exists vTcl(pr,imageeditor)]} {
        set noeditor 1
    } elseif {$vTcl(pr,imageeditor) == ""} {
        set noeditor 1
    }
    if {$noeditor} {
    switch $tcl_platform(platform) {
        "unix" {
        set vTcl(pr,imageeditor) "gimp"
        }
        "windows" {
        set vTcl(pr,imageeditor) \
            "C:/Program Files/Accessories/mspaint.exe"
        }
        "default" {
        set vTcl(pr,imageeditor) ""
        }
    }
    }
    set base $vTcl(images,manager_dlg,win)
    set theList $base.cpd29
    set imageTextList {}
    foreach image $vTcl(images,files) {
        set reference [vTcl:rename $image]
        set object $vTcl(images,$reference,image)
        lappend imageTextList $object
        lappend imageTextList "$image ($vTcl(images,$reference,type))"
    }
    $theList widget fill $imageTextList
    vTcl:image:enableButtons $base
}

proc vTcl:light_or_dark_image {image_name} {
    # Function to select image based on name which is a string like "add".
    global vTcl
    if {$vTcl(dark)} {       ;# NEEDS WORK dark
        #vTcl:toolbar_button $path -image [vTcl:image:get_image ok_light.gif]
        set image [vTcl:image:get_image ${image_name}_light.gif]
    } else {
        #vTcl:toolbar_button $path -image [vTcl:image:get_image ok.gif]
        # if {$image_name in {up down}} {
        #     # set image $image_name
        #     set image [vTcl:image:get_image big_${image_name}.gif]
        # } else {
        #     set image [vTcl:image:get_image ${image_name}.gif]
        # }
        set image [vTcl:image:get_image ${image_name}.gif]
    }
    return $image
}


proc {vTcl:image:init_stock} {} {
    global vTcl

    if [info exist vTcl(images,files)] {
        foreach image $vTcl(images,files) {
            catch { image delete $image }
        }
    }
    set vTcl(images,files) ""
    ;# NEEDS WORK dark had to add ok_light etc. to following list.
    set images {
        copy
        cut
        inswidg
        paste
        new
        ok
        open
        save
        replace
        add
        remove
        show
        hide
        refresh
        search
        browse
        ok_light
        add_light
        up_light
        down_light
        plus
        plus_light
        minus
        minus_light
        page_up
        page_up_light
        page_down
        page_down_light
        remove_light
        view_refresh_white
        document_save_as_white
        go_top_white
        sort_ascending_white
        delete_32_white
        ash_cloud_32_white
        floppy_white
        basic_reload_white
        exit
        arrow_top
        expand
        go_top

    }
    foreach file $images {
        set file [file join $vTcl(VTCL_HOME) images edit $file.gif]
        vTcl:image:create_new_image $file {} stock
    }
}

proc {vTcl:image:new_image_file} {object} {
    # User selects the image file and it is converted to relative to
    # current directory.
    global vTcl
    set types $vTcl(image,filetypes)
    option add *foreground black  ;# Rozen So one can see filenames with dark bg
    if {$object ne ""} {
        set image $vTcl(images,filename,$object)
        set file_tail [file tail $image]
    } else {
        set file_tail ""
    }
    # tk_getOpenFile returns the full path name
    set newImageFile [tk_getOpenFile -filetypes $types  \
                          -title {Select Image} -defaultextension .gif \
                          -initialdir [pwd] \
                          -initialfile $file_tail]
    if {$newImageFile == ""} { return }
    set f_comp $vTcl(proj_dir)
    # set newImageFile [vTcl:relTo $newImageFile [pwd]]
    set newImageFile [vTcl:relTo $newImageFile $f_comp]
    if {$vTcl(file_in_subdir) eq 0} {
        vTcl::MessageBox -icon warning -type ok -title "Warning"  \
            -message "Image file not in project subdirectory as advised."
    }
    option add *vTcl*foreground $vTcl(pr,fgcolor)  ;# Rozen
    # Rozen. newImageFile seems to be what I want.

    set object ""

    if {[lempty $newImageFile]} { return }

    # just double-check that it doesn't exist!

    if {[lsearch -exact $vTcl(images,files) $newImageFile] != -1} {
        # We have already used this image, so let's just find the
        # object name. Rozen 12/30/17
        set reference [vTcl:rename $newImageFile]
        set object $::vTcl(images,$reference,image)
        return $object
        # No longer do I want to treat this as an error. So Above
        # code. Rozen 12/30/17
        # ::vTcl::MessageBox -title "New image" \
            #     -message "Image already imported!" \
            #     -icon error
        # return
    }
    set object [vTcl:image:create_new_image $newImageFile "user image" "user"]

    # let's refresh!
    vTcl:image:refresh_manager 1.0
    return $object
}

# proc vTcl:image:replace_image {imageListbox} {
#     global vTcl
#     set filename [vTcl:image:get_selected_image $imageListbox]
#     set types $vTcl(image,filetypes)
#     set newImageFile [tk_getOpenFile -filetypes $types  -defaultextension .gif]
#     if {[lempty $newImageFile]} { return }
#     # just double-check that it doesn't exist!
#     if {[lsearch -exact $vTcl(images,files) $newImageFile] != -1} {
#     ::vTcl::MessageBox \
#         -title "New image" \
#         -message "Image already imported!" \
#         -icon error
#     return
#     }

#     vTcl::lremove vTcl(images,files) $filename
#     lappend vTcl(images,files) $newImageFile

#     set object [vTcl:image:get_image $filename]

#     set oldreference [vTcl:rename $filename]
#     set reference    [vTcl:rename $newImageFile]

#     image create [vTcl:image:get_creation_type $newImageFile] \
#         $object -file $newImageFile

#     set vTcl(images,$reference,image)       $object
#     set vTcl(images,$reference,description) \
#         [vTcl:image:get_description $filename]
#     set vTcl(images,$reference,type)        [vTcl:image:get_type $filename]
#     set vTcl(images,filename,$object)       $newImageFile

#     unset vTcl(images,$oldreference,image)
#     unset vTcl(images,$oldreference,description)
#     unset vTcl(images,$oldreference,type)

#     set pos [vTcl:image:get_manager_position]
#     vTcl:image:refresh_manager $pos
# }

proc vTcl:image:fill_noborder_image_list {t} {
    update

    set imageTextList {}
    foreach imageFilename $::vTcl(images,files) {
        set source [::vTcl:image:get_image $imageFilename]
        lappend imageTextList $source
        lappend imageTextList $imageFilename
    }

    lappend imageTextList ""
    lappend imageTextList "New image..."

    lappend imageTextList ""
    lappend imageTextList "Cancel"

    $t widget fill $imageTextList
}

proc vTcl:image:listboxSelect {l} {
    set item [$l widget selection get]
    set text [$l widget itemcget $item -text]

    if {$text == "New image..."} {
        set ::vTcl(images,selector_dlg,current) <new>
    } elseif {$text == "Cancel"} {
        set ::vTcl(images,selector_dlg,current) <cancel>
    } else {
        set ::vTcl(images,selector_dlg,current) \
             [vTcl:image:get_image $text]
    }
}

proc vTcl:image:create_selector_dlg {base} {

    if {$base == ""} {
        set base .vTcl.noborder_imagelist
    }

    if {[winfo exists $base]} {
        wm deiconify $base; return
    }

    global vTcl
    global tcl_platform

    set vTcl(images,selector_dlg,win) $base
    set vTcl(images,selector_dlg,current)  ""

    ###################
    # CREATING WIDGETS
    ###################
    toplevel $base -class Toplevel \
        -background #bcbcbc -highlightbackground #bcbcbc \
        -highlightcolor #000000
    wm focusmodel $base passive

    vTcl:prepare_pulldown $base 400 252

    wm maxsize $base 1009 738
    wm minsize $base 1 1
    wm resizable $base 1 1
    wm deiconify $base

    vTcl::widgets::core::compoundcontainer::createCmd $base.cpd29 \
        -compoundType internal -compoundClass {Image Listbox}
    $base.cpd29 widget configure -mouseover yes
    bind $base.cpd29 <<ListboxSelect>> {
        vTcl:image:listboxSelect %W
    }

    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.cpd29 \
        -in $base -anchor center -expand 1 -fill both -side top

    vTcl:display_pulldown $base 400 252 \
        "set vTcl(images,selector_dlg,current) <cancel>"

    vTcl:image:fill_noborder_image_list $base.cpd29
}

proc vTcl:prompt_user_image {target option} {
    # Rozen. I want to change this so that I go directly to the image
    # file selector stuff and not to the intermediate stuff. We come
    # here from the image button.
    # vTcl:prompt_user_image2
    #      vTcl:image:new_image_file
    #          vTcl:image:create_new_image
    global vTcl
    if {$target == ""} {return}
    set base ".vTcl.com_[vTcl:rename ${target}${option}]"

    if {[catch {set object [$target cget $option]}] == 1} {
        return
    }
    set r [vTcl:prompt_user_image2 $object]
    if {$r != ""} {
        $target configure $option $r
        vTcl:create_handles $target  ;# Added 5/20/19
        # refresh property manager
        vTcl:update_widget_info $target
        vTcl:prop:update_attr
    }
}

proc vTcl:prompt_user_image2 {image} {
    global vTcl
    set r [vTcl:image:new_image_file $image]
    if {$r != ""} {
        return $r
    } else {
        return $image
    }
}

proc vTcl:image:dump_create_image {image} {
    global vTcl
    if { ! [info exists vTcl(pr,saveimagesinline)] } {
        set vTcl(pr,saveimagesinline) 0
    }
    if {$vTcl(pr,saveimagesinline)} {
        set inline \n[::base64::encode_file $image]
    } else {
        set inline ""
    }

#     set code \
# "$vTcl(tab)# from vTcl:image:dump_create_image
# $vTcl(tab)set image_split \[file split \$image_file\]
# $vTcl(tab)set full_split \[list \{\*\}\$proj_dir \{\*\}\$image_split\]"
#    return $code
    return ""
}

proc vTcl:image:dump_create_image_header {used} {
    # Called by compound.tcl and
    global vTcl
    append code "set image_list \{ \n"
    set new_list [list]
    foreach i $used {
        set pieces [split $i]
        foreach p $pieces {
            lappend new_list $p
        }
    }
    # foreach image  $used { }
    foreach image  $new_list {
        set file $vTcl(images,filename,$image)
        if {[regexp {^\.bor[0-9]} $vTcl(w,widget)]} {
            set file [vTcl:relTo $file $vTcl(borrow_dir)]
        } else {
            set file [vTcl:relTo $file $vTcl(proj_dir)]
        }
        append code $vTcl(tab) $image " " \"$file\" " \n"
    }
    append code "\}\n"
    append code "vTcl:create_project_images \$image_list   ;# In image.tcl"
    return $code
}

proc vTcl:image:dump_create_image_footer {} {
    # Appears unused
    global vTcl
return ""
    set code \
"    # from vTcl:image:dump_create_image_footer
    global proj_dir
    set full_file \[join \$full_split \"/\"\]
    set full_file \[file normalize \$full_file\]
    if \{!\[file exists \$full_file\]\} \{
        set proj_dir \[file normalize \$proj_dir\]
        set text \\
\"Image '\$image' not found in \$proj_dir.
Exiting PAGE.\"
        ::vTcl::MessageBox -title Error -icon error -message \$text
        exit 2
    \}
    vTcl:image:create_new_image \$full_file {} user {} \$image
\}\n"
    return $code
}

proc vTcl:image:generate_image_stock {fileID} {
    # I believe that this is no longer being used. Rozen
    global vTcl
    if {[lempty $vTcl(dump,stockImages)] && [lempty $vTcl(dump,userImages)]} {
        return
    }
    puts $fileID "\n"
    puts $fileID {#############################################################################}
    puts $fileID "\#\# vTcl Code to Load Stock Images\n"
    puts $fileID "\nif {!\[info exist vTcl(sourcing)\]} \{"
    foreach i {vTcl:rename
               vTcl:image:create_new_image
               vTcl:image:get_image
               vTcl:image:get_creation_type} {
        puts $fileID [vTcl:dump_proc $i]
    }
    puts $fileID [vTcl:image:dump_create_image_header]
    foreach image $vTcl(dump,stockImages) {
    set file $vTcl(images,filename,$image)
    puts $fileID [vTcl:image:dump_create_image $file]
    }
    # puts $fileID [vTcl:image:dump_create_image_footer]
    # puts $fileID "\}"
}

proc vTcl:image:generate_image_user {fileID} {
    global vTcl
    # vTcl(dump,userImages) is set in vTcl:dump:gather_widget_info in dump.tcl
    if {[lempty $vTcl(dump,userImages)] == 1} {
        return}
    set vTcl(dump,userImages) [vTcl:lrmdups $vTcl(dump,userImages)]
    if {[lsearch $vTcl(dump,userImages) {}] > -1} {
        set vTcl(dump,userImages) [lrange $vTcl(dump,userImages) 1 end]
    }
    puts $fileID [vTcl:image:dump_create_image_header $vTcl(dump,userImages)]

    puts $fileID [vTcl:image:dump_create_image dummy]
}

proc vTcl:image:delete_image {image} {
    global vTcl
    set object [vTcl:image:get_image $image]
    set reference [vTcl:rename $image]
    image delete $object
    set index [lsearch -exact $vTcl(images,files) $image]
    set vTcl(images,files) [lreplace $vTcl(images,files) $index $index]
    unset vTcl(images,$reference,image)
    unset vTcl(images,$reference,description)
    unset vTcl(images,$reference,type)
    unset vTcl(images,filename,$object)
}

proc vTcl:image:get_selected_image {imageListbox} {
    set item [$imageListbox widget selection get]
    if {$item == ""} {
        return ""
    }
    set text [$imageListbox widget itemcget $item -text]

    ## remove the (user) or (stock) at the end of the item
    return [string range $text 0 [expr [string last ( $text] -2]]
}

proc vTcl:image:ask_delete_image {imageListbox} {
    set image [vTcl:image:get_selected_image $imageListbox]

    set result [
    ::vTcl::MessageBox \
        -message "Do you want to remove $image from the project?" \
        -title "PAGE" \
        -type yesno \
        -icon question
    ]

    if {$result == "yes"} {
    set pos [vTcl:image:get_manager_position]
    vTcl:image:delete_image $image
    vTcl:image:refresh_manager $pos
    }
}

proc vTcl:image:remove_user_images {} {
    global vTcl
    foreach image $vTcl(images,files) {
    if {[vTcl:image:get_type $image] == "user"} {
        vTcl:image:delete_image $image
    }
    }
    vTcl:image:refresh_manager
}

proc vTcl:image:reload_images {} {
    # I believe that this is no longer being used. Rozen
    global vTcl
    foreach image $vTcl(images,files) {
        set object [vTcl:image:get_image $image]
        $object configure -file $image
    }
}

proc vTcl:image:enableButtons {base} {
    # I believe that this is no longer being used. Rozen
    set image [vTcl:image:get_selected_image $base.cpd29]
    if {$image == ""} {
         set type stock
    } else {
         set type [vTcl:image:get_type $image]
    }

    set enabled(stock) disabled
    set enabled(user)  normal

    $base.butfr.but35 configure -state $enabled($type)
    $base.butfr.but36 configure -state $enabled($type)
    $base.butfr.but37 configure -state $enabled($type)
}

#proc vTclWindow.vTcl.imgManager {args} {
#    # I believe that this is no longer being used. Rozen
#    set base ""
#    if {$base == ""} {
#        set base .vTcl.imgManager
#    }
#    if {[winfo exists $base]} {
#        wm deiconify $base; return
#    }
#
#    global vTcl
#    set vTcl(images,manager_dlg,status) ""
#    set vTcl(images,manager_dlg,win) $base
#
#    ###################
#    # CREATING WIDGETS
#    ###################
#    toplevel $base -class Toplevel
#    wm withdraw $base
#    wm focusmodel $base passive
#    wm maxsize $base 1009 738
#    wm minsize $base 1 1
#    update
#    wm overrideredirect $base 0
#    wm resizable $base 1 1
#    wm title $base "Image manager"
#    wm protocol $base WM_DELETE_WINDOW "wm withdraw $base"
#    wm transient .vTcl.imgManager .vTcl
#
#    vTcl::widgets::core::compoundcontainer::createCmd $base.cpd29 \
#        -compoundType internal -compoundClass {Image Listbox}
#    bind $base.cpd29 <<ListboxSelect>> "
#        vTcl:image:enableButtons $base
#    "
#
#    frame $base.butfr
#    vTcl:toolbar_button $base.butfr.but32 \
#        -command vTcl:image:new_image_file \
#        -padx 3 -pady 3 -image [vTcl:image:get_image add.gif]
#    vTcl:toolbar_button $base.butfr.but34 \
#        -command vTcl:image:reload_images \
#        -padx 3 -pady 3 -image [vTcl:image:get_image refresh.gif]
#    vTcl:toolbar_button $base.butfr.but35 \
#        -command "vTcl:image:ask_delete_image $base.cpd29" -state disabled \
#        -padx 3 -pady 3 -image [vTcl:image:get_image remove.gif]
#    vTcl:toolbar_button $base.butfr.but36 \
#        -command "vTcl:image:external_editor $base.cpd29" -state disabled \
#        -padx 3 -pady 3 -image [vTcl:image:get_image open.gif]
#    vTcl:toolbar_button $base.butfr.but37 \
#        -command "vTcl:image:replace_image $base.cpd29" -state disabled \
#        -padx 3 -pady 3 -image [vTcl:image:get_image replace.gif]
#    ::vTcl::OkButton $base.butfr.but33 -command "Window hide $base"
#    ###################
#    # SETTING GEOMETRY
#    ###################
#    pack $base.cpd29 \
#        -in $base -anchor center -expand 1 -fill both -side bottom
#
#    pack $base.butfr -fill x -side top
#    pack $base.butfr.but32 \
#        -anchor nw -expand 0 -fill none -side left
#    vTcl:set_balloon $base.butfr.but32 "Add new image"
#    pack $base.butfr.but35 \
#        -anchor nw -expand 0 -fill none -side left
#    pack $base.butfr.but36 \
#        -anchor nw -expand 0 -fill none -side left
#    pack $base.butfr.but37 \
#        -anchor nw -expand 0 -fill none -side left
#    pack $base.butfr.but34 \
#        -anchor nw -expand 0 -fill none -side left
#    vTcl:set_balloon $base.butfr.but35 "Delete image"
#    vTcl:set_balloon $base.butfr.but36 "Open image in external editor"
#    vTcl:set_balloon $base.butfr.but37 "Replace image"
#    vTcl:set_balloon $base.butfr.but34 "Reload images"
#    pack $base.butfr.but33 \
#        -anchor nw -expand 0 -fill none -side right
#    vTcl:set_balloon $base.butfr.but33 "Close"
#
#    wm geometry $base 494x581
#    vTcl:center $base 494 581
#    catch {wm geometry $base $vTcl(geometry,$base)}
#    wm deiconify $base
#
#    vTcl:image:init_img_manager
#    vTcl:setup_vTcl:bind $base
#}

#proc vTcl:image:prompt_image_manager {} {

#    Window show .vTcl.imgManager
#}

proc vTcl:image:get_files_list {} {
    global vTcl
    if {$vTcl(pr,saveimagesinline)} {

        # if we save images inline we don't need to wrap them
        return ""
    }
    return $vTcl(images,files)
}

# translation for options when saving files. TranslateOption is
# function in loadwidg.tcl as is NoEncaseOption.
#TranslateOption    -image vTcl:image:translate
NoEncaseOption     -image 1

#TranslateOption    -selectimage vTcl:image:translate
NoEncaseOption     -selectimage 1

proc vTcl:image:translate {value} {
    global vTcl
    if [info exists vTcl(images,filename,$value)] {
        # if-else added 4/23/19 to see if the filename is relative or
        # absolute. It is added to convert existing project files to
        # relative file names for images.
        if {[string range $vTcl(images,filename,$value) 0 0] != "."} {
            # Assume that the filename is absolute. We change it to relative.
            set filename [vTcl:relTo $vTcl(images,filename,$value) [pwd]]
            set newvalue \
                "\[vTcl:image:get_image [vTcl:portable_filename $filename]\]"
        } else {
            set newvalue "\[vTcl:image:get_image "
            append newvalue \
                    "[vTcl:portable_filename $vTcl(images,filename,$value)]\]"
                #"[vTcl:portable_filename $vTcl(images,filename,$value)]\]"
        }
        return $newvalue
    } else {
        return $value
    }
}

proc vTcl:image:refresh_manager {{position 0.0}} {
    global vTcl

    if [info exists vTcl(images,manager_dlg,win)] {
        if [winfo exists $vTcl(images,manager_dlg,win)] {
            vTcl:image:init_img_manager
            $vTcl(images,manager_dlg,win).cpd29 widget yview moveto $position
        }
    }
}

proc vTcl:image:get_manager_position {} {
    return [lindex [$::vTcl(images,manager_dlg,win).cpd29 widget yview] 0]
}

proc vTcl:image:external_editor {imageListbox} {
    set realName [vTcl:image:get_selected_image $imageListbox]
    if {$::tcl_platform(platform) == "windows"} {
         regsub -all / $realName {\\} realName
    }
    if {[catch {exec "$::vTcl(pr,imageeditor)" "$realName" &}]} {
        vTcl:error "Could not execute external image editor!"
    }
}

proc vTcl:create_project_images {image_list} {
    # Code called when a project file contains images. It is put here
    # to simplify the project file and to keep the code in one place
    # to aid in debugging. This way I do not have to create a new
    # project file to test and debug the logic.
    global vTcl
    set proj_dir $vTcl(proj_dir)
    foreach {image image_file} $image_list {
        # from vTcl:image:dump_create_image
        set full_file [file join $proj_dir $image_file]
        set full_file [file normalize $full_file]
        if {![file exists $full_file] && !$vTcl(borrow)} {
            set proj_dir [file normalize $proj_dir]
            set f [file tail $full_file]
            set msg "Image '$f' not found in $proj_dir. Shall PAGE copy it?"
            set response [::vTcl::MessageBox -title "Copy question" \
                              -icon question -message $msg \
                              -type yesno -default yes]
            if {$response == yes} {
                set source_file [file join $vTcl(borrow_dir) $image_file]
                set source_file [file normalize $source_file]
                set target_dir [file dirname $full_file]
                file mkdir $target_dir
                file copy $source_file $full_file
            }
        }
        vTcl:image:create_new_image $full_file {} user {} $image
    }
}

proc vTcl:remove_image {target} {
    global vTcl
    $target configure -image {}
    vTcl:destroy_handles
    vTcl:create_handles $target
    # To clear the image attribute in the Attribute Editor
    set vTcl(w,opt,-image) ""
    vTcl:prop:update_attr 1
}
