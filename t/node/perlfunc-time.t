use strict;
use warnings;
use Test::More tests => 2;

use PNI::Node::Perlfunc::Time;

my $node = PNI::Node::Perlfunc::Time->new;

isa_ok $node, 'PNI::Node::Perlfunc::Time';
is $node->label, 'time', 'label';

my $update  = $node->in('update');
my $out = $node->out;

$node->task;

# TODO fai un time e vedi che il time del nodo e' maggiore

