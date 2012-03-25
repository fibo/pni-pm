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

my @model_files;

push @model_files, File::Spec->catfile( 'lib', 'PNI.pm' );
push @model_files, File::Spec->catfile( 'lib', 'PNI', "$_.pm" ) for qw (
  Node
  Scenario
  Slot
);

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + tests' );
critic_ok($_) for @model_files;

ok @model_files, 'found model files';

done_testing;

