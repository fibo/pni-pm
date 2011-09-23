use strict;
use warnings;
use Test::More tests => 11;
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

