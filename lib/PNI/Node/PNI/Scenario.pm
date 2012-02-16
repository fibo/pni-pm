package    # Avoid PAUSE indexing.
  PNI::Node::PNI::Scenario;
use PNI::Node::Mo;
extends 'PNI::Node';

use PNI;

sub BUILD {
    my $self = shift;
    $self->in('object');
    $self->out('comments');
    $self->out('edges');
    $self->out('father')->data(PNI::root);
    $self->out('nodes');
    $self->out('scenarios');
}

sub task {
    my $self = shift;

    my $object = $self->in('object')->data or return;
    $object->isa('PNI::Scenario') or return;

    $self->out('comments')->data( $object->comments );
    $self->out('edges')->data( $object->edges );
    $self->out('nodes')->data( $object->nodes );
    $self->out('scenarios')->data( $object->scenarios );
}

1
