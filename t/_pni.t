use strict;
use warnings;
use PNI ':root';
use Test::More tests => 3;

my $node1 = node;
isa_ok $node1 , 'PNI::Node';

my $node2 = node;
$node1->out;
$node2->in;
my $edge = edge $node1 => $node2, 'out' => 'in';
isa_ok $edge, 'PNI::Edge';

my $scen = PNI::scen;
isa_ok $scen, 'PNI::Scenario';

