use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Int;

my $node = PNI::Node::Perlfunc::Int->new;

isa_ok $node, 'PNI::Node::Perlfunc::Int';
is $node->label, 'int', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(100);
my $b = int($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'b = int( a )';

$node->on;
$node->in->data('foo');
$node->task;
ok $node->is_off, 'node is off if not feeded with a number';

