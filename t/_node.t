use strict;
use warnings;
use Test::More tests => 15;
use PNI::Node;

my $node = PNI::Node->new;
isa_ok $node, 'PNI::Node';

is $node->get_ins_edges,  0,           'default get_ins_edges';
is $node->get_outs_edges, 0,           'default get_outs_edges';
is $node->type,           'PNI::Node', 'default type';
is $node->parents,        0,           'default parents';

ok my $in = $node->new_in('in'), 'new_in';
isa_ok $in, 'PNI::In';
is $in, $node->get_in('in'), 'get_in';

ok my $out = $node->new_out('out'), 'new_out';
isa_ok $out, 'PNI::Out';
is $out, $node->get_out('out'), 'get_out';

my $root = PNI::Node->new( type => 'PNI::Root' );
is $root->type, 'PNI::Root', 'type';

my ( $x, $y ) = ( 100, 150 );
ok $root->translate( $x, $y ), 'translate';
is $root->box->center->x, $x, 'box center x';
is $root->box->center->y, $y, 'box center y';

