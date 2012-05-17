package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Scalar;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('scalar');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $out->data( scalar( $in->data ) );
}

1;

