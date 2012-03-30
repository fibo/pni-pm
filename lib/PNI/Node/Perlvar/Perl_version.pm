package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Perl_version;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('$PERL_VERSION');
    $self->out->data($^V);
}

1;
