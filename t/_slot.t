use strict;
use warnings;
use Test::More tests => 17;
use PNI::Slot;

my $slot = PNI::Slot->new;
isa_ok $slot, 'PNI::Slot';

is $slot->data, undef, 'default data';
is $slot->node, undef, 'default node';

is $slot->type, 'UNDEF', 'UNDEF type';
ok $slot->is_undef, 'is_undef';

$slot->data('scalar');
is $slot->type, 'SCALAR', 'SCALAR type';
ok $slot->is_scalar, 'is_scalar';
ok $slot->is_string, 'is_string';

$slot->data(1);
ok $slot->is_number, 'is_number';

$slot->data(0);
is $slot->type, 'SCALAR', 'zero is a SCALAR';
ok $slot->is_defined, 'is_defined';

my $array = [];
$slot->data($array);
is $slot->type, ref $array, 'ARRAY type';
ok $slot->is_array, 'is_array';

my $hash = {};
$slot->data($hash);
is $slot->type, ref $hash, 'HASH type';
ok $slot->is_hash, 'is_hash';

my $code = sub { };
$slot->data($code);
is $slot->type, ref $code, 'CODE type';
ok $slot->is_code, 'is_code';

