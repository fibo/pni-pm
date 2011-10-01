package PNI::Scenario;
use Mo;
extends 'PNI::Node';
use PNI::Edge;
use PNI::Node;
use PNI::Comment;
use PNI::Set;

has comments  => ( default => sub { PNI::Set->new } );
has edges     => ( default => sub { PNI::Set->new } );
has nodes     => ( default => sub { PNI::Set->new } );
has scenarios => ( default => sub { PNI::Set->new } );

sub new_comment {
    my $self    = shift;
    my $comment = PNI::Comment->new(@_);
    return $self->comments->add($comment);
}

sub new_edge {
    my $self = shift;
    my $edge = PNI::Edge->new(@_);
    return $self->edges->add($edge);
}

sub new_node {
    my $self = shift;
    my $type = {@_}->{type};

    # If type is not provided return a dummy node.
    if ( not defined $type ) {
        my $node = PNI::Node->new;

        return $self->nodes->add($node);
    }

    my $node_class = "PNI::Node::$type";
    my $node_path  = "$node_class.pm";
    $node_path =~ s/::/\//g;

    eval { require $node_path };

    my $node = $node_class->new(@_);

    # Set input data, if any
    #while ( my ( $slot_name, $slot_data ) = each %{ $arg->{inputs} or {} } ) {
    #    $node->get_input($slot_name)->set_data($slot_data);
    #}

    return $self->nodes->add($node);
}

sub new_scenario {
    my $self     = shift;
    my $scenario = PNI::Scenario->new(@_);
    return $self->scenarios->add($scenario);
}

sub del_comment {
    my $self    = shift;
    my $comment = shift;
    $self->comments->del($comment);
}

sub del_edge {

    #    my $self = shift;
    #    my $edge = shift or return;
    #
    #    $edge->source->del_edge($edge);
    #    $edge->target->del_edge;
    #
    #    $self->edges->del($edge);
}

sub del_node {

    #    my $self = shift;
    #    my $node = shift or return;
    #
    #    $self->del_edge($_) for $node->input_edges;
    #    $self->del_edge($_) for $node->output_edges;
    #
    #    $self->nodes->del($node);
}

sub del_scenario {

    #    my $self = shift;
    #    my $scenario = shift or return;
    #
    #    # Clean up all items contained in the scenario.
    #
    #    # Deleting a node deletes also the edges connected to it.
    #    $scenario->del_node($_) for $scenario->get_nodes;
    #
    #    # Deleting a scenario deletes also the nodes contained in it.
    #    $scenario->del_scenario($_) for $scenario->get_scenarios;
    #
    #    $self->scenarios->del($scenario);
}

sub task {

    # Here we go, this is one of the most important PNI subs.
    my $self = shift;

    my %has_run_task_of;

  RUN_TASKS:

    for my $node ( $self->nodes->list ) {

        # Discard nodes that run their task yet.
        next if $has_run_task_of{$node};

        my $node_can_run_task = 1;

        # Nodes with no parents will skip this for loop.
        # so their task will run before their children
        for my $parent_node ( $node->parents ) {

            # Wait until all parent nodes run.
            next RUN_TASKS if not exists $has_run_task_of{$parent_node};
        }

        # Retrieve slot data coming from input edges.
        $_->task for ( $node->input_edges );

        # Ok, now it's time to run node task.
        eval { $node->task };

        # Remember that node has run its task.
        $has_run_task_of{$node} = 1;
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
    $_->task for ( $self->get_scenarios );

    return 1;
}

1
__END__

=head1 NAME

PNI::Scenario - is a set of nodes connected by edges

=head1 SYNOPSIS

    use PNI;

    my $scenario = PNI::root->add_scenario;

    my $sub_sccenario = $scenario->add_scenario;


    # You can call the constructor to get a scenario ...

    use PNI::Scenario;
    $standalone_scenario = PNI::Scenario->new;

    # ... but it will not belong to PNI hierarchy tree,
    # so its task method will not be called.

=head1 ATTRIBUTES

=head2 comments

=head2 edges

=head2 nodes

=head2 scenarios

=head1 METHODS

=head2 new_comment

=head2 new_edge

=head2 new_node

=head2 new_scenario

=head2 del_comment

=head2 del_edge

=head2 del_node

=head2 del_scenario

=head2 task

=cut

