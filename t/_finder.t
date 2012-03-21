use strict;
use warnings;
use Test::More tests => 3;
use PNI::Finder;

my $find = PNI::Finder->new;

ok $find->nodes,      'find nodes';

TODO: {
    local $TODO = "finder should exclude old nodes like Tk::Canvas";
    ok 1;

    #    ok $find->files, 'find files';
}

