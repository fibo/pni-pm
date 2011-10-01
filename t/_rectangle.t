use strict;
use warnings;
use Test::More tests => 1;
use PNI::Rectangle;

my $rectangle = PNI::Rectangle->new;
isa_ok $rectangle,'PNI::Rectangle';

