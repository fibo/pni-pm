use strict;
use warnings;
use PNI::Scenario;
use Test::More tests => 23;

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

is $scenario->comments->list,  0, 'default comments';
is $scenario->nodes->list,     0, 'default nodes';
is $scenario->edges->list,     0, 'default edges';
is $scenario->scenarios->list, 0, 'default scenarios';

# Add a sub scenario.
my $scen = $scenario->new_scenario;
isa_ok $scen, 'PNI::Scenario', 'new_scenario';

# Add two nodes.
my $node1 = $scen->new_node;
isa_ok $node1, 'PNI::Node', 'new_node';
my $node2 = $scen->new_node;
is $scen->nodes->list, 2, 'nodes list';

# Connect nodes with an edge.
my $source1 = $node1->new_out('out');
my $target1 = $node2->new_in('in');

my $edge = $scen->new_edge( source => $source1, target => $target1 );
isa_ok $edge , 'PNI::Edge', 'new_edge';
is $scen->edges->list, 1, 'edges list';

my $comment1 = $scen->new_comment;
isa_ok $comment1, 'PNI::Comment', 'new_comment';
my $comment2 = $scen->new_comment;
is $scen->comments->list, 2, 'comments list';

$scen->del_comment($comment1);
ok !exists $scen->comments->{ $comment1->id }, 'del_comment';

# Create another node to have a chain like this:
# node1 --> node2 --> node3
my $node3   = $scen->new_node;
my $source2 = $node2->new_out('out');
my $target2 = $node3->new_in('in');
$scen->new_edge( source => $source2, target => $target2 );

# Delete node2: this should also delete its edges.
$scen->del_node($node2);
is $scen->nodes->list, 2, 'del_node';
is $scen->edges->list, 0, 'del_node cleans edges';

# TODO
# my $content = {roba presa da un .pni file}
# $scen->new_scenario($content);
# per ora faccio solo
$scen->new_scenario;

# Create another edge, then delete it.
my $edge2 = $scen->new_edge( source => $source1, target => $target2 );
$scen->del_edge($edge2);
ok !$source1->is_connected, 'del_edge cleans source';
ok !$target2->is_connected, 'del_edge cleans target';

# Add some test nodes, which output is twice of input,
# see below package PNI::Node::Test
my $n1 = $scen->new_node('Test');
my $n2 = $scen->new_node('Test');
my $n3 = $scen->new_node('Test');
my $n4 = $scen->new_node('Test');

$n1->get_in('in')->data(1);
$scen->new_edge( $n1 => $n2, 'out' => 'in' );
$scen->new_edge( $n2 => $n3, 'out' => 'in' );
$scen->new_edge( $n3 => $n4, 'out' => 'in' );
#$scen->task;
is $n4->get_out('out')->data, 8, 'task';

# Delete sub scenario.
$scenario->del_scenario($scen);
is $scenario->scenarios->list, 0, 'del_scenario';
is $scen->comments->list,      0, 'del_scenario cleans comments';
is $scen->edges->list,         0, 'del_scenario cleans edges';
is $scen->nodes->list,         0, 'del_scenario cleans nodes';
is $scen->scenarios->list,     0, 'del_scenario cleans scenarios';

package PNI::Node::Test;
use Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    my $in   = $self->new_in('in')->data(0);
    $self->new_out('out')->data(0);
}

sub task {
    my $self = shift;
    $self->get_out('out')->data( $self->get_in('in')->data * 2 );
}

