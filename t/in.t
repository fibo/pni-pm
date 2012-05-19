use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use PNI::In;
use Test::More tests => 8;

my $node = PNI::Node->new;
my $in = PNI::In->new( node => $node );
isa_ok $in, 'PNI::In';

is $in->edge,         undef, 'at creation, edge is undef';
is $in->is_connected, 0,     'at creation, it is not connected';

my $out = $node->out;
my $edge = PNI::Edge->new( source => $out, target => $in );
is $in->is_connected, 1, 'is_connected';

my $in_id = $in->id;

is PNI::In::by_id($in_id), $in, 'by_id';
is PNI::In::by_id(-1), undef, 'by_id checks id';
is PNI::In::by_id( $node->id ), undef, 'by_id checks type';

$in->DESTROY;
is PNI::In::by_id($in_id), undef, 'DESTROY';

