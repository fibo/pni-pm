use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

my @no_index_files;
my @no_index_dirs = (
    File::Spec->catfile(qw(lib PNI Node)),
    File::Spec->catfile(qw(lib PNI GUI))
);

# Find all PNI nodes.
find(
    {
        wanted => sub {
            return unless $_ =~ m/\.pm/;
            return if $_ eq 'Mo.pm';
            push @no_index_files, $File::Find::name;
        },
        chdir => 0
    },
    @no_index_dirs
);

for (@no_index_files) {
    open( my $fh, '<', $_ ) or die "Unable to open $_\n";
    my @rows = <$fh>;
    ok $rows[0] =~ /^package\s*\#/, "$_ avoids PAUSE indexing";
    close $fh;
}

done_testing
