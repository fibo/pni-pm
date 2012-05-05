use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perldata::Scalar;

my $node = PNI::Node::Perldata::Scalar->new;

isa_ok $node, 'PNI::Node::Perldata::Scalar';
is $node->label, '$', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = rand(100);

$node->in->data($a);
$node->task;
is $node->out->data, $a, 'out = in';

