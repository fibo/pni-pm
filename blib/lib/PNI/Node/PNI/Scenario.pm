package PNI::Node::PNI::Scenario;
use Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->new_in('object');
    $self->new_out('comments');
    $self->new_out('edges');
    $self->new_out('nodes');
    $self->new_out('scenarios');
}

sub task {
    my $self = shift;

    my $object = $self->get_in('object')->data or return;
    $object->isa('PNI::Scenario') or return;

    $self->get_out('comments')->data( $object->comments );
    $self->get_out('edges')->data( $object->edges );
    $self->get_out('nodes')->data( $object->nodes );
    $self->get_out('scenarios')->data( $object->scenarios );

}

1
__END__

