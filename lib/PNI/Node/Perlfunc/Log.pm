package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Log;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('log');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_number or return $self->off;
    ( $in->data >= 0 ) or return $self->off;

    $out->data( log( $in->data ) );
}

1;

