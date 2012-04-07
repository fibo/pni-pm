package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Uc;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('uc');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_string or return $self->off;

    $out->data( uc( $in->data ) );
}

1;

