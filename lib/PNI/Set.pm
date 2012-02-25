package PNI::Set;
use PNI::Mo;
extends 'PNI::Elem';

has elem => ( default => sub { +{} } );
has min  => ( default => sub { 0 } );
has max  => ( default => sub { 0 } );

sub add {
    my $self = shift;
    if ( $self->max ) {
        scalar( $self->list ) < $self->max or return;
    }
    my $elem = shift or return;
    $self->elem->{ $elem->id } = $elem;
}

sub del {
    my $self = shift;
    if ( $self->min ) {
        scalar( $self->list ) > $self->min or return;
    }
    my $elem = shift or return;
    delete $self->elem->{ $elem->id };
}

sub ids { keys %{ shift->elem } }

sub list { values %{ shift->elem } }

1
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

=head1 ATTRIBUTES

=head2 elem

Hash of elements contained in this L<PNI::Set>.

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

Return a list containing every C<id> of this set elements.

=head2 list

    my @elems = $set->list;

    my $num_elems = scalar( $set->list );

=cut

