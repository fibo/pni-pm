use strict;
use warnings;
use Test::More;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

eval "use Test::Pod 1.00";

if ($@) {
    my $msg = 'Test::Pod required to check pod files';
    plan( skip_all => $msg );
}

all_pod_files_ok();

