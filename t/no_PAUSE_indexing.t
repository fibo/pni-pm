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

# Find all PNI nodes.
find(
    {
        wanted => sub {
            return unless $_ =~ m/\.pm/;
            return if $_ eq 'Mo.pm';
            push @no_indexed, $File::Find::name;
        },
        chdir => 0
    },
    File::Spec->catfile(qw(lib PNI Node))
);

for (@no_indexed) {
    open( my $fh, '<', $_ ) or die "Unable to open $_\n";
    my @rows = <$fh>;
    ok $rows[0] =~ /^package\s*\#/, "$_ avoids PAUSE indexing";
    close $fh;
}

done_testing
