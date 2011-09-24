use strict;
use warnings;
use PNI::Scenario;
use Test::More tests => 4;

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

# Add two nodes.
my $node1 = $scenario->new_node;
isa_ok $node1, 'PNI::Node';

my $node2 = $scenario->new_node;
isa_ok $node2, 'PNI::Node';

# Connect nodes with an edge.
my $source = $node1->new_out('out');
my $target = $node2->new_in('in');

my $edge   = $scenario->new_edge( source => $source, target => $target, );
isa_ok $edge , 'PNI::Edge';

__END__

# Add a scenario.
my $scenario2 = $scenario->add_scenario;
isa_ok $scenario2, 'PNI::Scenario';

my $node3 = $scenario2->add_node;

my @scenarios = ($scenario2);
my @get_scenarios = $scenario->get_scenarios;
is_deeply \@scenarios, \@get_scenarios;

# remove sub scenario
ok $scenario->del_scenario($sub_scenario);

# $sub_scenario was deleted from $scenario so now should be without nodes
is 0, $sub_scenario->get_nodes;

# scenario does not contain sub scenarios again
is 0, $scenario->get_scenarios;

ok $scenario->del_node($node1);

# the edge connecting node1 and node2 now is deleted
is 0, $node1->get_output_edges;
is 0, $node2->get_input_edges;
ok $scenario->del_node($node2);

# now $scenario is empty
is 0, $scenario->get_nodes;

