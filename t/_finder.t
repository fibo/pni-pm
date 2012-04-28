use strict;
use warnings;
use Test::More tests => 1;
use PNI::Finder;

my $find = PNI::Finder->new;

ok $find->nodes, 'find nodes';

