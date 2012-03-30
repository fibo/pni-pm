package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Process_id;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('$PROCESS_ID');
    $self->out->data($$);
}

1;
