use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Keys;

my $keys = PNI::Node::Perlfunc::Keys->new;

isa_ok $keys, 'PNI::Node::Perlfunc::Keys';
is $keys->label, 'keys', 'label';

my $in  = $keys->in;
my $out = $keys->out;

$keys->task;
is $out->data, undef, 'default task';

my %hash;
$hash{key1} = 1;
$hash{key2} = 1;
my @keys1 = sort keys %hash;
$keys->in->data( \%hash );
$keys->task;
my @keys2 = sort @{ $keys->out->data };
is_deeply \@keys1, \@keys2, 'out = keys( in )';

$keys->in->data('foo');
$keys->task;
ok $keys->is_off, 'node is off if not feeded with an hash';

