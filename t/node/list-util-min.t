use strict;
use warnings;
use Test::More tests => 3;

use List::Util;
use PNI::Node::List::Util::Min;

my $node = PNI::Node::List::Util::Min->new;

isa_ok $node, 'PNI::Node::List::Util::Min';
is $node->label, 'min', 'label';

my @list = ( 1, 2, 3 );
$node->in->data( \@list );
$node->task;
is $node->out->data, List::Util::min(@list), 'min( @list )';


