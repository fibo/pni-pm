use strict;
use warnings;
use Test::More tests => 1;
use PNI::Elem;

my $elem = PNI::Elem->new;

ok $elem->id,'id';

