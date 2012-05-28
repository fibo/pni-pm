use strict;
use warnings;
use File::Find;
use File::Spec;
use Test::More;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

#Test::Perl::Critic->require  or plan( skip_all => 'PNI::Devel tests' );
#Perl::Critic::Bangs->require or plan( skip_all => 'PNI::Devel tests' );

my @test_files;

find(
    {
        wanted => sub {
            push @test_files, $_ if m/\.t$/;
        },
        no_chdir => 1
    },
    't'
);

my $rcfile = File::Spec->catfile( 'xt', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + tests' );
critic_ok($_) for @test_files;

ok @test_files, 'found test files';

done_testing;

