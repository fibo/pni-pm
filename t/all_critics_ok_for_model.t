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

my @model_files;

push @model_files, File::Spec->catfile( 'lib', 'PNI.pm' );
push @model_files, File::Spec->catfile( 'lib', 'PNI', $_ . '.pm' ) for qw (
  Edge
  Elem
  Finder
  In
  Node
  Out
  Scenario
  Set
  Slot
);

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + model' );
critic_ok($_) for @model_files;

ok @model_files, 'found model files';

done_testing;

