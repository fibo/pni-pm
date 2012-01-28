use strict;
use warnings;
use Test::More tests => 2;
use PNI::Node::Perlvar::Perl_version;

my $node = PNI::Node::Perlvar::Perl_version->new;
isa_ok $node, 'PNI::Node::Perlvar::Perl_version';

is $node->out->data, $^V;

