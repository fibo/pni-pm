use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

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
