package    # Avoid PAUSE indexing.
  PNI::Node::Perldata::Scalar;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;

    $self->label('$');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->out->data( $self->in->data );
}

1;

