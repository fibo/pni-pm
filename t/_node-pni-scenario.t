use strict;
use warnings;
use Test::More tests => 2;
use PNI::Node::PNI::Scenario;

my $node = PNI::Node::PNI::Scenario->new;
isa_ok $node,'PNI::Node::PNI::Scenario';

ok $node->task, 'default task';

