package    # Avoid PAUSE indexing.
  PNI::GUI::Slot;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Elem;

sub get_data {
    my $self = shift;
    my $log  = $self->app->log;

    my $slot_id = $self->stash('slot_id');

    my $slot = PNI::Elem::by_id($slot_id);

    my $data = $slot->data||{};

    $self->render_json( $data );
}

sub set_data {
    my $self = shift;
    my $log  = $self->app->log;

    my $data = $self->req->param('data');

    my $slot_id = $self->stash('slot_id');

    my $slot = PNI::Elem::by_id($slot_id);

    $slot->data($data);

    $self->render_json( {},status => 201 );
}

1;

