package PNI::Set;
use PNI::Mo;
extends 'PNI::Elem';

# TODO: change to this ... has elem => ( default => sub { return {}; } );
has elem => ( default => sub { +{} } );
has min  => ( default => sub { return 0; } );

# TODO perlcritic should complain
has max => ( default => sub { 0 } );

sub add {
    my $self = shift;
    if ( $self->max ) {
        scalar( $self->list ) < $self->max or return;
    }
    my $elem = shift or return;
    return $self->elem->{ $elem->id } = $elem;
}

# TODO consider to add ... sub cardinality { return scalar( shift->list ); }

sub del {
    my $self = shift;
    if ( $self->min ) {
        scalar( $self->list ) > $self->min or return;
    }
    my $elem = shift or return;
    return delete $self->elem->{ $elem->id };
}

sub ids { return keys %{ shift->elem } }

sub list { return values %{ shift->elem } }

# TODO ma devo mettere Return the element oppure Returns con la s ?

1;

__END__

=head1 NAME

PNI::Set - is a set of elements

=head1 SYNOPSIS

    my $set = PNI::Set->new;

    my $elem1 = PNI::Elem->new;
    $set->add($elem1);

    my $elem2 = PNI::Elem->new;
    $set->add($elem2);

    $set->list;    # ($elem1,$elem2)

    my $elem1_id = $elem1->id;
    $set->elem->{$elem1_id};     # $elem1

=head1 ATTRIBUTES

=head2 elem

    my $elem_hashref = $set->elem;

Hash of elements contained in this L<PNI::Set>.

    my $elem_foo = $set->elem->{'foo_id'};

=head2 min

Minimum number of elements: default is 0.

=head2 max

Maximum number of elements: default is 0, which means infinity otherwise 
it would be the empty set.

=head1 METHODS

=head2 add

    $set->add($elem);

Add a L<PNI::Elem> to this L<PNI::Set>.

=head2 del

    $set->del($elem);

Remove a L<PNI::Elem> from this L<PNI::Set>.

=head2 ids

    my @ids = $set->ids;

Return a list containing every C<id> of the elements cointained in the set.

=head2 list

    my @elems = $set->list;

Return a list containing every C<element> of the set.

=cut

