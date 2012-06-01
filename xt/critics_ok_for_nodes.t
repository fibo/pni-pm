use strict;
use warnings;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

use File::Find;
use File::Spec;
use Perl::Critic::Bangs;
use Test::More;
use Test::Perl::Critic;

my @node_dirs;
my @node_files;

push @node_dirs, File::Spec->catfile( 'lib', 'PNI', 'Node' );
push @node_dirs, File::Spec->catfile( 't',   'PNI', 'Node' );

find(
    {
        wanted => sub {
            return if m/Mo\.pm$/;
            push @node_files, $_ if m/\.pm$/;
        },
        no_chdir => 1
    },
    @node_dirs
);

my $rcfile = File::Spec->catfile( 'xt', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + nodes' );
critic_ok($_) for @node_files;

ok @node_files, 'found node files';
ok @node_dirs,  'found node dirs';

done_testing;

