#!/usr/bin/perl -w -- 
#
# generated by wxGlade "faked test version"
#
# To get wxPerl visit http://www.wxperl.it
#

use Wx qw[:allclasses];
use strict;

# begin wxGlade: dependencies
# end wxGlade

# begin wxGlade: extracode
# extra code added using wxGlade
use Time::localtime;
# extra code added using wxGlade
use Time::gmtime;
# end wxGlade

package PlOgg3_MyDialog;

use Wx qw[:everything];
use base qw(Wx::Dialog);
use strict;

use Wx::Locale gettext => '_T';
sub new {
    my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
    $parent = undef              unless defined $parent;
    $id     = -1                 unless defined $id;
    $title  = ""                 unless defined $title;
    $pos    = wxDefaultPosition  unless defined $pos;
    $size   = wxDefaultSize      unless defined $size;
    $name   = ""                 unless defined $name;

    # begin wxGlade: PlOgg3_MyDialog::new
    $style = wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER
        unless defined $style;

    $self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
    $self->{notebook_1} = Wx::Notebook->new($self, wxID_ANY);
    $self->{notebook_1_pane_1} = Wx::Panel->new($self->{notebook_1}, wxID_ANY);
    $self->{text_ctrl_1} = Wx::TextCtrl->new($self->{notebook_1_pane_1}, wxID_ANY, "");
    $self->{button_3} = Wx::Button->new($self->{notebook_1_pane_1}, wxID_OPEN, "");
    $self->{notebook_1_pane_2} = Wx::Panel->new($self->{notebook_1}, wxID_ANY);
    $self->{radio_box_1} = Wx::RadioBox->new($self->{notebook_1_pane_2}, wxID_ANY, _T("Sampling Rate"), wxDefaultPosition, wxDefaultSize, [_T("44 kbit"), _T("128 kbit")], 0, wxRA_SPECIFY_ROWS);
    $self->{notebook_1_pane_3} = Wx::Panel->new($self->{notebook_1}, wxID_ANY);
    $self->{text_ctrl_2} = Wx::TextCtrl->new($self->{notebook_1_pane_3}, wxID_ANY, "", wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE);
    $self->{notebook_1_pane_4} = Wx::Panel->new($self->{notebook_1}, wxID_ANY);
    $self->{label_2} = Wx::StaticText->new($self->{notebook_1_pane_4}, wxID_ANY, _T("File name:"));
    $self->{text_ctrl_3} = Wx::TextCtrl->new($self->{notebook_1_pane_4}, wxID_ANY, "");
    $self->{button_4} = Wx::Button->new($self->{notebook_1_pane_4}, wxID_OPEN, "");
    $self->{checkbox_1} = Wx::CheckBox->new($self->{notebook_1_pane_4}, wxID_ANY, _T("Overwrite existing file"));
    $self->{static_line_1} = Wx::StaticLine->new($self, wxID_ANY);
    $self->{button_5} = Wx::Button->new($self, wxID_CLOSE, "");
    $self->{button_2} = Wx::Button->new($self, wxID_CANCEL, "", wxDefaultPosition, wxDefaultSize, wxBU_TOP);
    $self->{button_1} = Wx::Button->new($self, wxID_OK, "", wxDefaultPosition, wxDefaultSize, wxBU_TOP);

    $self->__set_properties();
    $self->__do_layout();

    Wx::Event::EVT_BUTTON($self, $self->{button_1}->GetId, $self->can('startConverting'));

    # end wxGlade

    # manually added code
    print 'Dialog has been created at ', localtime();

    return $self;

}


sub __set_properties {
    my $self = shift;
    # begin wxGlade: PlOgg3_MyDialog::__set_properties
    $self->SetTitle(_T("mp3 2 ogg"));
    $self->SetSize(Wx::Size->new(500, 300));
    $self->{radio_box_1}->SetSelection(0);
    $self->{checkbox_1}->SetToolTipString(_T("Overwrite an existing file"));
    $self->{checkbox_1}->SetValue(1);
    # end wxGlade
}

