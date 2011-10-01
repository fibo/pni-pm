use strict;
use warnings;
use PNI::Scenario;
use Test::More tests => 12;

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

is $scenario->comments->list,  0, 'default comments';
is $scenario->nodes->list,     0, 'default nodes';
is $scenario->edges->list,     0, 'default edges';
is $scenario->scenarios->list, 0, 'default scenarios';

# Add two nodes.
my $node1 = $scenario->new_node;
isa_ok $node1, 'PNI::Node', 'new_node';
my $node2 = $scenario->new_node( type => 'PNI::Root' );
is $scenario->nodes->list, 2, 'nodes list';

# Connect nodes with an edge.
my $source = $node1->new_out('out');
my $target = $node2->new_in('in');

my $edge = $scenario->new_edge( source => $source, target => $target );
isa_ok $edge , 'PNI::Edge', 'new_edge';
is $scenario->edges->list, 1, 'edges list';

# Add a comment.
my $comment1 = $scenario->new_comment;
isa_ok $comment1, 'PNI::Comment', 'new_comment';
my $comment2 = $scenario->new_comment;
is $scenario->comments->list, 2, 'comments list';

# Add a sub scenario.
my $scen = $scenario->new_scenario;
isa_ok $scen, 'PNI::Scenario', 'new_scen';

__END__

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

