use strict;
use warnings;
use Test::More tests => 1;
use PNI::Line;

my $line = PNI::Line->new;
isa_ok $line , 'PNI::Line';

