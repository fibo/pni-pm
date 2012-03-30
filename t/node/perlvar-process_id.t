use strict;
use warnings;
use Test::More tests => 3;
use PNI::Node::Perlvar::Process_id;

my $node = PNI::Node::Perlvar::Process_id->new;
isa_ok $node, 'PNI::Node::Perlvar::Process_id';

is $node->label, '$PROCESS_ID', 'label';

is $node->out->data, $$, 'var';

