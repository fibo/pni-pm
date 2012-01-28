use strict;
use warnings;
use Test::More;
use File::Spec;
use PNI;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

for my $node_type ( PNI::node_list() ) {

    # Naming convention for test of PNI::Node::Foo::Bar is _node-foo-bar.t,
    #
    # for example:
    #
    #     PNI::Node::Perlop::And         --> _node-perlop-and.t
    #     PNI::Node::Perlvar::Process_id --> _node-perlvar-process_id.t

    my $node_test = $node_type;
    $node_test =~ s/::/-/g;
    $node_test = lc "_node-$node_test.t";
    my $test_path = File::Spec->catfile( 't', $node_test );
    ok -e $test_path, "$node_type has a test";
}

done_testing

