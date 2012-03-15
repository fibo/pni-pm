use strict;
use warnings;
use Test::More tests => 3;

use File::Spec;
use PNI::Node::File::Spec::Tmpdir;

my $node = PNI::Node::File::Spec::Tmpdir->new;

isa_ok $node, 'PNI::Node::File::Spec::Tmpdir';
is $node->label, 'tmpdir', 'label';

my $tmpdir = File::Spec->tmpdir;
is $node->out->data, $tmpdir, 'tmpdir';

