use strict;
use warnings;
use Test::More tests => 3;
use PNI::Node::Perlvar::Basetime;

my $node = PNI::Node::Perlvar::Basetime->new;
isa_ok $node, 'PNI::Node::Perlvar::Basetime';

is $node->label, '$BASETIME', 'label';

is $node->out->data, $^T, 'var';

