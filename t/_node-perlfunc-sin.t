use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Sin;

my $node = PNI::Node::Perlfunc::Sin->new;

isa_ok $node, 'PNI::Node::Perlfunc::Sin';
is $node->label, 'sin', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(100);
my $b = sin($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = sin( in )';

$node->on;
$node->in->data('foo');
$node->task;
ok $node->is_off, 'node is off if not feeded with a number';

