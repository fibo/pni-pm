use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlop::Division;

my $node = PNI::Node::Perlop::Division->new;

isa_ok $node, 'PNI::Node::Perlop::Division';
is $node->label, '/', 'label';

my $in1 = $node->in(1);
my $in2 = $node->in(2);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my ( $a, $b, $c );    # a / b = c
$a = rand(100);
$b = rand(100) + 1;
$c = $a / $b;

$in1->data($a);
$in2->data($b);
$node->task;
is $out->data, $c, 'a/b=c';

$in2->data(0);
$node->task;
is $out->data, undef, 'a/0 is undef';

