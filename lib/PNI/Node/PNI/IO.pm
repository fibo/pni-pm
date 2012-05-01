package    # Avoid PAUSE indexing.
  PNI::Node::PNI::IO;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $out->data( $in->data );
}

1;

