use strict;
use warnings;
use Test::More tests => 1;
use PNI::Comment;

my $comment = PNI::Comment->new;
isa_ok $comment , 'PNI::Comment';


