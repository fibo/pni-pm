package PNI::Elem;
use PNI::Mo;
use Scalar::Util;

has id => ( default => sub { Scalar::Util::refaddr(shift) } );

1
__END__

=head1 NAME

PNI::Elem - is a base class

=head1 ATTRIBUTES

=head2 id

    $elem->id;

Used by L<PNI::Set> to identify the element.
Defaults to internal memory address of the object reference.

=head1 METHODS

This class has no method.

=cut

