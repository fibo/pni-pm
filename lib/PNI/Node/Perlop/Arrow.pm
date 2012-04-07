package    # Avoid PAUSE indexing.
  PNI::Node::Perlop::Arrow;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('->');

    $self->in('left_side');
    $self->in('right_side');
    $self->out;
}

sub task {
    my $self = shift;

    my $left_side  = $self->in('left_side');
    my $right_side = $self->in('right_side');

    $left_side->is_defined and $right_side->is_defined or return;

    my $left_side_data  = $left_side->data;
    my $right_side_data = $right_side->data;

    my $result;

    $result = eval { $left_side_data->$right_side_data };

    $self->out->data($result);
}

1;

