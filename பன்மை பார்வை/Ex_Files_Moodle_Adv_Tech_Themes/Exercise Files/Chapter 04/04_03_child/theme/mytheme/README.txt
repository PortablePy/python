
/* How to copy and customise this theme.
----------------------------------------*/

This document describes how to copy and customise the My Theme (bootstrapbase) theme so that
you can build on this to create a theme of your own. It assumes you have some
understanding of how themes work within Moodle 2.5, as well as a basic understanding
of HTML and CSS.

Getting started
---------------

From your Moodle theme directory right click on mytheme and then copy and paste back
into your Moodle theme directory. You should now have a folder called Copy of mytheme.
If you right click this folder you are given the option to Rename it. So rename this
folder to your chosen theme name, using only lower case letters, and if needed,
underscores. For the purpose of this tutorial we will call the theme 'mythemetheme'.

On opening 'mythemetheme' your you will find several files and sub-directories which have
files within them.

These are:

config.php
    Where all the theme configurations are made.
    (Contains some elements that require renaming).
lib.php
    Where all the functions for the themes settings are found.
    (Contains some elements that require renaming).
settings.php
    Where all the setting for this theme are created.
    (Contains some elements that require renaming).
version.php
    Where the version number and plugin component information is kept.
    (Contains some elements that require renaming).
/lang/
    This directory contains all language sub-directories for other languages
    if and when you want to add them.
/lang/en/
    This sub-directory contains your language files, in this case English.
/lang/en/theme_mytheme.php
    This file contains all the language strings for your theme.
    (Contains some elements that require renaming as well as the filename itself).
/layout/
    This directory contains all the layout files for this theme.
/layout/columns1.php
    Layout file for a one column layout (content only).
    (Contains some elements that require renaming).
/layout/columns2.php
    Layout file for a two column layout (side-pre and content).
    (Contains some elements that require renaming).
/layout/columns3.php
    Layout file for a three column layout (side-pre, content and side-post) and the front page.
    (Contains some elements that require renaming).
/layout/embedded.php
    Embedded layout file for embeded pages, like iframe/object embeded in moodleform.
    (Contains some elements that require renaming).
/layout/maintenance.php
    Maintenance layout file which does not have any blocks, links, or API calls that would lead to database or cache interaction.
    (Contains some elements that require renaming).
/layout/secure.php
    Secure layout file for safebrowser and securewindow.
    (Contains some elements that require renaming).
/style/
    This directory contains all the CSS files for this theme.
/style/custom.css
    This is where all the settings CSS is generated.
/pix/
    This directory contains a screen shot of this theme as well as a favicon
    and any images used in the theme.

Renaming elements
-----------------

The problem when copying a theme is that you need to rename all those instances
where the old theme name occurs, in this case mytheme. So using the above list as
a guide, search through and change all the instances of the theme name
'mytheme' to 'mythemetheme'. This includes the filename of the lang/en/theme_mytheme.php.
You need to change this to 'theme_mythemetheme.php'.

Installing your theme
---------------------

Once all the changes to the name have been made, you can safely install the theme.
If you are already logged in just refreshing the browser should trigger your Moodle
site to begin the install 'Plugins Check'.

If not then navigate to Administration > Notifications.

Once your theme is successfully installed you can select it and begin to modify
it using the custom settings page found by navigating to...
Administration > Site Administration > Appearance > Themes >>
and then click on (My Themetheme) or whatever you renamed your theme to,
from the list of theme names that appear at this point in the side block.

Customisation using custom theme settings
-----------------------------------------

The settings page for the My Theme theme can be located by navigating to:

Administration > Site Administration > Appearance > Themes > My Theme

Moodle documentation
--------------------

Further information can be found on Moodle Docs: http://docs.moodle.org/dev/My Theme_theme
