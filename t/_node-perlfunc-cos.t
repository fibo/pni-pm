use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Cos;

my $node = PNI::Node::Perlfunc::Cos->new;

isa_ok $node, 'PNI::Node::Perlfunc::Cos';
is $node->label, 'cos', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(100);
my $b = cos($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = cos( in )';

$node->on;
$node->in->data('foo');
$node->task;
ok $node->is_off, 'node is off if not feeded with a number';

