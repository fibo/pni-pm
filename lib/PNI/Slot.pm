package PNI::Slot;
use PNI::Mo;
extends 'PNI::Elem';

use Scalar::Util;

has data => ();
has node => ();

sub is_array { return shift->type eq 'ARRAY' ? 1 : 0; }

sub is_code { return shift->type eq 'CODE' ? 1 : 0; }

sub is_defined { return defined( shift->data ); }

sub is_hash { return shift->type eq 'HASH' ? 1 : 0; }

sub is_number { return Scalar::Util::looks_like_number( shift->data ) ? 1 : 0; }

sub is_scalar { return shift->type eq 'SCALAR' ? 1 : 0; }

sub is_string {
    my $self = shift;

    $self->is_scalar or return 0;
    return $self->is_number ? 0 : 1;
}

sub is_undef { return shift->type eq 'UNDEF' ? 1 : 0; }

sub to_hashref {
    my $self = shift;

    return {
        id   => $self->id,
        data => $self->data
    };
}

sub type {
    my $data = shift->data;

    defined $data or return 'UNDEF';
    return ref $data || 'SCALAR';
}

1;

__END__

=head1 NAME

PNI::Slot - is a basic unit of data

=head1 SYNOPSIS

    my $slot = PNI::Slot->new;

    $slot->data('foo');

=head1 ATTRIBUTES

=head2 data

    my $data = $slot->data;

It can be a scalar or a reference.

=head2 node

    my $node = $slot->node;

Abstract attribute used by L<PNI::In> and L<PNI::Out> to hold a reference 
to its L<PNI::Node>.

=head1 METHODS

=head2 is_array

    $slot->data([qw(foo bar)]);
    $slot->is_array; # true

=head2 is_code

    $slot->data(sub { say 'hello'; });
    $slot->is_code; # true

=head2 is_defined

=head2 is_hash

    $slot->data({ foo => 'bar' });
    $slot->is_hash; # true

=head2 is_number

    $slot->data(0);
    $slot->is_number; # true

=head2 is_scalar

=head2 is_string

=head2 is_undef

=head2 to_hashref

    my $slot_hashref = $slot->to_hashref;

Returns an hash ref representing the slot.

=head2 type

Returns a string representing the slot data type, i.e. UNDEF, SCALAR or the
return value of C<ref> function applyed to the value of the C<data> attribute..

=cut

