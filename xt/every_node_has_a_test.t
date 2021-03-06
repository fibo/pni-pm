use strict;
use warnings;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

use File::Find;
use File::Spec;
use Test::More;

done_testing;

__END__

find(
    {
        wanted => sub {

            # Consider only Perl modules.
            return unless /\.pm$/;

            # Skip Mo wrappers.
            return if /Mo\.pm$/;

# Naming convention for test of lib/PNI/Node/Foo/Bar.pm module is t/node/foo-bar.t,
#
# for example:
#
#     lib/PNI/Node/Perlop/And.pm         --> t/node/perlop-and.t
#     lib/PNI/Node/Perlvar/Process_id.pm --> t/node/perlvar-process_id.t
#

            # TODO vedi come fare , devo togliere lib/PNI/Node in maniera cross paltform.
            my $node_path = File::Spec->splitdir($File::Find::dir),$File::Find::name;

            # Turn module path into test path.
            my $node_test = $node_path;
            $node_test =~ s/\.pm$//;
            $node_test =~ s/\//-/g;
            $node_test = lc "$node_test.t";

            my $test_path = File::Spec->catfile( 't', 'node', $node_test );
            ok -e $test_path, "$node_path has a test";

        },
        follow   => 0,
        no_chdir => 1
    },
    File::Spec->catfile(qw(lib PNI Node))
);


