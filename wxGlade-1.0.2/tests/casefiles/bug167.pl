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
    $self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
    $self->SetTitle(_T("frame_1"));
    
    $self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
    
    my $label_1 = Wx::StaticText->new($self, wxID_ANY, _T("Just a text"));
    $self->{sizer_1}->Add($label_1, 0, 0, 0);
    
    $self->SetSizer($self->{sizer_1});
    $self->{sizer_1}->Fit($self);
    
    $self->Layout();
    # end wxGlade
    return $self;

}


sub __set_properties {
    my $self = shift;
}

sub __do_layout {
    my $self = shift;
}

# end of class MyFrame

1;

# just an Unicode comment to raise an UnicodeDecodeError
# German umlauts are: ��� ��� �