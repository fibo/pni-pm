package    # Avoid PAUSE indexing.
  PNI::Node::Perlop::Numerically_not_equal;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('!=');

    $self->in(1);
    $self->in(2);
    $self->out;
}

sub task {
    my $self = shift;

    my $in1 = $self->in(1);
    my $in2 = $self->in(2);

    $in1->is_defined and $in2->is_defined or return;

    $self->out->data( $in1->data != $in2->data );
}

1
