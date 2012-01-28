use strict;
use warnings;
use Test::More tests => 6;

use PNI::Node::Perlfunc::Log;

my $node = PNI::Node::Perlfunc::Log->new;

isa_ok $node, 'PNI::Node::Perlfunc::Log';
is $node->label, 'log', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(100);
my $b = log($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = log( in )';

$node->on;
$node->in->data('foo');
$node->task;
ok $node->is_off, 'node is off if not feeded with a number';

$node->on;
$node->in->data(-1);
$node->task;
ok $node->is_off, 'node is off if not feeded with a positive number';

