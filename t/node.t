use strict;
use warnings;
use Test::More tests => 28;
use PNI;
use PNI::Node;
use PNI::Scenario;

# Use some test nodes, under t/PNI/Node path.
use lib 't';

my $node = PNI::Node->new;
isa_ok $node, 'PNI::Node';

is $node->get_ins_edges,  0,     'default get_ins_edges';
is $node->get_outs_edges, 0,     'default get_outs_edges';
is $node->label,          undef, 'default label';
is $node->type,           undef, 'default type';
is $node->x,              undef, 'default x';
is $node->y,              undef, 'default y';
ok !$node->is_off, 'node is_off is false by default';
ok $node->is_on, 'node is_on by default';

ok my $in = $node->in, 'in constructor';
is $in->label, 'in', 'default in label';
isa_ok $in, 'PNI::In';
is $in, $node->in, 'in accessor';

ok my $out = $node->out, 'out constructor';
is $out->label, 'out', 'default out label';
isa_ok $out, 'PNI::Out';
is $out, $node->out, 'out accessor';

my $type  = 'Foo';
my $label = 'bar';
my $x     = 10;
my $y     = 20;
$node->label($label);
$node->type($type);
$node->x($x);
$node->y($y);

my $node_id = $node->id;

my @ins_to_hashref;
my @outs_to_hashref;

#$in1->data( [qw(foo bar)] );
#$out2->data( { foo => 'bar' } );

push @ins_to_hashref, $in->to_hashref;

#push @ins_to_hashref,  $in1->to_hashref;
push @outs_to_hashref, $out->to_hashref;

#push @outs_to_hashref, $out2->to_hashref;

is_deeply $node->to_hashref,
  {
    id    => $node_id,
    label => $label,
    ins   => \@ins_to_hashref,
    outs  => \@outs_to_hashref,
    type  => $type,
    x     => $x,
    y     => $y,
  },
  'to_hashref';

my $in1 = $node->in(1);
isa_ok $in1, 'PNI::In', 'in(number)';
is $in1->label, 'in1', 'in(number) label';

my $out2 = $node->out(2);
isa_ok $out2, 'PNI::Out', 'out(number)';
is $out2->label, 'out2', 'out(number) label';

is PNI::Node::by_id($node_id), $node, 'by_id';
is PNI::Node::by_id(-1), undef, 'by_id checks id';
is PNI::Node::by_id( $in1->id ), undef, 'by_id checks type';

$node->DESTROY;
is undef, PNI::Node::by_id($node_id), 'DESTROY';

my $scen = PNI::Scenario->new;

my $node1 = $scen->add_node('Empty');
my $node2 = $scen->add_node('Empty');
my $node3 = $scen->add_node('Empty');

my $node1_out = $node1->out;
my $node2_in  = $node2->in;
my $node2_out = $node2->out;
my $node3_in1 = $node3->in('in1');
my $node3_in2 = $node3->in('in2');

my $edge1 = $scen->add_edge( source => $node1_out, target => $node2_in );
my $edge2 = $scen->add_edge( source => $node1_out, target => $node3_in1 );
my $edge3 = $scen->add_edge( source => $node2_out, target => $node3_in2 );

my @outs_edges1 = sort $node1->get_outs_edges;
my @outs_edges2 = sort $edge1, $edge2;
is_deeply \@outs_edges1, \@outs_edges2, 'get_outs_edges';

my @ins_edges1 = sort $node3->get_ins_edges;
my @ins_edges2 = sort $edge2, $edge3;
is_deeply \@ins_edges1, \@ins_edges2, 'get_ins_edges';

