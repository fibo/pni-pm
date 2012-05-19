use strict;
use warnings;
use Test::More tests => 3;
use PNI::Elem;

my $elem = PNI::Elem->new;

ok $elem->id, 'id';

my $id = $elem->id;
is_deeply $elem, PNI::Elem::by_id($id), 'PNI::Elem::by_id';

$elem->DESTROY;
is PNI::Elem::by_id($id), undef, 'DESTROY';

