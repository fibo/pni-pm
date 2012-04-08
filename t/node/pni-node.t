use strict;
use warnings;
use PNI::Node::PNI::Node;
use Test::More tests => 1;

my $node = PNI::Node::PNI::Node->new;
isa_ok $node, 'PNI::Node::PNI::Node';


