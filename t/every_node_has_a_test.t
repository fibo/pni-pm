use strict;
use warnings;
use Test::More;
use File::Spec;
use PNI::Finder;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

my $find = PNI::Finder->new;

for my $node_type ( $find->nodes ) {

    # Naming convention for test of PNI::Node::Foo::Bar is foo-bar.t,
    #
    # for example:
    #
    #     PNI::Node::Perlop::And         --> perlop-and.t
    #     PNI::Node::Perlvar::Process_id --> perlvar-process_id.t
    #
    # and all node tests are in t/node/ folder.

    my $node_test = $node_type;
    $node_test =~ s/::/-/g;
    $node_test = lc "$node_test.t";
    my $test_path = File::Spec->catfile( 't', 'node', $node_test );
    ok -e $test_path, "$node_type has a test";
}

done_testing

