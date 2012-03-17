use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Not;

my $node = PNI::Node::Perlop::Not->new;

isa_ok $node, 'PNI::Node::Perlop::Not';
is $node->label, 'not', 'label';

my $in1 = $node->in(1);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my ( $a, $b, $c );
$a = 0;
$c = not $a;

$in1->data($a);
$node->task;
is $out->data, $c, 'c = not a';

