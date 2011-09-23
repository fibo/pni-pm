use strict;
use warnings;
use Test::More tests => 2;
use PNI::Rectangle;

my $rectangle = PNI::Rectangle->new;
isa_ok $rectangle,'PNI::Rectangle';

ok $rectangle->translate(10,10);

