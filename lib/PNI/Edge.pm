package PNI::Edge;
use Mo;
extends 'PNI::Elem';
use PNI::Line;

has line   => ( default => sub { PNI::Line->new } );
has source => ( default => sub { } );
has target => ( default => sub { } );

sub is_connected {
    my $self = shift;
    $self->source && $self->target ? return 1 : return 0;
}

sub task {
    my $self = shift;

    # Nothing to do if there is no source.
    my $source = $self->source or return 1;

    # Nothing to do if there is no target.
    my $target = $self->target or return 1;

    # Edge's task is to pass data from target to source.
    $target->data( $source->data );

    return 1;
}

1
__END__

=head1 NAME

PNI::Edge - is used to connect

=head1 SYNOPSIS

    # Connects the output of a node to the input of another node.
    my $edge = PNI::Edge->new( source => $output, target => $input );

    my $not_connected_edge = PNI::Edge->new;

=head1 ATTRIBUTES

=head2 line

=head2 source

=head2 target

=head1 METHODS

=head2 is_connected

If source and target are defined return 1, otherwise 0.

=head2 task

    $edge->task

If edge is connected, pass data from target to source.

=cut

