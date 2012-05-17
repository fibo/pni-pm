use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perldata::Hash;

my $node = PNI::Node::Perldata::Hash->new;

isa_ok $node, 'PNI::Node::Perldata::Hash';
is $node->label, '%', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my %h = qw( foo bar );

$node->in->data( \%h );
$node->task;
is_deeply $node->out->data, \%h, 'out = in';


