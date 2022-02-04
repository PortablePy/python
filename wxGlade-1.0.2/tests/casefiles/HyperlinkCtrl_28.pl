#!/usr/bin/perl -w -- 
#
# generated by wxGlade
#
# To get wxPerl visit http://www.wxperl.it
#

use Wx qw[:allclasses];
use strict;

# begin wxGlade: dependencies
# end wxGlade

# begin wxGlade: extracode
# end wxGlade

package MyFrame;

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

    # begin wxGlade: MyFrame::new
    $style = wxDEFAULT_FRAME_STYLE
        unless defined $style;

    $self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
    $self->SetTitle(_T("frame_1"));
    
    $self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
    
    $self->{hyperlink_1} = Wx::HyperlinkCtrl->new($self, wxID_ANY, _T("Homepage wxGlade"), _T("http://wxglade.sf.net"), wxDefaultPosition, wxDefaultSize, wxHL_ALIGN_RIGHT);
    $self->{sizer_1}->Add($self->{hyperlink_1}, 0, wxALL, 5);
    
    $self->SetSizer($self->{sizer_1});
    $self->{sizer_1}->Fit($self);
    
    $self->Layout();
    # end wxGlade
    return $self;

}


# end of class MyFrame

1;

package MyApp;

use base qw(Wx::App);
use strict;

sub OnInit {
    my( $self ) = shift;

    Wx::InitAllImageHandlers();

    my $frame_1 = MyFrame->new();

    $self->SetTopWindow($frame_1);
    $frame_1->Show(1);

    return 1;
}
# end of class MyApp

package main;

unless(caller){
    my $local = Wx::Locale->new("English", "en", "en"); # replace with ??
    $local->AddCatalog("app"); # replace with the appropriate catalog name

    my $app = MyApp->new();
    $app->MainLoop();
}
