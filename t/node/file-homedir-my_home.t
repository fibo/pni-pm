use strict;
use warnings;
use Test::More tests => 3;

use File::HomeDir;
use PNI::Node::File::HomeDir::My_home;

my $node = PNI::Node::File::HomeDir::My_home->new;

isa_ok $node, 'PNI::Node::File::HomeDir::My_home';
is $node->label, 'Home', 'label';

is $node->out->data, File::HomeDir->my_home, 'out';

