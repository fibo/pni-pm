use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perldata::Array;

my $node = PNI::Node::Perldata::Array->new;

isa_ok $node, 'PNI::Node::Perldata::Array';
is $node->label, '@', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my @a = qw( foo bar );

$node->in->data( \@a );
$node->task;
is_deeply $node->out->data, \@a, 'out = in';

