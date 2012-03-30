use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Numerically_not_equal;

my $node = PNI::Node::Perlop::Numerically_not_equal->new;

isa_ok $node, 'PNI::Node::Perlop::Numerically_not_equal';
is $node->label, '!=', 'label';

my $in1 = $node->in(1);
my $in2 = $node->in(2);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(100);

$in1->data($a);
$in2->data($a);
$node->task;
ok !$out->data, 'a!=a';

