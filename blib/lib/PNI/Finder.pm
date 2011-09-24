package PNI::Finder;
use Mo;
use File::Basename;
use File::Find;
use Module::Pluggable
  search_path => 'PNI::Node',
  require     => 1,
  inner       => 0;

my $PNI_dir = File::Basename::dirname(__FILE__);

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
        $PNI_dir
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

=head1 METHODS

=head2 files

=head2 nodes

    $find->nodes

Returns a list of available PNI nodes, i.e. every package under the PNI::Node
namespace that is a valid PNI::Node, minus the leading 'PNI::Node::' string.

=cut

