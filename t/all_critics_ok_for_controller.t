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

my @controller_files;

push @controller_files, File::Spec->catfile( 'lib', 'PNI', 'GUI.pm' );
push @controller_files, File::Spec->catfile( 'lib', 'PNI', 'GUI', "$_.pm" )
  for qw (
  Scenario
);

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + controller' );
critic_ok($_) for @controller_files;

ok @controller_files, 'found controller files';

done_testing;

