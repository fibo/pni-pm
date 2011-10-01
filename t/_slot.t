use strict;
use warnings;
use Test::More tests => 2;
use PNI::Slot;

my $slot = PNI::Slot->new;
isa_ok $slot, 'PNI::Slot';

is $slot->data, undef, 'default data';

