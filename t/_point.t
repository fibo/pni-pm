use strict;
use warnings;
use Test::More tests => 2;
use PNI::Point;

my $point = PNI::Point->new;

is $point->x,0,'default x';
is $point->y,0,'default y';

