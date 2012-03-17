use strict;
use warnings;
use Test::More tests => 3;

use File::Spec;
use PNI::Node::File::Spec::Catfile;

my $node = PNI::Node::File::Spec::Catfile->new;

isa_ok $node, 'PNI::Node::File::Spec::Catfile';
is $node->label, 'catfile', 'label';

my @directories = qw( foo bar );
my $filename    = 'quz';
$node->in('directories')->data( \@directories );
$node->in('filename')->data($filename);
$node->task;
my $path = File::Spec->catfile( @directories, $filename );
is $node->out('path')->data, $path, 'path';

