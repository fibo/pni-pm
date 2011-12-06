use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use PNI::In;
use Test::More tests => 4;

my $node = PNI::Node->new;
my $in = PNI::In->new( node => $node );
isa_ok $in, 'PNI::In';

is $in->edge,         undef, 'at creation, edge is undef';
is $in->is_connected, 0,     'at creation, it is not connected';

my $out = $node->out;
my $edge = PNI::Edge->new( source => $out, target => $in );
is $in->is_connected, 1, 'is_connected';

