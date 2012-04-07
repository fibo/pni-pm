package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Ucfirst;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('ucfirst');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_string or return $self->off;

    $out->data( ucfirst( $in->data ) );
}

1;

