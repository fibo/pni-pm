use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Subtraction;

my $node = PNI::Node::Perlop::Subtraction->new;

isa_ok $node, 'PNI::Node::Perlop::Subtraction';
is $node->label, '-', 'label';

my $in1 = $node->in(1);
my $in2 = $node->in(2);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my ( $a, $b, $c );
$a = -rand(100);
$b = rand(100);
$c = $a - $b;

$in1->data($a);
$in2->data($b);
$node->task;
is $out->data, $c, 'a-b=c';