sub __do_layout {
    my $self = shift;
    # begin wxGlade: PlOgg3_MyDialog::__do_layout
    $self->{sizer_1} = Wx::FlexGridSizer->new(3, 1, 0, 0);
    $self->{sizer_2} = Wx::FlexGridSizer->new(1, 3, 0, 0);
    $self->{grid_sizer_2} = Wx::FlexGridSizer->new(2, 3, 0, 0);
    $self->{sizer_3} = Wx::BoxSizer->new(wxHORIZONTAL);
    $self->{sizer_4} = Wx::BoxSizer->new(wxHORIZONTAL);
    $self->{grid_sizer_1} = Wx::FlexGridSizer->new(1, 3, 0, 0);
    my $label_1 = Wx::StaticText->new($self->{notebook_1_pane_1}, wxID_ANY, _T("File name:"));
    $self->{grid_sizer_1}->Add($label_1, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);
    $self->{grid_sizer_1}->Add($self->{text_ctrl_1}, 1, wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5);
    $self->{grid_sizer_1}->Add($self->{button_3}, 0, wxALL, 5);
    $self->{notebook_1_pane_1}->SetSizer($self->{grid_sizer_1});
    $self->{grid_sizer_1}->AddGrowableCol(1);
    $self->{sizer_4}->Add($self->{radio_box_1}, 1, wxALL|wxEXPAND|wxSHAPED, 5);
    $self->{notebook_1_pane_2}->SetSizer($self->{sizer_4});
    $self->{sizer_3}->Add($self->{text_ctrl_2}, 1, wxALL|wxEXPAND, 5);
    $self->{notebook_1_pane_3}->SetSizer($self->{sizer_3});
    $self->{grid_sizer_2}->Add($self->{label_2}, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);
    $self->{grid_sizer_2}->Add($self->{text_ctrl_3}, 0, wxALL|wxEXPAND, 5);
    $self->{grid_sizer_2}->Add($self->{button_4}, 0, wxALL, 5);
    $self->{grid_sizer_2}->Add(20, 20, 0, 0, 0);
    $self->{grid_sizer_2}->Add($self->{checkbox_1}, 0, wxALL|wxEXPAND, 5);
    $self->{grid_sizer_2}->Add(20, 20, 0, 0, 0);
    $self->{notebook_1_pane_4}->SetSizer($self->{grid_sizer_2});
    $self->{grid_sizer_2}->AddGrowableCol(1);
    $self->{notebook_1}->AddPage($self->{notebook_1_pane_1}, _T("Input File"));
    $self->{notebook_1}->AddPage($self->{notebook_1_pane_2}, _T("Converting Options"));
    $self->{notebook_1}->AddPage($self->{notebook_1_pane_3}, _T("Converting Progress"));
    $self->{notebook_1}->AddPage($self->{notebook_1_pane_4}, _T("Output File"));
    $self->{sizer_1}->Add($self->{notebook_1}, 1, wxEXPAND, 0);
    $self->{sizer_1}->Add($self->{static_line_1}, 0, wxALL|wxEXPAND, 5);
    $self->{sizer_2}->Add($self->{button_5}, 0, wxALIGN_RIGHT|wxALL, 5);
    $self->{sizer_2}->Add($self->{button_2}, 0, wxALIGN_RIGHT|wxALL, 5);
    $self->{sizer_2}->Add($self->{button_1}, 0, wxALIGN_RIGHT|wxALL, 5);
    $self->{sizer_1}->Add($self->{sizer_2}, 0, wxALIGN_RIGHT, 0);
    $self->SetSizer($self->{sizer_1});
    $self->{sizer_1}->AddGrowableRow(0);
    $self->{sizer_1}->AddGrowableCol(0);
    $self->Layout();
    $self->Centre();
    # end wxGlade
}

sub startConverting {
    my ($self, $event) = @_;
    # wxGlade: PlOgg3_MyDialog::startConverting <event_handler>
    warn "Event handler (startConverting) not implemented";
    $event->Skip;
    # end wxGlade
}


# end of class PlOgg3_MyDialog

1;

package PlOgg3_MyFrame;

use Wx qw[:everything];
use base qw(Wx::Frame);
use strict;

use Wx::Locale gettext => '_T';
sub new {
    my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
    $parent = undef              unless defined $parent;
    $id     = -1                 unless defined $id;
    $title  = ""                 unless defined $title;
    $pos    = wxDefaultPosition  unless defined $pos;
    $size   = wxDefaultSize      unless defined $size;
    $name   = ""                 unless defined $name;

    # begin wxGlade: PlOgg3_MyFrame::new
    $style = wxDEFAULT_FRAME_STYLE 
        unless defined $style;

    $self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
    $self->{grid_1} = Wx::Grid->new($self, wxID_ANY);
    $self->{static_line_2} = Wx::StaticLine->new($self, wxID_ANY);
    $self->{button_6} = Wx::Button->new($self, wxID_CLOSE, "");

    $self->__set_properties();
    $self->__do_layout();

    # end wxGlade

    # manually added code
    print 'Dialog has been created at ', gmctime();

    return $self;

}


sub __set_properties {
    my $self = shift;
    # begin wxGlade: PlOgg3_MyFrame::__set_properties
    $self->SetTitle(_T("FrameOggCompressionDetails"));
    $self->SetSize(Wx::Size->new(400, 300));
    $self->{grid_1}->CreateGrid(8, 3);
    $self->{grid_1}->SetSelectionMode(wxGridSelectCells);
    $self->{button_6}->SetFocus();
    $self->{button_6}->SetDefault();
    # end wxGlade
}

sub __do_layout {
    my $self = shift;
    # begin wxGlade: PlOgg3_MyFrame::__do_layout
    $self->{sizer_5} = Wx::BoxSizer->new(wxVERTICAL);
    $self->{grid_sizer_3} = Wx::FlexGridSizer->new(3, 1, 0, 0);
    $self->{grid_sizer_3}->Add($self->{grid_1}, 1, wxEXPAND, 0);
    $self->{grid_sizer_3}->Add($self->{static_line_2}, 0, wxALL|wxEXPAND, 5);
    $self->{grid_sizer_3}->Add($self->{button_6}, 0, wxALIGN_RIGHT|wxALL, 5);
    $self->{grid_sizer_3}->AddGrowableRow(0);
    $self->{grid_sizer_3}->AddGrowableCol(0);
    $self->{sizer_5}->Add($self->{grid_sizer_3}, 1, wxEXPAND, 0);
    $self->SetSizer($self->{sizer_5});
    $self->Layout();
    # end wxGlade
}

# end of class PlOgg3_MyFrame

1;

1;

package main;

unless(caller){
    my $local = Wx::Locale->new("English", "en", "en"); # replace with ??
    $local->AddCatalog("PlOgg3_app"); # replace with the appropriate catalog name

    local *Wx::App::OnInit = sub{1};
    my $PlOgg3_app = Wx::App->new();
    Wx::InitAllImageHandlers();

    my $Mp3_To_Ogg = PlOgg3_MyDialog->new();

    $PlOgg3_app->SetTopWindow($Mp3_To_Ogg);
    $Mp3_To_Ogg->Show(1);
    $PlOgg3_app->MainLoop();
}
