use strict;
use warnings;
use File::HomeDir;
use Path::Class;
use PNI::Home;
use Test::More tests => 2;

my $home   = PNI::Home->new;
isa_ok $home,'PNI::Home';

my $home_path=dir(File::HomeDir->my_home)->subdir('.pni');
is $home->path,$home_path;




