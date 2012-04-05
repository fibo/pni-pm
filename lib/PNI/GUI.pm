package PNI::GUI;
use Mojo::Base 'Mojolicious';

use File::Basename 'dirname';
use File::Spec::Functions 'catdir';

use PNI;

sub startup {
    my $self = shift;

    $self->home->parse( catdir( dirname(__FILE__), 'GUI' ) );
    $self->static->paths->[0]   = $self->home->rel_dir('public');
    $self->renderer->paths->[0] = $self->home->rel_dir('templates');

    my $r = $self->routes;
    $r->get('/')->to( cb => sub { shift->render('MainWindow') } );
    $r->get('/node_list')->to(
        cb => sub {
            my @node_list = PNI->node_list;
            shift->render_json( [ PNI->node_list ] );
        }
    );

    $r->get('/scenario/root/add_node')->to('scenario#add_node');
    $r->get('/scenario/root')->to('scenario#to_json');

    # TODO $r->get('/scenario/:id/add_node')->to('scenario#add_node');

}

1;

__END__

=head1 NAME

PNI::GUI - is a cool webapp

=head1 DESCRIPTION

It is a webapp implemented with L<Mojolicious> that let you use the Perl Node Interface.
Talking with MVC terms, code outside the PNI::GUI namespace builds the Model.
Perl code inside PNI::GUI belongs to the Controller, everything else (HTML/CSS/JavaScript) is part of the View. 

=cut

