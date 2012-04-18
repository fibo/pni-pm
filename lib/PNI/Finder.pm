package PNI::Finder;
use PNI::Mo;

use File::Basename;
use File::Find;
use File::Spec;

my $pni_dir          = File::Basename::dirname(__FILE__);
my $pni_node_dir     = File::Spec->catfile( $pni_dir, 'Node' );
my $pni_scenario_dir = File::Spec->catfile( $pni_dir, 'Scenario' );

sub nodes {
    my @pni_nodes;

    find(
        {
            wanted => sub {
                return unless /\.pm$/;
                my $node_path = $File::Find::name;
                $node_path =~ s!/!::!g;
                push @pni_nodes, $node_path;
            },
            no_chdir => 1,
        },
        $pni_node_dir
    );

    return @pni_nodes;
}

sub files {
    my @pni_files;

    find(
        {
            wanted => sub {
                return unless /\.pni$/;
                push @pni_files, $File::Find::name;
            },
            no_chdir => 1,
        },
        $pni_scenario_dir
    );

    return @pni_files;
}

1;

__END__

=head1 NAME

PNI::Finder - searches for available nodes

=head1 SYNOPSIS

    my $find = PNI::Finder->new;
    my @node_list = $find->nodes;
    my @pni_files = $find->files;

=head1 METHODS

=head2 files

    my @pni_files = $find->files;

Returns a list of available .pni files, i.e. serialized scenarios.

=head2 nodes

    my @node_list = $find->nodes;

Returns a list of available PNI nodes, i.e. every package under the PNI::Node
namespace that is a valid PNI::Node, minus the leading 'PNI::Node::' string.

=cut

