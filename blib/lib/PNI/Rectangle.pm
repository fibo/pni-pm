package PNI::Rectangle;
use Mo;
use PNI::Point;

has center => ( default => sub { PNI::Point->new } );
has height => ( default => sub { 0 } );
has width  => ( default => sub { 0 } );

sub translate {
    my $self = shift;
    my ( $x, $y ) = @_ or return;
    $self->center->x($x);
    $self->center->y($y);
}
1
__END__

=head1 NAME

PNI::Rectangle

=head1 ATTRIBUTES

=head2 center

=head2 height

=head2 width

=head1 METHODS 

=head2 translate

=cut

