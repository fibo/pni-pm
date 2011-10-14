use strict;
use warnings;
use Test::More tests => 2;
use PNI::Finder;

my $find = PNI::Finder->new;

ok $find->files, 'find files';

ok $find->nodes, 'find nodes';

