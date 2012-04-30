package    # Avoid PAUSE indexing.
  PNI::Node::Scalar::Util::Reftype;
use PNI::Node::Mo;
extends 'PNI::Node';

use Scalar::Util;

sub BUILD {
    my $self = shift;
    $self->label('reftype');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->out->data( Scalar::Util::reftype( $self->in->data ) );
}

1;

