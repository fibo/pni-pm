package PNI::Elem;
use PNI::Mo;

my %instance_map;
my $instance_counter = 0;

has id    => ();
has label => ();

sub BUILD {
    my $self = shift;

    my $id = ++$instance_counter;
    $self->id($id);
    $instance_map{$id} = $self;
}

sub by_id {
    my $id = shift or return;

    return $instance_map{$id};
}

sub DESTROY {
    my $self = shift;

    my $id = $self->id;

    delete $instance_map{$id};
}

1;

__END__

=head1 NAME

PNI::Elem - is a base class

=head1 ATTRIBUTES

=head2 id

    $elem->id;

Used by L<PNI::Set> to identify the element.
Defaults to internal memory address of the object reference.

=head2 label

=head1 METHODS

=head2 by_id

    use PNI::Elem;

    my $elem = PNI::Elem::by_id($elem_id);

Given an elem id, returns a reference to the elem.

=cut

