use strict;
use warnings;
use PNI::Node::PNI::Node;
use Test::More tests => 2;

my $node = PNI::Node::PNI::Node->new;
isa_ok $node, 'PNI::Node::PNI::Node';

is $node->label, 'node', 'default label';

