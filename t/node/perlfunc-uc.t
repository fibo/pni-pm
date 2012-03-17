use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Uc;

my $node = PNI::Node::Perlfunc::Uc->new;

isa_ok $node, 'PNI::Node::Perlfunc::Uc';
is $node->label, 'uc', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = 'foo';
my $b = uc($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = uc( in )';

$node->on;
$node->in->data(10);
$node->task;
ok $node->is_off, 'node is off if not feeded with a string';

