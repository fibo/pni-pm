package PNI::Node;
use PNI::Mo;
extends 'PNI::Elem';
use PNI::In;
use PNI::Out;
use PNI::Rectangle;
use PNI::Set;

has _on => (default=>sub{1});
has box   => ( default => sub { PNI::Rectangle->new } );
has ins   => ( default => sub { PNI::Set->new } );
has label => ( default => sub { '' } );
has outs  => ( default => sub { PNI::Set->new } );
has type  => ( default => sub { __PACKAGE__ } );

sub get_ins_edges {
    grep { defined } map { $_->edge } shift->ins->list;
}

sub in {
    my $self = shift;
    my $id = shift || 'in';

    # If id is a number, prefix it with 'in'.
    $id =~ /^\d*$/ and $id = 'in' . $id;

    return $self->ins->elem->{$id}
      || $self->ins->add(
        PNI::In->new(
            node => $self,
            id   => $id,
        )
      );
}

sub is_on{shift->_on}

sub is_off{!shift->_on}

sub off{shift->_on(0)}

sub on{ shift->_on(1)}

sub out {
    my $self = shift;
    my $id = shift || 'out';

    # If id is a number, prefix it with 'out'.
    $id =~ /^\d*$/ and $id = 'out' . $id;

    return $self->outs->elem->{$id}
      || $self->outs->add(
        PNI::Out->new(
            node => $self,
            id   => $id,
        )
      );
}

sub get_outs_edges {
    map { $_->edges->list } shift->outs->list;
}

sub parents {
    map { $_->node } map { $_->source } shift->get_ins_edges;
}

sub task { 1 }

sub translate {
    my $self = shift;
    $_->translate(@_) for ( $self->box, $self->ins->list, $self->outs->list );
    return 1;
}

1
__END__

=head1 NAME

PNI::Node - is a basic unit of code

=head1 SYNOPSIS

    use PNI;

    my $node = PNI::node 'Foo::Bar';


    # Or use a scenario.

    my $scenario = PNI::root->new_scenario;
    my $node = $scenario->new_node( type => 'Foo::Bar' );


    # Or do it yourself (:

    use PNI::Node;

    my $empty_node = PNI::Node->new;

    # Decorate node.
    my $in = $empty_node->in('lead');
    my $out = $empty_node->out('gold');

    # Fill input data.
    $in->data('1Kg');

    # Produce something.
    $node->task;

    # Get output data.
    my $gold = $out->data;

=head1 ATTRIBUTES

=head2 box

=head2 ins

=head2 outs

=head1 METHODS

=head2 get_ins_edges

=head2 get_outs_edges

=head2 in

Creates an input by the given name if such input does not exists.

    $node->in('input_name');
    
Returns a L<PNI::In> object.

    my $in = $node->in('input_name');

Default input name is 'in', so you are really lazy you can do

    $node->in->data(1)

    say $node->in->data;

If you pass number x as input_name, it will be replaced by C<inx>.

    $node->in(1);
    $node->in('in1'); # ditto

=head2 is_off


=head2 is_off

=head2 off

Turn off a node if something is wrong.

    sub task {
        my $self=shift;
        # if "in" is not defined, return and turn off the node.
        $self->in->is_defined or return $self->off;
    }

=head2 on

=head2 label

=head2 out

Creates an output by the given name if such output does not exists.

    $node->out('output_name');
    
Returns a L<PNI::Out> object.

    my $out = $node->out('output_name');

Default output name is 'out', so you are really lazy you can do

    $node->out->data(1)

    say $node->out->data;

If you pass number x as output_name, it will be replaced by C<outx>.

    $node->out(1);
    $node->out('out1'); # ditto

=head2 parents

Returns the list of nodes which outputs are connected to the node inputs.

=head2 task

=head2 translate

=head2 type

=cut

