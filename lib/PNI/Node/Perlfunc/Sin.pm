package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Sin;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('sin');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_number or return $self->off;

    $out->data( sin( $in->data ) );
}

1;

