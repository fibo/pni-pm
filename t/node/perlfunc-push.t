use strict;
use warnings;
use Test::More tests => 2;

use PNI::Node::Perlfunc::Push;

my $node = PNI::Node::Perlfunc::Push->new;

isa_ok $node, 'PNI::Node::Perlfunc::Push';
is $node->label, 'push', 'label';

