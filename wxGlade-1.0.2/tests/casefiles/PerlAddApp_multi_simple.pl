#!/usr/bin/perl -w --
#
# generated by wxGlade "faked test version"
#
# To get wxPerl visit http://www.wxperl.it
#

# This is an automatically generated file.
# Manual changes will be overwritten without warning!

use Wx qw[:allclasses];
use strict;
1;

package main;

use MyAppFrame;

unless(caller){
    local *Wx::App::OnInit = sub{1};
    my $myapp = Wx::App->new();
    Wx::InitAllImageHandlers();

    my $appframe = MyAppFrame->new();

    $myapp->SetTopWindow($appframe);
    $appframe->Show(1);
    $myapp->MainLoop();
}
