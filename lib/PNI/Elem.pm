package PNI::Elem;
use Mo qw'default';
use Scalar::Util;

has id => ( default => sub { Scalar::Util::refaddr(shift) } );

1
__END__

=head1 NAME

PNI::Item - is a base class

=head1 ATTRIBUTES

=head2 id

=head1 METHODS

=cut

