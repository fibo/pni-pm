use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Print;

my $node = PNI::Node::Perlfunc::Print->new;

isa_ok $node, 'PNI::Node::Perlfunc::Print';
is $node->label, 'print', 'label';

my $filehandle = $node->in('filehandle');
my $list       = $node->in('list');
my $do_print   = $node->in('do_print');

is $filehandle->data, undef, 'default filehandle';
is $list->data,       undef, 'default list';
is $do_print->data,   undef, 'default do_print';

