use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Arrow;

my $node = PNI::Node::Perlop::Arrow->new;

isa_ok $node, 'PNI::Node::Perlop::Arrow';
is $node->label, '->', 'label';

my $left  = $node->in('left');
my $right = $node->in('right');
my $out   = $node->out;

$node->task;
is $out->data, undef, 'default task';

# See package Foo below.
my $foo = Foo->new;

$left->data($foo);
$right->data('bar');

$node->task;

is $out->data, 'quz', '$foo->bar';

package Foo;
sub new { bless {}, 'Foo' }
sub bar { return 'quz' }

