package    # Avoid PAUSE indexing.
  PNI::Node::Perlop::Not;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('not');

    $self->in(1);
    $self->out;
}

sub task {
    my $self = shift;

    my $in1 = $self->in(1);

    $in1->is_defined or return;

    $self->out->data( !$in1->data );
}

1
