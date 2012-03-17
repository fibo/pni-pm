use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Exp;

my $node = PNI::Node::Perlfunc::Exp->new;

isa_ok $node, 'PNI::Node::Perlfunc::Exp';
is $node->label, 'exp', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(5);
my $b = exp($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = exp( in )';

$node->on;
$node->in->data('foo');
$node->task;
ok $node->is_off, 'node is off if not feeded with a number';

