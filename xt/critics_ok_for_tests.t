use strict;
use warnings;
use File::Find;
use File::Spec;
use Perl::Critic::Bangs;
use Test::More;
use Test::Perl::Critic;

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

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + tests' );
critic_ok($_) for @test_files;

ok @test_files, 'found test files';

done_testing;

