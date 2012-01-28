use strict;
use warnings;
use Test::More tests => 2;

use PNI::Node::Perlfunc::Print;

my $node = PNI::Node::Perlfunc::Print->new;

isa_ok $node, 'PNI::Node::Perlfunc::Print';
is $node->label, 'print', 'label';

