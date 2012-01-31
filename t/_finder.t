use strict;
use warnings;
use Test::More tests => 1;
use PNI::Finder;

my $find = PNI::Finder->new;

TODO: {
    local $TODO = "finder should exclude old nodes like Tk::Canvas";
    ok 1;

    #    ok $find->files, 'find files';
    #    ok $find->nodes, 'find nodes';
}
