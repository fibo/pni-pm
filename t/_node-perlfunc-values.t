use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Values;

my $values = PNI::Node::Perlfunc::Values->new;

isa_ok $values, 'PNI::Node::Perlfunc::Values';
is $values->label, 'values', 'label';

my $in  = $values->in;
my $out = $values->out;

$values->task;
is $out->data, undef, 'default task';

my %hash;
$hash{key1} = 1;
$hash{key2} = 1;
my @values1 = sort values %hash;
$values->in->data( \%hash );
$values->task;
my @values2 = sort @{ $values->out->data };
is_deeply \@values1, \@values2, 'out = values( in )';

$values->in->data('foo');
$values->task;
ok $values->is_off, 'node is off if not feeded with an hash';

