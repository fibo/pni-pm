use strict;
use warnings;
use Test::More tests=>2;
use PNI::Finder;

my $find  = PNI::Finder->new;

TODO :{
    local $TODO = 'implement find .pni files';
ok $find->files;
}

ok $find->nodes;

