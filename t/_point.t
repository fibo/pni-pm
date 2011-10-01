use strict;
use warnings;
use Test::More tests => 4;
use PNI::Point;

my $point = PNI::Point->new;

is $point->x,0,'default x';
is $point->y,0,'default y';

my($x,$y)=(10,20);
my($dx,$dy)=(100,150);
$point->x($x);
$point->y($y);
$point->translate($dx,$dy);
is $point->x,$x+$dx,'translate x';
is $point->y,$y+$dy,'translate y';

