package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Int;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('int');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_number or return $self->off;

    $out->data( int( $in->data ) );
}

1;

