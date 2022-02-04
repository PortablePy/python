#!/usr/bin/perl -w -- 
#
# generated by wxGlade
#
# To get wxPerl visit http://www.wxperl.it
#

use Wx qw[:allclasses];
use strict;



package MyFrame;

use Wx qw[:everything];
use base qw(Wx::Frame);
use strict;

sub new {
    my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
    $parent = undef              unless defined $parent;
    $id     = -1                 unless defined $id;
    $title  = ""                 unless defined $title;
    $pos    = wxDefaultPosition  unless defined $pos;
    $size   = wxDefaultSize      unless defined $size;
    $name   = ""                 unless defined $name;

    $style = wxDEFAULT_FRAME_STYLE
        unless defined $style;

    $self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
    $self->SetSize(Wx::Size->new(400, 300));
    $self->SetTitle("frame");
    
    $self->{panel_1} = Wx::Panel->new($self, wxID_ANY);
    
    $self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
    
    $self->{text_ctrl_1} = Wx::TextCtrl->new($self->{panel_1}, wxID_ANY, "");
    $self->{sizer_1}->Add($self->{text_ctrl_1}, 0, 0, 0);
    
    $self->{button_1} = Wx::Button->new($self->{panel_1}, wxID_ANY, "button_1");
    $self->{sizer_1}->Add($self->{button_1}, 0, 0, 0);
    
    $self->{panel_1}->SetSizer($self->{sizer_1});
    
    $self->Layout();
    return $self;

}



1;

package MyFrame;

use Wx qw[:everything];
use base qw(Wx::Frame);
use strict;

sub new {
    my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
    $parent = undef              unless defined $parent;
    $id     = -1                 unless defined $id;
    $title  = ""                 unless defined $title;
    $pos    = wxDefaultPosition  unless defined $pos;
    $size   = wxDefaultSize      unless defined $size;
    $name   = ""                 unless defined $name;

    $style = wxDEFAULT_FRAME_STYLE
        unless defined $style;

    $self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
    $self->SetTitle("frame");
    
    $self->{panel_1} = Wx::Panel->new($self, wxID_ANY);
    
    $self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
    
    $self->{text_ctrl_1} = Wx::TextCtrl->new($self->{panel_1}, wxID_ANY, "");
    $self->{sizer_1}->Add($self->{text_ctrl_1}, 0, 0, 0);
    
    $self->{button_1} = Wx::Button->new($self->{panel_1}, wxID_ANY, "button_1");
    $self->{sizer_1}->Add($self->{button_1}, 0, 0, 0);
    
    $self->{panel_1}->SetSizer($self->{sizer_1});
    
    $self->{sizer_1}->Fit($self);
    $self->Layout();
    return $self;

}



1;

package MyApp;

use base qw(Wx::App);
use strict;

sub OnInit {
    my( $self ) = shift;

    Wx::InitAllImageHandlers();

    my $frame = MyFrame->new();

    $self->SetTopWindow($frame);
    $frame->Show(1);

    return 1;
}

package main;

unless(caller){
    my $app = MyApp->new();
    $app->MainLoop();
}
