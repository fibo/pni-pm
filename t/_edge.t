use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use PNI::In;
use PNI::Out;
use Test::More tests => 4;

my $edge = PNI::Edge->new;
isa_ok $edge, 'PNI::Edge';

is $edge->is_connected, 0, 'default is_connected';

my $node   = PNI::Node->new;
my $source = PNI::In->new( name => 'out', node => $node );
my $target = PNI::Out->new( name => 'in', node => $node );

my $edge2 = PNI::Edge->new( source => $source, target => $target );
isa_ok $edge2, 'PNI::Edge';

is $edge2->is_connected, 1;

