package    # Avoid PAUSE indexing.
  PNI::Node::Scalar::Util::Looks_like_number;
use PNI::Node::Mo;
extends 'PNI::Node';

use Scalar::Util;

sub BUILD {
    my $self = shift;
    $self->label('looks_like_number');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->out->data( Scalar::Util::looks_like_number( $self->in->data ) );
}

1;


