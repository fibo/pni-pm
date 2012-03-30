package PNI::Slot;
use PNI::Mo;
extends 'PNI::Elem';

use Scalar::Util;

has data => ();
has node => ();

sub is_array { return shift->type eq 'ARRAY' ? 1 : 0 }

sub is_code { return shift->type eq 'CODE' ? 1 : 0 }

sub is_defined { return shift->type eq 'UNDEF' ? 0 : 1 }

sub is_hash { return shift->type eq 'HASH' ? 1 : 0 }

sub is_number { return Scalar::Util::looks_like_number( shift->data ) ? 1 : 0 }

sub is_scalar { return shift->type eq 'SCALAR' ? 1 : 0 }

sub is_string {
    my $self = shift;
    $self->is_scalar or return 0;
    return $self->is_number ? 0 : 1;
}

sub is_undef { return shift->type eq 'UNDEF' ? 1 : 0 }

sub type {
    my $data = shift->data;
    defined $data or return 'UNDEF';
    return ref $data || 'SCALAR';
}

1;

__END__

=head1 NAME

PNI::Slot - is a basic unit of data

=head1 ATTRIBUTES

=head2 data

=head2 node

=head1 METHODS

=head1 is_array

=head1 is_code

=head1 is_defined

=head1 is_hash

=head1 is_number

=head1 is_scalar

=head1 is_string

=head1 is_undef

=head2 translate

=head2 type

Returns a string representing the slot data type, i.e. UNDEF, SCALAR or the
return value of C<ref> function.

=cut

