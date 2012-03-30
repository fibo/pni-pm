package PNI::Scenario;
use PNI::Mo;
extends 'PNI::Node';

use PNI::Edge;
use PNI::File;
use PNI::Node;
use PNI::Set;

require UNIVERSAL::require;

has edges     => ( default => sub { PNI::Set->new } );
has nodes     => ( default => sub { PNI::Set->new } );
has scenarios => ( default => sub { PNI::Set->new } );

has file => ( default => sub { PNI::File->new } );

sub add_edge {
    my $self = shift;
    my $edge = PNI::Edge->new(@_);
    return $self->edges->add($edge);
}

sub add_node {
    my $self = shift;

    my $type = shift;
    my $node;

    if ($type) {

        my $node_class = "PNI::Node::$type";

    # Code to require a node, before using UNIVERSAL::required looked like this.
    #        my $node_path  = "$node_class.pm";
    #        $node_path =~ s/::/\//g;
    #        eval { require $node_path };

        $node_class->require or return;

        $node = $node_class->new( father => $self, type => $type );
    }
    else {

        # If type is not provided return a dummy node.
        $node = PNI::Node->new( father => $self );

    }

    # TODO: Set input data, if any
    #while ( my ( $slot_name, $slot_data ) = each %{ $arg->{inputs} or {} } ) {
    #    $node->get_input($slot_name)->set_data($slot_data);
    #}

    return $self->nodes->add($node);
}

sub add_scenario {
    my $self     = shift;
    my $scenario = PNI::Scenario->new(@_);
    return $self->scenarios->add($scenario);
}

sub del_edge {
    my $self = shift;
    my $edge = shift or return;

    $edge->source->edges->del($edge);
    $edge->target->edge(undef);

    return $self->edges->del($edge);
}

sub del_node {
    my $self = shift;
    my $node = shift or return;

    $self->del_edge($_) for $node->get_ins_edges;
    $self->del_edge($_) for $node->get_outs_edges;

    return $self->nodes->del($node);
}

sub del_scenario {
    my $self = shift;
    my $scenario = shift or return;

    # Clean up all items contained in the scenario.

    # Deleting a node deletes also the edges connected to it.
    $scenario->del_node($_) for $scenario->nodes->list;

    $scenario->del_scenario($_) for $scenario->scenarios->list;

    return $self->scenarios->del($scenario);
}

sub task {

    # Here we go, this is one of the most important PNI subs.
    my $self = shift;

    # Do nothing it scenario is off.
    return if $self->is_off;

    # Let remember if a node run its task.
    my %has_run_task_of;

  RUN_TASKS:

    for my $node ( $self->nodes->list ) {

        # Discard nodes that run their task yet.
        next if $has_run_task_of{$node};

        # Nodes with no parents will skip this for loop,
        # so their task will run before their children.
        for my $parent_node ( $node->parents ) {
            $node->off if $parent_node->is_off;

            # Wait until all parent nodes run.
            next RUN_TASKS if not exists $has_run_task_of{$parent_node};
        }

        # If node is on it will run its task.
        if ( $node->is_on ) {

            # Retrieve slot data coming from input edges.
            $_->task for ( $node->get_ins_edges );

            # Ok, now it's time to run node task:
            eval { $node->task }

              # if task sub return undef, turn off the node.
              or $node->off;

            # Remember that this node has run its task.
            $has_run_task_of{$node} = 1;
        }

        # Else node is off, so it looses the chance to run its task.
        else { $has_run_task_of{$node} = -1; }

    }

    # Check if all tasks run.
    for my $node ( $self->nodes->list ) {
        $has_run_task_of{$node} or goto RUN_TASKS;
    }

    # At this point all tasks are run so reset all slots "changed" flag.
    #for my $node ( $self->get_nodes ) {
    #    $_->set( changed => 0 ) for ( $node->get_inputs, $node->get_outputs );
    #}

    # Finally, run all sub scenarios tasks.
    $_->task for ( $self->scenarios->list );

    # TODO dovrei mettere un return piu significativo tipo return $self->ok
    return 1;
}

# TODO this method is EXPERIMENTAL, needs tests and code cleaning.
sub to_hash {
    my $self = shift;

    my $nodes_list = [];
    for my $node ( $self->nodes->list ) {
        push @{$nodes_list}, $node->to_hash;
    }

    # TODO prima dovrei prendere il SUPER to_hash
    # ad esempio PNI::Elem to_hash mi da l' id.
    return {
        id        => $self->id,
        nodes     => $nodes_list,
        edges     => 0,
        scenarios => 0,
    };
}

1;

__END__

=head1 NAME

PNI::Scenario - is a set of nodes connected by edges

=head1 SYNOPSIS

    # You can call the constructor to get a scenario ...
    use PNI::Scenario;
    $standalone_scenario = PNI::Scenario->new;

    # ... but it will not belong to PNI hierarchy tree,
    # so its task method will not be called, unless you call it.
    $standalone_scenario->task;

    # You can start adding a scenario to the PNI root.
    use PNI;
    my $scenario = PNI::root->add_scenario;

    # Add two nodes.
    my $foo = $scenario->add_node('Foo');
    my $bar = $scenario->add_node('Bar');

    # Connect nodes with an edge.
    $scenario->add_edge( $foo => $bar, 'out' => 'in' );

    # Calling PNI task method will execute all the tasks once.
    PNI::task;

    # Or call PNI loop to keep it running.
    PNI::loop;


=head1 DESCRIPTION

A scenario is a directed graph of subs called C<task>.

=head1 ATTRIBUTES

=head2 edges

    my @edges = $scenario->edges->list;

A L<PNI::Set> containing <PNI::Edge>s.

=head2 nodes

    my @nodes = $scenario->nodes->list;

A L<PNI::Set> containing <PNI::Node>s.

=head2 scenarios

    my @scenarios = $scenario->scenarios->list;

A L<PNI::Set> containing <PNI::Scenario>s.

=head1 METHODS

=head2 add_edge

=head2 add_node

=head2 add_scenario

    $sub_scenario = $scenario->add_scenario;

=head2 del_edge

=head2 del_node

=head2 del_scenario

=head2 task

    $scen->task;

Probably the most important PNI method. The task of a scenario is to trigger 
every node (and scenario) it contains to run its own task, following the natural order.

=head2 to_hash

    my $data_hashref = $scen->to_hash;

=cut

