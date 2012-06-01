use strict;
use warnings;

use UNIVERSAL::require;
PNI::Devel->require or plan( skip_all => 'PNI::Devel tests' );

use Test::More;
use Test::Pod::Coverage;

done_testing;

