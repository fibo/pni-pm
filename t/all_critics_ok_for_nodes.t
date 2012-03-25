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

my @node_dirs;
my @node_files;

push @node_dirs, File::Spec->catfile( 'lib', 'PNI', 'Node' );
push @node_dirs, File::Spec->catfile( 't', 'PNI', 'Node' );

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

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile, -theme => 'all + nodes' );
critic_ok($_) for @node_files;

ok @node_files, 'found node files';
ok @node_dirs,  'found node dirs';

done_testing;

