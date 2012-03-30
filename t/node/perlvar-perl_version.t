use strict;
use warnings;
use Test::More tests => 3;
use PNI::Node::Perlvar::Perl_version;

my $node = PNI::Node::Perlvar::Perl_version->new;
isa_ok $node, 'PNI::Node::Perlvar::Perl_version';

is $node->label, '$PERL_VERSION', 'label';

is $node->out->data, $^V, 'var';

