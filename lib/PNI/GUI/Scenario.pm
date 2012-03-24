package PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use PNI;

my $scen = {}; # TODO my $scen = PNI::Set->new;

$scen->{'root'} = PNI::root;

sub to_json {
    my $self = shift;

    # TODO poi prendilo dalla route,per ora e' fisso
    my $id = 'root';

    # TODO aggiungi info sulla view, tipo posizioni dei nodi e altro
    # il PNI::File non deve essere del PNI::Scenario, ma del controller.
    my $scen_to_hash = $scen->{$id}->to_hash;

    $self->render_json( $scen_to_hash );

}

1;


