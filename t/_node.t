use strict;
use warnings;
use Test::More tests => 27;
use PNI;
use PNI::Node;

my $node = PNI::Node->new;
isa_ok $node, 'PNI::Node';

is $node->get_ins_edges,  0,           'default get_ins_edges';
is $node->get_outs_edges, 0,           'default get_outs_edges';
is $node->label,          '',          'default label';
is $node->type,           'PNI::Node', 'default type';
is $node->parents,        0,           'default parents';
ok $node->is_on,          'node is_on by default';

ok my $in = $node->in, 'in constructor';
is $in->id, 'in', 'default in id';
isa_ok $in, 'PNI::In';
is $in, $node->in, 'in accessor';

ok my $out = $node->out, 'out constructor';
is $out->id, 'out', 'default out id';
isa_ok $out, 'PNI::Out';
is $out, $node->out, 'out accessor';

my $in1 = $node->in(1);
isa_ok $in1, 'PNI::In', 'in(number)';
is $in1->id, 'in1', 'in1';

my $out2 = $node->out(2);
isa_ok $out2, 'PNI::Out', 'out(number)';
is $out2->id, 'out2', 'out2';

my $node_x = $node->box->center->x;
my $node_y = $node->box->center->y;
my $in_x   = $in->box->center->x;
my $in_y   = $in->box->center->y;
my $out_x  = $out->box->center->x;
my $out_y  = $out->box->center->y;
my ( $dx, $dy ) = ( 100, 150 );
$node->translate( $dx, $dy );
is $node->box->center->x, $node_x + $dx, 'box center x';
is $node->box->center->y, $node_y + $dy, 'box center y';
is $in->box->center->x,   $in_x + $dx,   'in center x';
is $in->box->center->y,   $in_y + $dy,   'in center y';
is $out->box->center->x,  $out_x + $dx,  'out center x';
is $out->box->center->y,  $out_y + $dy,  'out center y';

my $scen = PNI::root;

my $node1 = $scen->new_node;
my $node2 = $scen->new_node;
my $node3 = $scen->new_node;

my $node1_out = $node1->out;
my $node2_in  = $node2->in;
my $node2_out = $node2->out;
my $node3_in1 = $node3->in('in1');
my $node3_in2 = $node3->in('in2');

my $edge1 = $scen->new_edge( source => $node1_out, target => $node2_in );
my $edge2 = $scen->new_edge( source => $node1_out, target => $node3_in1 );
my $edge3 = $scen->new_edge( source => $node2_out, target => $node3_in2 );

my @outs_edges1 = sort $node1->get_outs_edges;
my @outs_edges2 = sort $edge1, $edge2;
is_deeply \@outs_edges1, \@outs_edges2, 'get_outs_edges';

my @ins_edges1 = sort $node3->get_ins_edges;
my @ins_edges2 = sort $edge2, $edge3;
is_deeply \@ins_edges1, \@ins_edges2, 'get_ins_edges';

