package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Push;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('push');

    $self->in(1);
    $self->in(2);
    $self->in('do_print');

    $self->out;
}

sub task {
    my $self     = shift;
    my $in1      = $self->in(1);
    my $in2      = $self->in(2);
    my $do_print = $self->do_print;
    my $out      = $self->out;

    my $array = $in1->data;
    my $list  = $in2->data;

    if ( $do_print->data ) {

        $out->data( push @{$array}, @{$list} );

        $do_print->data(0);
    }
}

1;

