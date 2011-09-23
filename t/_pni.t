use strict;
use warnings;
use PNI ':-D';
use Test::More tests => 1;

my $node = node;
isa_ok $node , 'PNI::Node';

__END__

my $node2 = node;
$node->add_output('out');
$node2->add_input('in');

my $edge = edge $node => $node2, 'out' => 'in';
isa_ok $edge , 'PNI::Edge';

# Inject a fake task method, since it is abstract.
package PNI::Node;
no warnings 'redefine';
sub task {1}

package main;

ok task;


