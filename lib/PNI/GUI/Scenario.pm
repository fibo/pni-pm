package    # Avoid PAUSE indexing.
  PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Scenario;

my $scen = PNI::Scenario->new;

sub add_edge {
    my $self = shift;

    my $source_node_id = $self->req->param('sourceNodeId');
    my $target_node_id = $self->req->param('targetNodeId');

    my $source_out_id = $self->req->param('sourceOutId');
    my $target_in_id  = $self->req->param('targetInId');

    my $source_node = $scen->elem->{$source_node_id};
    my $target_node = $scen->elem->{$target_node_id};

    # TODO my $edge = $scen->add_edge() ...

#TODO: prova my $edge = $scen->{$id}->add_edge($self->req->param);
# MA NON SI PUO FARE SE MODEL E VIEW HANNO case DIVERSI (uno camel e l' altro no)

    #$self->render_json( $edge->to_hash );
}

sub add_node {
    my $self = shift;

    my $type = $self->req->param('type');
    my $x    = $self->req->param('x');
    my $y    = $self->req->param('y');

    my $node = $scen->add_node( $type, x => $x, y => $y );

#TODO: prova my $node = $scen->{$id}->add_node($self->req->param);
# MA NON SI PUO FARE SE MODEL E VIEW HANNO case DIVERSI (uno camel e l' altro no)

    $self->render_json( $node->to_hash );
}

sub to_json {
    my $self = shift;

    # TODO aggiungi info sulla view, tipo posizioni dei nodi e altro
    # il PNI::File non deve essere del PNI::Scenario, ma del controller.
    my $scen_to_hash = $scen->to_hash;

    $self->render_json($scen_to_hash);

}

1;

