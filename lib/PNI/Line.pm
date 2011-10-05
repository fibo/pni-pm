package PNI::Line;
use PNI::Mo;
use PNI::Line;

has start => ( default => sub { PNI::Point->new } );
has end   => ( default => sub { PNI::Point->new } );

1
__END__

=head1 NAME

PNI::Line

=head1 ATTRIBUTES

=head2 start

=head2 end

=cut

