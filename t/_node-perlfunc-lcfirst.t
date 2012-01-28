use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Lcfirst;

my $node = PNI::Node::Perlfunc::Lcfirst->new;

isa_ok $node, 'PNI::Node::Perlfunc::Lcfirst';
is $node->label, 'lcfirst', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = 'FOO';
my $b = lcfirst($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = lcfirst( in )';

$node->on;
$node->in->data(10);
$node->task;
ok $node->is_off, 'node is off if not feeded with a string';

