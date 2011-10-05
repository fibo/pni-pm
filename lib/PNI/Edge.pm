package PNI::Edge;
use PNI::Mo;
extends 'PNI::Elem';
use PNI::Line;

has line   => ( default => sub { PNI::Line->new } );
has source => ( default => sub { } );
has target => ( default => sub { } );

sub BUILD {
my $self = shift;
$self->source->edges->add($self);
$self->target->edge($self);
}

sub task {
    my $self = shift;

    # Edge's task is to pass data from target to source.
    $self->target->data( $self->source->data );

    return 1;
}

1
__END__

=head1 NAME

PNI::Edge - is used to connect

=head1 SYNOPSIS

    # Connects the output of a node to the input of another node.
    my $edge = PNI::Edge->new( source => $output, target => $input );

=head1 ATTRIBUTES

=head2 line

=head2 source

=head2 target

=head1 METHODS

=head2 task

    $edge->task

If edge is connected, pass data from target to source.

=cut

