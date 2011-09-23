use strict;
use warnings;
use Test::More tests => 1;
use PNI::Node;
use PNI::Slot;

my $node = PNI::Node->new;
my $slot = PNI::Slot->new( node => $node, name => 'slot_test' );
isa_ok $slot, 'PNI::Slot';

done_testing
__END__

is $slot->is_changed, 0;
$slot->set_data(1);
is $slot->is_changed, 1;
$slot->set_data;
is $slot->is_changed, 1;

ok $slot->set_data(1), 'set_data 1';
is $slot->get_data, 1, 'get_data 1';
is $slot->get_type , 'SCALAR' , 'get_type';
ok $slot->is_scalar , 'is_scalar';
ok $slot->is_number , 'is_number';

ok $slot->set_data(0), 'set_data 0';
is $slot->get_data, 0, 'get_data 0';
is $slot->get_type , 'SCALAR' , 'get_type';
ok $slot->is_scalar , 'is_scalar';
ok $slot->is_number , 'is_number';

ok $slot->set_data(''), 'set_data \'\'';
is $slot->get_data, '', 'get_data \'\'';
is $slot->get_type , 'SCALAR' , 'get_type';
ok $slot->is_scalar , 'is_scalar';
ok $slot->is_string , 'is_string';

ok $slot->set_data('abc'), 'set_data \'abc\'';
is $slot->get_data, 'abc', 'get_data \'abc\'';
is $slot->get_type , 'SCALAR' , 'get_type';
ok $slot->is_scalar , 'is_scalar';
ok $slot->is_string , 'is_string';

ok $slot->set_data(undef), 'set_data undef';
is $slot->get_data, undef, 'get_data undef';
is $slot->get_type , 'UNDEF' , 'get_type';
ok $slot->is_undef , 'is_undef';

my @a = qw(foo bar);
my $a_ref = \@a;
ok $slot->set_data($a_ref), 'set_data array';
is $slot->get_data, $a_ref, 'get_data array';
is $slot->get_type , 'ARRAY' , 'get_type';
ok $slot->is_array , 'is_array';

my %h;
$h{foo}='bar';
my $h_ref = \%h;
ok $slot->set_data($h_ref), 'set_data hash';
is $slot->get_data, $h_ref, 'get_data hash';
is $slot->get_type , 'HASH' , 'get_type';
ok $slot->is_hash , 'is_hash';

