use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use PNI::Out;
use Test::More tests => 3;

my $node = PNI::Node->new;
my $out = PNI::Out->new( node => $node );
isa_ok $out, 'PNI::Out';


is $out->is_connected, 0, 'default is_connected';

is $out->data, undef,'default data';

__END__

# create fake edges for tests
my $in1   = $node->add_input('in1');
my $out1  = $node->add_output('out1');
my $edge1 = PNI::Edge->new( source => $out1, target => $in1 );

my $in2   = $node->add_input('in2');
my $out2  = $node->add_output('out2');
my $edge2 = PNI::Edge->new( source => $out2, target => $in2 );

ok $slot->add_edge($edge1);
ok $slot->add_edge($edge2);

# at this point slot should be connected
is $slot->is_connected, 1;

my @edges1;
my @edges2;
@edges1 = sort ( $edge1, $edge2 );
@edges2 = sort $slot->get_edges;
is_deeply \@edges1, \@edges2;

isa_ok $out1->join_to($in1), 'PNI::Edge', 'join_to';

ok $slot->del_edge($edge1);
@edges1 = ( $edge2 );
@edges2 = sort $slot->get_edges;
is_deeply \@edges1, \@edges2;
ok $slot->del_edge($edge2);
is 0, $slot->get_edges;

