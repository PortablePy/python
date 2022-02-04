# generated by wxGlade
#
# To get wxPerl visit http://www.wxperl.it
#

use Wx qw[:allclasses];
use strict;


import my_grid

package TestGlade;

use Wx qw[:everything];
use base qw(Wx::Panel);
use strict;

sub new {
    my( $self, $parent, $id, $pos, $size, $style, $name ) = @_;
    $parent = undef              unless defined $parent;
    $id     = -1                 unless defined $id;
    $pos    = wxDefaultPosition  unless defined $pos;
    $size   = wxDefaultSize      unless defined $size;
    $name   = ""                 unless defined $name;

    $style = wxTAB_TRAVERSAL
        unless defined $style;

    $self = $self->SUPER::new( $parent, $id, $pos, $size, $style, $name );
    
    $self->{main_sizer} = Wx::BoxSizer->new(wxHORIZONTAL);
    
    $self->{grid} = my_grid.MyGrid->new($self, wxID_ANY);
    $self->{grid}->CreateGrid(0, 1);
    $self->{grid}->SetRowLabelSize(0);
    $self->{grid}->SetColLabelSize(0);
    $self->{grid}->EnableEditing(0);
    $self->{grid}->EnableGridLines(0);
    $self->{grid}->EnableDragColSize(0);
    $self->{grid}->EnableDragRowSize(0);
    $self->{grid}->SetColLabelValue(0, "");
    $self->{main_sizer}->Add($self->{grid}, 1, wxEXPAND, 0);
    
    $self->SetSizer($self->{main_sizer});
    $self->{main_sizer}->Fit($self);
    
    $self->Layout();
    return $self;

}



1;

