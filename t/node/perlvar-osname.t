use strict;
use warnings;
use Test::More tests => 3;
use PNI::Node::Perlvar::Osname;

my $node = PNI::Node::Perlvar::Osname->new;
isa_ok $node, 'PNI::Node::Perlvar::Osname';

is $node->label, '$OSNAME', 'label';

is $node->out->data, $^O, 'var';

