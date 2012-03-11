use strict;
use warnings;
use Test::More tests => 3;

use File::Spec;
use PNI::Node::File::Spec::Devnull;

my $node = PNI::Node::File::Spec::Devnull->new;

isa_ok $node, 'PNI::Node::File::Spec::Devnull';
is $node->label, 'devnull', 'label';

my $devnull = File::Spec->devnull;
is $node->out->data, $devnull, 'devnull';

