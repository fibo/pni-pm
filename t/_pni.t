use strict;
use warnings;
use PNI ':-D';
use Test::More tests => 2;

my $node1 = node;
isa_ok $node1 , 'PNI::Node';

my $node2 = node;
$node1->new_out('out');
$node2->new_in('in');
my $edge = edge $node1 => $node2,'out'=>'in';
isa_ok $edge,'PNI::Edge';


