package    # Avoid PAUSE indexing.
  PNI::Node::Perlop::Arrow;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('->');

    $self->in('left');
    $self->in('right');
    $self->out;
}

sub task {
    my $self = shift;

    my $left  = $self->in('left');
    my $right = $self->in('right');

    $left->is_defined and $right->is_defined or return;

    my $left_data  = $left->data;
    my $right_data = $right->data;

    my $result;

    $result = eval { $left_data->$right_data };

    $self->out->data($result);
}

1
