package    # Avoid PAUSE indexing.
  PNI::Node::File::Spec::Tmpdir;
use PNI::Node::Mo;
extends 'PNI::Node';

use File::Spec;

sub BUILD {
    my $self = shift;
    $self->label('tmpdir');
    my $out    = $self->out;
    my $tmpdir = File::Spec->tmpdir;
    $out->data($tmpdir);
}

1;

