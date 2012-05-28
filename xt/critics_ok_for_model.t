use strict;
use warnings;
use File::Find;
use File::Spec;
use Test::More;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

#Test::Perl::Critic->require  or plan( skip_all => 'PNI::Devel tests' );
#Perl::Critic::Bangs->require or plan( skip_all => 'PNI::Devel tests' );

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

my $rcfile = File::Spec->catfile( 'xt', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + model' );
critic_ok($_) for @model_files;

ok @model_files, 'found model files';

done_testing;

