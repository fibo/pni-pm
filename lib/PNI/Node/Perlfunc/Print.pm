package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Print;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('print');

    $self->in('filehandle');
    $self->in('list');
    $self->in('do_print');
    $self->out('return_code');
}

sub task {
    my $self = shift;
    my $list = $self->in('list');
    my $rc   = $self->out('return_code');

    $rc->data( print @{ $list->data } )
      or return $self->off;
}

1;

