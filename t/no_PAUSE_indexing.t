use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

my @no_indexed;

find(
    {
        wanted => sub {
            return unless $_ =~ m/\.pm/;
            push @no_indexed, $File::Find::name;
        },
        chdir => 0
    },
    File::Spec->catfile(qw(lib PNI Node))
);

push @no_indexed, qw(PNI::Mo);

TODO: {
    local $TODO = "unindex me";
    for (@no_indexed) {
        ok 1;
        print $_;

        #open my $fh, '<', $_;
        #my @rows = <$fh>;
        #is $rows[0], 'package # avoid PAUSE indexing';
        #close $fh;
    }
}

done_testing
