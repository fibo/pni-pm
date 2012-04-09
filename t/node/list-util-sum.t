use strict;
use warnings;
use Test::More tests => 3;

use List::Util;
use PNI::Node::List::Util::Sum;

my $node = PNI::Node::List::Util::Sum->new;

isa_ok $node, 'PNI::Node::List::Util::Sum';
is $node->label, 'sum', 'label';

my @list = ( 1, 2, 3 );
$node->in->data( \@list );
$node->task;
is $node->out->data, List::Util::sum(@list), 'sum( @list )';

