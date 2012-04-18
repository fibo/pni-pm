use strict;
use warnings;
use File::Find;
use File::Spec;
use Test::More;
require UNIVERSAL::require;

if ( not $ENV{TEST_AUTHOR} ) {

    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run';
    plan( skip_all => $msg );

}

for my $module (qw( Test::Perl::Critic Perl::Critic::Bangs )) {

    my $msg = "$module required to run tests";
    $module->require or plan( skip_all => $msg );

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

