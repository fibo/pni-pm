package PNI::Node;
use PNI::Mo;
extends 'PNI::Elem';

use PNI::Elem;

use PNI::In;
use PNI::Out;
use PNI::Set;

my %id_from_label_map;

has _on => ( default => sub { return 1; } );

has ins  => ( default => sub { return PNI::Set->new; } );
has outs => ( default => sub { return PNI::Set->new; } );
has type => ();
has x    => ();
has y    => ();

sub by_id {
    my $elem = PNI::Elem::by_id(@_);

    if ( defined $elem and $elem->isa('PNI::Node') ) {
        return $elem;
    }
    else {
        return;
    }
}

sub get_outs_edges {
    return map { $_->edges->list } shift->outs->list;
}

sub get_ins_edges {
    return grep { defined } map { $_->edge } shift->ins->list;
}

sub in {
    my $self = shift;
    my $label = shift || 'in';

    # If "label" is a number, prefix it with 'in'.
    $label =~ /^\d*$/ and $label = 'in' . $label;

    if ( my $id = $id_from_label_map{ $self->id }{$label} ) {
        return $self->ins->elem->{$id};
    }
    else {
        my $in = PNI::In->new(
            label => $label,
            node  => $self,
        );

        $self->ins->add($in);

        $id_from_label_map{ $self->id }{$label} = $in->id;

        return $in;
    }
}

sub is_off { return !shift->_on; }

sub is_on { return shift->_on; }

sub off { return shift->_on(0); }

sub on { return shift->_on(1); }

sub out {
    my $self = shift;
    my $label = shift || 'out';

    # If "label" is a number, prefix it with 'out'.
    $label =~ /^\d*$/ and $label = 'out' . $label;

    if ( my $id = $id_from_label_map{ $self->id }{$label} ) {

        return $self->outs->elem->{$id};
    }
    else {
        my $out = PNI::Out->new(
            label => $label,
            node  => $self,
        );

        $self->outs->add($out);

        $id_from_label_map{ $self->id }{$label} = $out->id;

        return $out;
    }
}

# This method is abstract.
sub task { }

sub to_hashref {
    my $self = shift;

    my @ins_to_hashref;
    for my $in_id ( $self->ins->ids ) {
        my $in = PNI::In::by_id($in_id);
        push @ins_to_hashref, $in->to_hashref;
    }

    my @outs_to_hashref;
    for my $out_id ( $self->outs->ids ) {
        my $out = PNI::Out::by_id($out_id);
        push @outs_to_hashref, $out->to_hashref;
    }

    # TODO risolvi la questione del tipo di dati in JSON
    my $x = $self->x;
    my $y = $self->y;
    $x += 0;
    $y += 0;

    return {
        id    => $self->id,
        label => $self->label,
        ins   => \@ins_to_hashref,
        outs  => \@outs_to_hashref,
        type  => $self->type,
        x     => $x,
        y     => $y,
    };
}

sub DESTROY {
    my $self = shift;

    $self->SUPER::DESTROY;

    delete $id_from_label_map{ $self->id };
}

1;

__END__

=head1 NAME

PNI::Node - is a basic unit of code

=head1 SYNOPSIS

    # Define "Foo::Bar" node.
    # in file PNI/Node/Foo/Bar.pm

    package PNI::Node::Foo::Bar;
    use PNI::Node::Mo;
    extends 'PNI::Node';

    sub BUILD {
        my $self = shift;

        # Decorate node, add an input and an output.
        $self->in('lead');
        $self->out('gold');

    }

    sub task {
        my $self = shift;

        my $in  = $self->in('lead');
        my $out = $self->out('gold');

        # Turn lead into gold.
        ...

          $out->data( $in->data );

    }

    1;

    # Somewhere else in your code.

    # Create a "Foo::Bar" node.
    use PNI::Node;
    my $node = PNI::Node->new( type => 'Foo::Bar' );

    my $in  = $node->in('lead');
    my $out = $node->out('gold');

    # Fill input data.
    $in->data('1Kg');

    # Produce something.
    $node->task;

    # Get output data.
    my $gold = $out->data;

=head1 ATTRIBUTES

=head2 ins

    my @ins = $node->ins->list;

Holds a L<PNI::Set> of <PNI::In>.

=head2 label

=head2 outs

    my @outs = $node->outs->list;

Holds a L<PNI::Set> of <PNI::Out>.

=head2 type

=head1 METHODS

=head2 by_id

    use PNI::Node;

    my $node = PNI::Node::by_id($node_id);

Given a node id, returns a reference to the node.

=head2 get_ins_edges

    my @ins_edges = $node->get_ins_edges;

Returns a list of all L<PNI::Edge> connected to node C<ins>.

=head2 get_outs_edges

    my @outs_edges = $node->get_outs_edges;

Returns a list of all L<PNI::Edge> connected to node C<outs>.

=head2 in

    $node->in('input_name');

Creates an input by the given name if such input does not exists.
    
    my $in = $node->in('input_name');

Returns a L<PNI::In> object.

    $node->in->data(1);
    say $node->in->data;

Default input name is 'in', so you can be lazy.

    $node->in(1);
    $node->in('in1'); # idem

If you pass digit C<x> as input_name, it will be replaced by C<inx>.

=head2 is_on

    $node->task if $node->is_on;

=head2 off

    $node->off;

Turn off a node if something is wrong.

    sub task {
        my $self = shift;

        # if "in" is not defined, return and turn off the node.
        $self->in->is_defined or return $self->off;
    }

=head2 on

=head2 out

    $node->out('output_name');

Creates an output by the given name if such output does not exists.

    my $out = $node->out('output_name');

Returns a L<PNI::Out> object.

    $node->out->data(1);
    say $node->out->data;

Default output name is 'out', so you can be lazy.

    $node->out(1);
    $node->out('out1'); # ditto

If you pass digit C<x> as output_name, it will be replaced by C<outx>.

=head2 task

    $node->task;

This is an abstract method that must be implemented by every class that extends L<PNI::Node>.
It is the chunk of code that the node implements.

=head2 to_hashref

    my $node_hashref = $node->to_hashref;

Returns an hash ref representing the node.

=cut

