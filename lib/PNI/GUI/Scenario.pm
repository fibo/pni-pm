package    # Avoid PAUSE indexing.
  PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Scenario;
use PNI::Set;

my $model = PNI::Set->new;
my $root = PNI::Scenario->new( id => 'root' );

$model->add($root);

sub add_edge {
    my $self = shift;

    my $scenario_id = $self->stash('scenario_id');
    my $scenario    = $model->elem->{$scenario_id};

    my $source_id = $self->req->param('sourceId');
    my $target_id = $self->req->param('targetId');

    my $source;    # TODO
    my $target;

    my $edge = $scenario->add_edge( source => $source, target => $target );

    $self->render_json( $edge->to_hash );
}

sub add_node {
    my $self = shift;

    my $scenario_id = $self->stash('scenario_id');
    my $scenario    = $model->elem->{$scenario_id};

    my $type = $self->req->param('type');
    my $x    = $self->req->param('x');
    my $y    = $self->req->param('y');

    my $node = $scenario->add_node( $type, x => $x, y => $y );

    $self->render_json( $node->to_hash );
}

sub create {
    my $self = shift;

    my $scenario = PNI::Scenario->new;
    $model->add($scenario);

    $self->render_json( { id => $scenario->id } );
}

sub to_json {
    my $self = shift;

    my $scenario_id = $self->stash('scenario_id');
    my $scenario    = $model->elem->{$scenario_id};

    # TODO aggiungi info sulla view, tipo posizioni dei nodi e altro
    # il PNI::File non deve essere del PNI::Scenario, ma del controller.

    $self->render_json( $scenario->to_hash );
}

1;

