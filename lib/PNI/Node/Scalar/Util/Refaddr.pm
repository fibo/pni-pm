package    # Avoid PAUSE indexing.
  PNI::Node::Scalar::Util::Refaddr;
use PNI::Node::Mo;
extends 'PNI::Node';

use Scalar::Util;

sub BUILD {
    my $self = shift;
    $self->label('refaddr');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->out->data( Scalar::Util::refaddr( $self->in->data ) );
}

1;

