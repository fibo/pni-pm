use strict;
use warnings;
use Test::More tests => 3;

use PNI::Node::Perlfunc::Time;

my $now = time;
my $node = PNI::Node::Perlfunc::Time->new;

isa_ok $node, 'PNI::Node::Perlfunc::Time';
is $node->label, 'time', 'label';

my $update  = $node->in('update');
my $out = $node->out;

sleep 1;

$update->bang(1);

$node->task;

cmp_ok $out->data,'>=',$now;

