use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Arrow;

my $node = PNI::Node::Perlop::Arrow->new;

isa_ok $node, 'PNI::Node::Perlop::Arrow';
is $node->label, '->', 'label';

my $left_side  = $node->in('left_side');
my $right_side = $node->in('right_side');
my $out        = $node->out;

$node->task;
is $out->data, undef, 'default task';

# See package Foo below.
my $foo = Foo->new;

$left_side->data($foo);
$right_side->data('bar');

$node->task;

is $out->data, 'quz', '$foo->bar';

package Foo;
sub new { bless {}, 'Foo' }
sub bar { return 'quz' }

