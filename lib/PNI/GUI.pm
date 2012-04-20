package PNI::GUI;
use Mojo::Base 'Mojolicious';

use File::Basename 'dirname';
use File::Spec::Functions 'catdir';

use PNI::Finder;
my $find = PNI::Finder->new;

sub startup {
    my $self = shift;

    $self->home->parse( catdir( dirname(__FILE__), 'GUI' ) );
    $self->static->paths->[0]   = $self->home->rel_dir('public');
    $self->renderer->paths->[0] = $self->home->rel_dir('templates');

    my $r = $self->routes;
    $r->get('/')->to( cb => sub { shift->render('MainWindow') } );
    $r->get('/node_list')->to(
        cb => sub {
            my @node_list = $find->nodes;
            shift->render_json( \@node_list );
        }
    );

    $r->get('/scenario/create')->to('scenario#create');
    $r->get('/scenario/:scenario_id/')->to('scenario#to_json');
    $r->get('/scenario/:scenario_id/add_edge')->to('scenario#add_edge');
    $r->get('/scenario/:scenario_id/add_node')->to('scenario#add_node');
    $r->get('/scenario/:scenario_id/edge/:edge_id')->to('scenario#get_edge');
    $r->get('/scenario/:scenario_id/node/:node_id')->to('scenario#get_node');
    $r->get('/scenario/:scenario_id/slot/:slot_id')->to('scenario#get_slot');

}

1;

__END__

=head1 NAME

PNI::GUI - is a cool webapp

=head1 DESCRIPTION

It is a webapp implemented with L<Mojolicious> that let you use the Perl Node Interface.
Talking with MVC terms, code outside the PNI::GUI namespace builds the Model.
Perl code inside PNI::GUI belongs to the Controller, everything else (HTML/CSS/JavaScript) is part of the View. 

=head1 ROUTES

=cut

