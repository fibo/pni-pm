use strict;
use warnings;
use File::Find;
use File::Spec;
use Test::More;
use English qw(-no_match_vars);

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run';
    plan( skip_all => $msg );
}

eval { require Test::Perl::Critic; };

if ($EVAL_ERROR) {
    my $msg = 'Test::Perl::Critic required to criticise code';
    plan( skip_all => $msg );
}

# TODO usa universal require e ciclo for
eval { require Perl::Critic::Bangs; };

if ($EVAL_ERROR) {
    my $msg = 'Perl::Critic::Bangs required to criticise code';
    plan( skip_all => $msg );
}

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

