use strict;
use warnings;
use Test::More tests => 1;
use PNI::Node::PNI::Scenario;

my $node = PNI::Node::PNI::Scenario->new;
isa_ok $node,'PNI::Node::PNI::Scenario';

