use strict;
use warnings;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

use File::Find;
use File::Spec;
use Perl::Critic::Bangs;
use Test::More;
use Test::Perl::Critic;

my @controller_files;

push @controller_files, File::Spec->catfile( 'lib', 'PNI', 'GUI.pm' );
push @controller_files, File::Spec->catfile( 'lib', 'PNI', 'GUI', "$_.pm" )
  for qw (
  Edge
  Node
  Scenario
  Slot
);

my $rcfile = File::Spec->catfile( 'xt', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + controller' );
critic_ok($_) for @controller_files;

ok @controller_files, 'found controller files';

done_testing;

