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

