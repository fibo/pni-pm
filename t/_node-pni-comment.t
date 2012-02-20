use strict;
use warnings;
use PNI;
use PNI::Node::PNI::Comment;
use Test::More tests => 2;

my $node = PNI::Node::PNI::Root->new;

my $object = $node->out('object');

isa_ok $object, 'PNI::Comment';

