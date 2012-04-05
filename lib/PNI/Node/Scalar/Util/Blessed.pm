package    # Avoid PAUSE indexing.
  PNI::Node::Scalar::Util::Blessed;
use PNI::Node::Mo;
extends 'PNI::Node';

use Scalar::Util;

sub BUILD {
    my $self = shift;
    $self->label('blessed');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->out->data( Scalar::Util::blessed( $self->in->data ) );
}
1;

