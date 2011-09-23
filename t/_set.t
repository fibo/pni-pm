use strict;
use warnings;
use Test::More tests => 2;
use PNI::Elem;
use PNI::Set;

my $set = PNI::Set->new;

my $elem1 = PNI::Elem->new;
my $elem2 = PNI::Elem->new;

ok $set->add($elem1);
ok $set->add($elem2);

