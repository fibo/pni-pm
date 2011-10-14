package PNI::Finder;
use PNI::Mo;
use File::Basename;
use File::Find;
use File::Spec;
use Module::Pluggable
  search_path => 'PNI::Node',
  require     => 1,
  inner       => 0;

my $PNI_dir = File::Basename::dirname(__FILE__);
my $PNI_Scenario_dir = File::Spec->catfile($PNI_dir,'Scenario');

# return @nodes : PNI::Node
sub nodes {
    my @nodes = grep { $_->isa('PNI::Node') } shift->plugins;

    s/^PNI::Node::// foreach (@nodes);

    return @nodes;
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
        $PNI_Scenario_dir
    );

    return @pni_files;
}

1
__END__

=head1 NAME

PNI::Finder - searches for available nodes

=head1 SYNOPSIS

    my $find = PNI::Finder->instance;
    my @node_list = $find->nodes;
    my @pni_files = $find->files;

=head1 METHODS

=head2 files

=head2 nodes

    $find->nodes

Returns a list of available PNI nodes, i.e. every package under the PNI::Node
namespace that is a valid PNI::Node, minus the leading 'PNI::Node::' string.

=cut

