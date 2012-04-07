package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Lcfirst;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('lcfirst');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_string or return $self->off;

    $out->data( lcfirst( $in->data ) );
}

1;

