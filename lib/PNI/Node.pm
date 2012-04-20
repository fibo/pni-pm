package PNI::Node;
use PNI::Mo;
extends 'PNI::Elem';

use PNI::In;
use PNI::Out;
use PNI::Set;

has _on => ( default => sub { 1 } );

has ins => ( default => sub { PNI::Set->new } );
has label => ();
has outs  => ( default => sub { PNI::Set->new } );
has type  => ();

# TODO documenta  aggiungi test per x e y: anche se sono attributi grafici devo metterli nel model
#       per fare in modo che in futuro un' altra persona che sta editando la patch possa
#       vedere i cambiamenti, cioe che sia collaborativa, questo perchè il controller potrebbe interrogare
#       un' istanza di PNI su un' altra macchina ... AD OGNI MODO RISULTA PIU FACILE COSI (mi sembra anche piu logico ... cosa diranno
#       i puristi dei pattern ? :)
#
has x => ( default => sub { 0 } );
has y => ( default => sub { 0 } );

sub get_outs_edges {
    return map { $_->edges->list } shift->outs->list;
}

sub get_ins_edges {
    return grep { defined } map { $_->edge } shift->ins->list;
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

sub is_off { return !shift->_on; }

sub is_on { return shift->_on; }

sub off { return shift->_on(0); }

sub on { return shift->_on(1); }

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

# This method is abstract.
sub task { die; }

# TODO this method is EXPERIMENTAL, needs tests and code cleaning.
sub to_hash {
    my $self = shift;

    my @ins_list;
    for my $in ( $self->ins->list ) {
        push @ins_list, $in->id;
    }

    my @outs_list;
    for my $out ( $self->outs->list ) {
        push @outs_list, $out->id;
    }

    return {
        id    => $self->id,
        label => $self->label,
        type  => $self->type,
        ins   => \@ins_list,
        outs  => \@outs_list,
        x     => $self->x,
        y     => $self->y,
    };
}

1;

__END__

=head1 NAME

PNI::Node - is a basic unit of code

=head1 SYNOPSIS

    # Create a node in a scenario.
    use PNI::Scenario;
    my $scen = PNI::Scenario->new;
    my $node = $scenario->add_node( type => 'Foo::Bar' );

    # Decorate node, add an input and an output.
    my $in = $node->in('lead');
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

=head2 to_hash

    my $data_hashref = $node->to_hash;

=cut

