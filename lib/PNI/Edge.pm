package PNI::Edge;
use PNI::Mo;
extends 'PNI::Elem';

use PNI::Elem;

has source => ();
has target => ();

sub BUILD {
    my $self = shift;

    $self->source->edges->add($self);
    $self->target->edge($self);

    return;
}

sub by_id {
    my $elem = PNI::Elem::by_id(@_);

    if ( defined $elem and $elem->isa('PNI::Edge') ) {
        return $elem;
    }
    else {
        return;
    }
}

sub task {
    my $self = shift;

    # Edge's task is to pass data from target to source.
    $self->target->data( $self->source->data );

    return 1;
}

sub to_hashref {
    my $self = shift;

    return {
        id        => $self->id,
        source_id => $self->source->id,
        target_id => $self->target->id,
    };
}

1;

__END__

=head1 NAME

PNI::Edge - is used to connect

=head1 SYNOPSIS

    # Connects the output of a node to the input of another node.
    my $edge = PNI::Edge->new( source => $output, target => $input );

=head1 ATTRIBUTES

=head2 source

    my $out = $edge->source;

=head2 target

    my $in = $edge->target;

=head1 METHODS

=head2 by_id

    use PNI::Edge;

    my $edge = PNI::Edge::by_id($edge_id);

Given an edge id, returns a reference to the edge.

=head2 task

    $edge->task;

If edge is connected, pass data from target to source.

=head2 to_hashref

    my $edge_hashref = $edge->to_hashref;

Returns an hash ref representing the edge.

=cut

