use strict;
use warnings;
use PNI::Scenario;
use Test::More tests => 26;

# Use some test nodes, under t/PNI/Node path.
use lib 't';

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

is $scenario->nodes->list,     0, 'default nodes';
is $scenario->edges->list,     0, 'default edges';
is $scenario->scenarios->list, 0, 'default scenarios';

# Add a sub scenario.
my $scen = $scenario->add_scenario;
isa_ok $scen, 'PNI::Scenario', 'add_scenario';

# Empty.pm is a dummy node.
my $node1 = $scen->add_node('Empty');
isa_ok $node1, 'PNI::Node', 'add_node';
my $node2 = $scen->add_node('Empty');
is $scen->nodes->list, 2, 'nodes list';

# Connect nodes with an edge.
my $source1 = $node1->out;
my $target1 = $node2->in;

my $edge = $scen->add_edge( source => $source1, target => $target1 );
isa_ok $edge , 'PNI::Edge', 'add_edge';
is $scen->edges->list, 1, 'edges list';

# Create another node to have a chain like this:
# node1 --> node2 --> node3
my $node3   = $scen->add_node('Empty');
my $source2 = $node2->out;
my $target2 = $node3->in;
$scen->add_edge( source => $source2, target => $target2 );

# Delete node2: this should also delete its edges.
$scen->del_node($node2);
is $scen->nodes->list, 2, 'del_node';
is $scen->edges->list, 0, 'del_node cleans edges';

# Create another edge, then delete it.
my $edge2 = $scen->add_edge( source => $source1, target => $target2 );
$scen->del_edge($edge2);
ok !$source1->is_connected, 'del_edge cleans source';
ok !$target2->is_connected, 'del_edge cleans target';

# Twice.pm is a node which output is twice of its input.
my $n1 = $scen->add_node('Twice');
my $n2 = $scen->add_node('Twice');
my $n3 = $scen->add_node('Twice');
my $n4 = $scen->add_node('Twice');

is $n1->type, 'Twice', 'node type';

my $i1 = $n1->in;
my $o1 = $n1->out;
my $i2 = $n2->in;
my $o2 = $n2->out;
my $i3 = $n3->in;
my $o3 = $n3->out;
my $i4 = $n4->in;
my $o4 = $n4->out;

my $num = rand(100);
$i1->data($num);

$scen->add_edge( source => $o1, target => $i2 );
$scen->add_edge( source => $o2, target => $i3 );
$scen->add_edge( source => $o3, target => $i4 );

$scen->task;

is $o4->data, 16 * $num, 'task';

# Again, starting with 1.
$i1->data(1);

# Turning off n3 ...
$n3->off;

$scen->task;

# ... n4 should be off
ok !$n4->is_on, 'n4 is off cause n3 is off';
is $o1->data, 2, 'o1';
is $o2->data, 4, 'o2';
is $o3->data, 8 * $num,  'o3 has the same data';
is $o4->data, 16 * $num, 'o4 has the same data';

# Delete sub scenario.
$scenario->del_scenario($scen);
is $scenario->scenarios->list, 0, 'del_scenario';
is $scen->edges->list,         0, 'del_scenario cleans edges';
is $scen->nodes->list,         0, 'del_scenario cleans nodes';
is $scen->scenarios->list,     0, 'del_scenario cleans scenarios';

# Error.pm is a node which sub task returns undef.
my $error = $scen->add_node('Error');
ok $error->is_on, 'error node is on by default';
$scen->task;
ok $error->is_off, 'after its task run, error node is off';

