package PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use PNI;

my $scen = {};    # TODO my $scen = PNI::Set->new;

$scen->{'root'} = PNI::root;

sub add_node {
    my $self = shift;

    my $type = $self->req->param('type');
    my $x    = $self->req->param('x');
    my $y    = $self->req->param('y');

    # TODO poi prendilo dalla route,per ora e' fisso
    my $id = 'root';
    my $node = $scen->{$id}->add_node( $type, x => $x, y => $y );

    #TODO: prova my $node = $scen->{$id}->add_node($self->req->param);

    $self->render_json( $node->to_hash );
}

sub to_json {
    my $self = shift;

    # TODO poi prendilo dalla route,per ora e' fisso
    my $id = 'root';

    # TODO aggiungi info sulla view, tipo posizioni dei nodi e altro
    # il PNI::File non deve essere del PNI::Scenario, ma del controller.
    my $scen_to_hash = $scen->{$id}->to_hash;

    $self->render_json($scen_to_hash);

}

1;

