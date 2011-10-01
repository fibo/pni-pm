package PNI::Point;
use Mo;

has x => ( default => sub { 0 } );
has y => ( default => sub { 0 } );

sub translate {
    my $self = shift;
    my ( $dx, $dy ) = @_;
    my ( $x, $y ) = ( $self->x, $self->y );
    $self->x( $x + $dx );
    $self->y( $y + $dy );
}

1
__END__

=head1 NAME

PNI::Point

=head1 ATTRIBUTES

=head2 x

=head2 y

=head2 METHODS

=head1 translate

=cut

