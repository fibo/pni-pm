package PNI::Node;
use Mo;
extends 'PNI::Elem';
use PNI::In;
use PNI::Out;
use PNI::Rectangle;
use PNI::Set;

has box  => ( default => sub { PNI::Rectangle->new } );
has ins  => ( default => sub { PNI::Set->new } );
has outs => ( default => sub { PNI::Set->new } );
has type => ( default => sub { __PACKAGE__ } );

sub new_in {
    my $self = shift;
    my $id   = shift;

    my $in = PNI::In->new(
        node => $self,
        id   => $id,
        @_
    );

    return $self->ins->add($in);
}

sub new_out {
    my $self = shift;
    my $id   = shift;

    my $out = PNI::Out->new(
        node => $self,
        id   => $id,
        @_
    );

    return $self->outs->add($out);
}

sub get_in {
    my $self = shift;
    my $in_id = shift or return;

    return $self->ins->elem->{$in_id};
}

sub get_ins_edges {
    grep { defined } map { $_->edge } shift->ins->list;
}

sub get_out {
    my $self = shift;
    my $out_id = shift or return;

    return $self->outs->elem->{$out_id};
}

sub get_outs_edges {
    grep { defined } map { $_->edges } shift->outs->list;
}

sub parents {
    map { $_->node } map { $_->source } shift->get_ins_edges;
}

sub task { 1 }

sub translate {
    my $self = shift;
    $_->translate(@_) for ( 
$self->box,
$self->ins->list, 
$self->outs->list 
);
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
    my $in = $empty_node->new_in('in');
    my $out = $empty_node->new_out('out');

    $node->task;


=head1 ATTRIBUTES

=head2 box

=head2 ins

=head2 outs

=head1 METHODS

=head2 get_ins_edges

=head2 get_outs_edges

=head2 get_in

=head2 get_out

=head2 new_in

=head2 new_out

=head2 parents

Returns the list of nodes which outputs are connected to node inputs.

=head2 task

=head2 translate

=cut

