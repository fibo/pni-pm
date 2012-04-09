use strict;
use warnings;
use Test::More tests => 3;

use List::Util;
use PNI::Node::List::Util::Minstr;

my $node = PNI::Node::List::Util::Minstr->new;

isa_ok $node, 'PNI::Node::List::Util::Minstr';
is $node->label, 'minstr', 'label';

my @list = qw( foo  bar );
$node->in->data( \@list );
$node->task;
is $node->out->data, List::Util::minstr(@list), 'minstr( @list )';

