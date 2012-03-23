package PNI::GUI::Root;
use Mojo::Base 'Mojolicious::Controller';

use PNI;

sub to_json {
    my $self = shift;

    my $root_to_hash = PNI::root->to_hash;

    $self->render_json( $root_to_hash );

}

1;

