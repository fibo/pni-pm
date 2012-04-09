use strict;
use warnings;
use Test::More tests => 3;

use List::Util;
use PNI::Node::List::Util::Max;

my $node = PNI::Node::List::Util::Max->new;

isa_ok $node, 'PNI::Node::List::Util::Max';
is $node->label, 'max', 'label';

my @list = ( 1, 2, 3 );
$node->in->data( \@list );
$node->task;
is $node->out->data, List::Util::max(@list), 'max( @list )';

