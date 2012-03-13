package PNI::Node::File::Spec::Catfile;
use PNI::Node::Mo;
extends 'PNI::Node';

use File::Spec;

sub BUILD {
    my $self = shift;
    $self->label('catfile');
    my $directories = $self->in('directories');
    my $filename    = $self->in('filename');
    my $out         = $self->out('path');
}

sub task {
    my $self        = shift;
    my $directories = $self->in('directories');
    my $filename    = $self->in('filename');

    $filename->is_scalar or return $node->off;
    $directories->is_array or $directories->is_scalar or return $node_off;
    $self->out('path')
      ->data( File::Spec->catfile( @{ $directories->data }, $filename->data ) );
}

1
