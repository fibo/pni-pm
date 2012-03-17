use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::And;

my $node = PNI::Node::Perlop::And->new;

isa_ok $node, 'PNI::Node::Perlop::And';
is $node->label, 'and', 'label';

my $in1 = $node->in(1);
my $in2 = $node->in(2);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my ( $a, $b, $c );
$a = 1;
$b = 0;
$c = ($a and $b);

$in1->data($a);
$in2->data($b);
$node->task;
is $out->data, $c, 'a and b = c';

