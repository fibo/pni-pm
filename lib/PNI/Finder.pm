package PNI::Finder;
use PNI::Mo;

use Module::Pluggable
  search_path => 'PNI::Node',
  require     => 1,
  inner       => 0;

sub nodes {
    my @nodes = grep { $_->isa('PNI::Node') } shift->plugins;

    s/^PNI::Node::// foreach (@nodes);

    return @nodes;
}

1;

__END__

=head1 NAME

PNI::Finder - searches for available nodes

=head1 SYNOPSIS

    my $find = PNI::Finder->new;
    my @node_list = $find->nodes;

=head1 METHODS

=head2 nodes

    my @node_list = $find->nodes;

Returns a list of available PNI nodes, i.e. every package under the PNI::Node
namespace that is a valid PNI::Node, minus the leading 'PNI::Node::' string.

=cut

