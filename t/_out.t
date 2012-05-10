use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use PNI::Out;
use Test::More tests => 7;

my $node = PNI::Node->new;
my $out = PNI::Out->new( node => $node );
isa_ok $out, 'PNI::Out';

is $out->is_connected, 0, 'at creation, it is not connected';

my $in = $node->in;
my $edge = PNI::Edge->new( source => $out, target => $in );
is $out->is_connected, 1, 'is_connected';

my $out_id = $out->id;

is PNI::Out::by_id( $out_id ), $out, 'by_id';
is PNI::Out::by_id(-1), undef, 'by_id checks id';
is PNI::Out::by_id( $edge->id ), undef, 'by_id checks type';

$out->DESTROY;
is PNI::Out::by_id($out_id),undef, 'DESTROY';

