use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Or;

my $node = PNI::Node::Perlop::Or->new;

isa_ok $node, 'PNI::Node::Perlop::Or';
is $node->label, 'or', 'label';

my $in1 = $node->in(1);
my $in2 = $node->in(2);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my ( $a, $b, $c );
$a = 0;
$b = 1;
$c = ( $a or $b );

$in1->data($a);
$in2->data($b);
$node->task;
is $out->data, $c, 'a or b = c';

