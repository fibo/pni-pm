package    # Avoid PAUSE indexing.
  PNI::Node::Perlop::Multiplication;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('*');

    $self->in(1);
    $self->in(2);
    $self->out;
}

sub task {
    my $self = shift;

    my $in1 = $self->in(1);
    my $in2 = $self->in(2);

    $in1->is_number and $in2->is_number or return;

    $self->out->data( $in1->data * $in2->data );
}

1;

