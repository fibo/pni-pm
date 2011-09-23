use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use PNI::In;
use Test::More tests => 3;

my $node = PNI::Node->new;
my $in = PNI::In->new( node => $node );
isa_ok $in, 'PNI::In';

is $in->is_connected, 0, 'at creation, it is not connected';

my $edge = PNI::Edge->new;
$in->edge($edge);
is $in->is_connected, 1, 'is connected';

__END__

isa_ok $slot->join_to($node->add_output('out2')), 'PNI::Edge', 'join_to';


