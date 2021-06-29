"""\
wxBitmapButton widget configuration

@copyright: 2014-2016 Carsten Grohmann
@copyright: 2017 Dietmar Schwertberger
@license: MIT (see LICENSE.txt) - THIS PROGRAM COMES WITH NO WARRANTY
"""

# keep synchronous between wxBitmapButton and wxButton
config = {
    'wxklass': 'wxBitmapButton',
    'style_defs': {
        'wxBU_AUTODRAW': {'desc':_('If this is specified, the button will be drawn automatically using the label '
                                   'bitmap only, providing a 3D-look border. If this style is not specified, the '
                                   'button will be drawn without borders and using all provided bitmaps. WIN32 only.')},
        'wxBU_BOTTOM':   {'desc':_('Aligns the bitmap label to the bottom of the button. WIN32 only.'), },
        'wxBU_LEFT':     {'desc':_('Left-justifies the bitmap label. WIN32 only.'), },
        'wxBU_RIGHT':    {'desc':_('Right-justifies the bitmap label. WIN32 only.'), },
        'wxBU_TOP':      {'desc':_('Aligns the bitmap label to the top of the button. WIN32 only.'), },
        'wxBU_EXACTFIT': {'desc': _('Creates the button as small as possible instead of making it of the standard size.'
                                    '\n(On wx 2.8 the flag is not used, but the behaviour is on by default.'),
                          'supported_by': ('wx3',), },
        'wxBU_NOTEXT':   {'desc':_('Disables the display of the text label in the button even if it has one '
                                   'or its id is one of the standard stock ids with an associated label: '
                                   'without using this style a button which is only supposed to show a bitmap but '
                                   'uses a standard id would display a label too. '),
                          'supported_by': ('wx3',), },
        },
    'default_style': 'wxBU_EXACTFIT|wxBU_NOTEXT|wxBU_AUTODRAW',
    'style_list': ['wxBU_AUTODRAW', 'wxBU_LEFT', 'wxBU_RIGHT', 'wxBU_TOP', 'wxBU_BOTTOM', 'wxBU_EXACTFIT',
                   'wxBU_NOTEXT', 'wxBORDER_NONE', 'wxNO_BORDER'], # NO_BORDER is obsolete
    'events': {'EVT_BUTTON': {}, },
}
