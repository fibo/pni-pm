use strict;
use warnings;
use Test::More tests => 3;

use List::Util;
use PNI::Node::List::Util::Maxstr;

my $node = PNI::Node::List::Util::Maxstr->new;

isa_ok $node, 'PNI::Node::List::Util::Maxstr';
is $node->label, 'maxstr', 'label';

my @list = qw( foo bar );
$node->in->data( \@list );
$node->task;
is $node->out->data, List::Util::maxstr(@list), 'maxstr( @list )';


