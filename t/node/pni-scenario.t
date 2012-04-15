use strict;
use warnings;
use Test::More tests => 3;
use PNI;
use PNI::Node::PNI::Scenario;

my $node = PNI::Node::PNI::Scenario->new;
isa_ok $node, 'PNI::Node::PNI::Scenario';

is $node->label, 'scenario', 'default label';

my $node1 = PNI::node 'PNI::Scenario';
is $node1->out('father')->data, PNI::root, 'father is root';

