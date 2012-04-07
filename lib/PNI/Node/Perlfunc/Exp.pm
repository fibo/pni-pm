package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Exp;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('exp');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_number or return $self->off;

    $out->data( exp( $in->data ) );
}

1;

