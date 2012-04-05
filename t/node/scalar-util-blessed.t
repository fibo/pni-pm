use strict;
use warnings;
use Test::More tests => 4;

use File::Spec;
use PNI::Node::Scalar::Util::Blessed;

my $node = PNI::Node::Scalar::Util::Blessed->new;

isa_ok $node, 'PNI::Node::Scalar::Util::Blessed';
is $node->label, 'blessed', 'label';

my $str = 'Foo';
$node->in->data($scalar);
$node->task;
is $node->out->data, undef, 'blessed $str';

my $obj = bless [], 'Foo';
$node->in->data($obj);
$node->task;
is $node->out->data, 'Foo', 'blessed $object';

