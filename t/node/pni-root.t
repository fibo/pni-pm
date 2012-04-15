use strict;
use warnings;
use PNI;
use PNI::Node::PNI::Root;
use Test::More tests => 4;

my $node = PNI::Node::PNI::Root->new;
isa_ok $node, 'PNI::Node::PNI::Root';

is $node->label, 'root', 'default label';

my $object = $node->out('object');

isa_ok $object, 'PNI::Out';

is $object->data, PNI::root, 'root data';

