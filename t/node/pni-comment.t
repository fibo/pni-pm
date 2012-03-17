use strict;
use warnings;
use PNI::Node::PNI::Comment;
use Test::More tests => 1;

my $node = PNI::Node::PNI::Comment->new;
isa_ok $node, 'PNI::Node::PNI::Comment';

