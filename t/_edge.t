use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use Test::More tests => 4;

my $node   = PNI::Node->new;
my $source = $node->out;
my $target = $node->in;

my $edge = PNI::Edge->new( source => $source, target => $target );
isa_ok $edge, 'PNI::Edge';

is_deeply \( $source->edges->list ), \($edge), 'source edges';
is $target->edge, $edge, 'target edge';

is_deeply $edge->to_hashref,
  { id => $edge->id, source_id => $source->id, target_id => $target->id, },
  'to_hashref';

